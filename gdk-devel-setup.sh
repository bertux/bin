#!/bin/bash
# exemples from https://wiki.foresightlinux.org/display/DEV/HOWTO+setup+a+2.x+build+environment
sudo conary update foresight-contexts=/foresight.rpath.org@fl:2-devel
# 2. copy that example .conaryrc and put your name, email, password there

# 2.1 then append http://dpaste.com/47846/ to ~/.conaryrc

# 3. copy that example .rmakerc

# 3.1 append http://dpaste.com/47836/ to ~/.rmakerc

# 4 create the dirs
mkdir -p ~/conary/foresight.rpath.org ~/conary/builds ~/conary/cache ~/conary/bertux

# 4.1 set up the gnome context
mkdir -p ~/conary/gnome/trunk
cd ~/conary/gnome/trunk
cvc context gnome:trunk

# 4.2 you should also set up the other contexts, though they are irrelevant to the devkit:
cd ~/conary/foresight.rpath.org
cvc context fl:2-devel
cd ~/conary/bertux
cvc context bertux
