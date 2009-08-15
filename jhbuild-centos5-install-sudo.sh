#!/bin/bash
# install Development groups
sudo yum groupinstall "Development Tools"
sudo yum groupinstall "X Software Development"
sudo yum groupinstall "GNOME Software Development"
sudo yum install perl-XML-Parser bzip2-devel

# Install additional repositories
sudo yum install yum-priorities
# Install of RPMforge repository
sudo rpm --import http://dag.wieers.com/rpm/packages/RPM-GPG-KEY.dag.txt
wget http://apt.sw.be/redhat/el5/en/i386/RPMS.dag/rpmforge-release-0.3.6-1.el5.rf.i386.rpm
rpm -K rpmforge-release-0.3.6-1.el5.rf.*.rpm
sudo rpm -i rpmforge-release-0.3.6-1.el5.rf.*.rpm
rm rpmforge-release-0.3.6-1.el5.rf.*.rpm
echo Autorisation root:
su -c 'echo priority=11 >> /etc/yum.repos.d/rpmforge.repo'
# Verify priorities
sudo yum check-update
# Install detaching consoles
sudo yum install dtach
# Install compiler cache
sudo yum install ccache

# Install Git 1.6.1 build dependencies
sudo yum install gettext-devel expat-devel curl-devel zlib-devel openssl-devel
# Documentation dependencies
# docbook-style-xsl-1.69.1-5.1 installed is buggy :(
# so documentation can't be built
#sudo yum install asciidoc xmlto

# Create GNOME build directory
sudo mkdir -p /opt/gnome2
sudo chown gnome: /opt/gnome2

#sudo chown -R $USER /usr/local/
