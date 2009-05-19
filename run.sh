#!/bin/sh
a=`pwd`
rm -f ~/.vimrc
ln -s $a/.vimrc ~/.vimrc
rm -f ~/.Xresources
ln -s $a/.Xresources ~/.Xresources
rm ~/.procmeterrc
ln -s $a/.procmeterrc ~/.procmeterrc
rm -f ~/.fvwm/.fvwm2rc
ln -s $a/fvwm/.fvwm2rc ~/.fvwm/.fvwm2rc
ln -d -sf $a/fvwm/images ~/.fvwm/images 
ln -d -sf $a/fvwm/themes ~/.fvwm/themes 
ln -d -sf $a/fvwm/wallpapers ~/.fvwm/wallpapers
rm -f ~/.fbpanel/default
rm -f ~/.fbpanel/cpuperf.sh
mkdir -p ~/.fbpanel
ln -s $a/fbpanel/default ~/.fbpanel/default
ln -s $a/fbpanel/cpuperf.sh ~/.fbpanel/cpuperf.sh
