#!/bin/sh
a=`pwd`
rm ~/.vimrc
ln -s $a/.vimrc ~/.vimrc
rm ~/.Xresources
ln -s $a/.Xresources ~/.Xresources
rm ~/.procmeterrc
ln -s $a/.procmeterrc ~/.procmeterrc
rm ~/.fvwm/.fvwm2rc
ln -s $a/fvwm/.fvwm2rc ~/.fvwm/.fvwm2rc
ln -d -sf $a/fvwm/images ~/.fvwm/images 
ln -d -sf $a/fvwm/themes ~/.fvwm/themes 
ln -d -sf $a/fvwm/wallpapers ~/.fvwm/wallpapers
