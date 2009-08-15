#!/bin/bash

# Create GNOME build directory
mkdir -p /opt/gnome2

# checkout jhbuild from git repo
mkdir -p ~/checkout/gnome2
cd ~/checkout/gnome2
git clone git://git.gnome.org/jhbuild

# Install of jhbuild
cd jhbuild
make -f Makefile.plain install bindir=~/bin datarootdir=~/share
cp jamesh.jhbuildrc ~/.jhbuildrc
# Disable repos accounts
sed -i -e 's/^repos/#repos/' ~/.jhbuildrc
sed -i -e "s|^prefix = .*$|prefix = '/opt/gnome2'|" ~/.jhbuildrc
sed -i -e "s|^checkoutroot = .*$|checkoutroot = os.path.expanduser('~/checkout/gnome2')|" ~/.jhbuildrc
sed -i -e 's/--enable-maintainer-mode //' ~/.jhbuildrc
echo "tinderbox_outputdir = os.path.expanduser('~/logs')" >> ~/.jhbuildrc

# Check of jhbuild
jhbuild sanitycheck
jhbuild -m bootstrap buildone waf

# Use of jhbuild
#nohup jhbuild --no-interact build > ~/jhbuild.log
nohup jhbuild --no-interact tinderbox > /var/log/jhbuild/nohup.out &
