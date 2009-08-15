#!/bin/bash

# gnome should owns the /opt directory to create subdirectories
sudo chown gnome: /opt

# install essential build tools
sudo aptitude install build-essential ccache flex bison python-dev

# install VCS tools
sudo aptitude install subversion git-core cvs

# to solve msgfmt : unknown command
sudo aptitude install gettext

# sanitycheck asks for
sudo aptitude install libtool pkg-config docbook-utils autoconf automake1.4 automake1.7 automake1.9 docbook-xsl docbook-xml libxml-parser-perl cvs

# for xmlcatalog used by gtk-doc which uses python module libxml2
sudo aptitude install libxml2-utils gnome-doc-utils docbook docbook-utils docbook-xsl

# pci.ids for hal
sudo aptitude install hwdata pciutils

# gperf for WebKit
sudo aptitude install gperf libicu-dev

# libsexy-dev for gnome-disk-utility
sudo aptitude install libsexy-dev

# libxrandr-dev for gnome-desktop
sudo aptitude install libxrandr-dev

# libvorbisfile3 for libcanberra
sudo aptitude install libvorbisfile3

# automake (1.10.2) for libgnomekbd
sudo aptitude install automake

# libsasl2-dev for ekiga
sudo aptitude install libsasl2-dev

# python-gst0.10-dev for telepathy-farsight
sudo aptitude install python-gst0.10-dev

# liblcms1-dev for poppler
sudo aptitude install liblcms1-dev

# libpst-dev for evolution
sudo aptitude install libpst-dev

# mesa-common-dev for clutter
sudo aptitude install mesa-common-dev

# libasound2-dev for swfdec
sudo aptitude install libasound2-dev

# previous ubuntu versions dependencies
sudo aptitude install gnome-common doxygen texinfo lynx mono-gmcs libtiff4-dev libxtst-dev libgdbm-dev libxml-simple-perl libelfg0-dev libcupsys2-dev libldap2-dev libexchange-storage1.2-dev libxmu-dev libpam0g-dev libgpgme11-dev libfreetype6-dev libpng12-dev libxrender-dev libxi-dev libexpat1-dev libbz2-dev firefox-dev libxcursor-dev guile-1.8-dev libxdamage-dev libxcomposite-dev libmono-cairo2.0-cil xnest libxft-dev libloudmouth1-0 libloudmouth1-dev libxss-dev libxkbfile-dev gtk-doc-tools libjasper-dev libnl-dev ppp-dev libdv4-dev uuid-dev libpcre3-dev libsqlite3-dev libpurple-dev libcurl4-gnutls-dev libxul-dev
