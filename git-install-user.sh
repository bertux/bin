#!/bin/bash
# Install Git 1.6.1
mkdir ~/src/
cd ~/src/
wget http://kernel.org/pub/software/scm/git/git-1.6.3.1.tar.bz2
tar xvjf git-1.6.3.1.tar.bz2
cd git-1.6.3.1
make
make install
# docbook-style-xsl-1.69.1-5.1 installed is buggy :(
# so documentation can't be built
#make man
#make install-man
git --version

