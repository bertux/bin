#!/bin/bash
#
# Copyright (C) 2008 Ken VanDine <ken@vandine.org>
#
# Licensed under the GNU General Public License Version 2
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.

usage()
{
    echo "usage: refresh-gnome [update|build]"
    exit
}

if [ $# -lt 1 ];
then
    usage
fi

if [ ! "$1" = "update" ] && [ ! "$1" = "build" ];
then
    usage
fi

action=$1
workingDir=$HOME/conary/gnome/trunk
currentDir=`pwd`
context="gnome:trunk"

troves=`sort all-modules blacklist | uniq --unique`
echo Current blacklist includes:
cat blacklist
echo

if [ $action = "update" ];
then
    echo --Updating...
    cd $workingDir
    echo $troves | xargs cvc co
    for trove in $troves;
    do
        case $trove in
            GConf)
                module="gconf"
                ;;
            glade)
                module="glade3"
                ;;
            gtk)
                module="gtk+"
                ;;
            *)
                module=$trove
                ;;
            esac
        latestVersion=`
            conary rq $trove:source=gnome.rpath.org@gnome:trunk --labels |
            awk -F '/' '{print $2}' |
            awk -F '-' '{print $1}'`
        # use '/bin/grep' to avoid user defined alias
        latestRevision=`
            /usr/bin/git ls-remote --heads git://git.gnome.org/$module |
            /bin/grep 'refs/heads/master' |
            awk '{print $1}'`
        # keep aligned with gnomepackage;
        # now use 4 chars from revison as version
        latestRevision=r${latestRevision:0:4}
        printf "Latest version  of %-20s in conary is:%15s\n" $trove  $latestVersion
        printf "Latest revision of %-20s in git    is:%15s\n" $module $latestRevision
        revision_in_conary=`echo $latestVersion | cut -f2 -d '+'`
        if [ "${revision_in_conary:0:5}" != "$latestRevision" ]
        then
            echo "refreshing $trove"
            cd $trove
            cvc refresh >/dev/null 2>&1 || echo "error refreshing $trove"
            cvc commit --message "New snapshot" >/dev/null 2>&1 ||
                echo "error committing $trove"
            cd - >/dev/null 2>&1
        fi
    done
    cd $currentDir

elif [ $action = "build" ];
then
    echo --Building...
    tobuild=""
    for trove in $troves;
    do
        latestBuiltVersion=`
            conary rq $trove=gnome.rpath.org@gnome:trunk[is:x86] --labels |
            awk -F '/' '{print $2}'|
            awk -F '-' '{print $1}'`
        latestSourceVersion=`
            conary rq $trove:source=gnome.rpath.org@gnome:trunk --labels |
            awk -F '/' '{print $2}' |
            awk -F '-' '{print $1}'`
        if [ -z $latestSourceVersion ] || [ -z $latestBuiltVersion ]
        then
            echo "Either source or binary version is unknown"
            tobuild="$tobuild $trove"
        elif [ $latestSourceVersion != $latestBuiltVersion ]
        then
            printf "Latest source version of %-10s is: %12s\n" $trove $latestSourceVersion
            printf "Latest built  version of %-10s is: %12s\n" $trove $latestBuiltVersion
            tobuild="$tobuild $trove"
        fi
    done

    echo "building $tobuild"
    jobId=`echo $tobuild | xargs rmake build --quiet --no-watch --context $context`

    echo "Your Job ID is $jobId"
    while [ "$status" != "Built" ] && [ "$status" != "Failed" ];
    do
        sleep 300
        status=`rmake q $jobId | grep "^$jobId" | awk '{print $2}'`
    done
    if [ $status = "Built" ];
    then
        rmake commit $jobId
    else
        echo "Build $jobId Failed"
        rmake commit $jobId
    fi
fi

