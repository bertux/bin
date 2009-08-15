#!/bin/bash
# patch jhbuild command tinderbox to store tinderbox_outputdir instead of outputdir
sed -i -e "s/dest='outputdir'/dest='tinderbox_outputdir'/" ~/checkout/gnome2/jhbuild/jhbuild/commands/tinderbox.py
