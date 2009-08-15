#!/bin/bash
# this small script needs NIXPKGS_ALL to be set to the path of all-packages.nix
# in a NIXPKGS repository
# then it takes the svn revision + repo state and caches the output of
# nix-env -qa \* -P
 
revhash(){
  if [ -d $NIXPKGS_ALL/.svn ]; then
    rev=`svn info $NIXPKGS_ALL | grep R.vision.: | cut -d ' ' -f 2`
    type=svn
#  elif [ -d .git ]; then
#    rev=`git rev-parse --verify HEAD`
#    hash=$(git diff | md5sum | sed 's/ .*//' )
#    type=git
  else
    echo unkown repo type in $NIXPKGS_ALL
    exit 1
  fi
}
echo $NIXPKGS_ALL
 
revhash
mkdir -p /nix/var/search-cache/
tmp="/nix/var/search-cache/$type-$rev-cache"
echo cachefile is $tmp
 
[ -f "$tmp" ] || {
  echo -n refreshing cache ...
  # --out-path 
  nix-env -qa \* -P -f $NIXPKGS_ALL/all-packages.nix > $tmp || { rm $tmp; echo "error"; exit 1; }
  echo done
}
grep -i $1 $tmp
