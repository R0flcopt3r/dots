# dots

This is a collection of my various dotfiles. I use this on a desktop and laptop,
and to avoid certain issues I have two seperate folders with configs that can't
be shared across.

Each program have one folder for their config files.

## Install

The `install.sh` script works with two functions, `dot()` and `folder()`.

Firstly the scripts sets the `$chassis` variable to determine if your computer
is a laptop or a desktop. Then sets the `$XDG_CONFIG_HOME` variable if it isn't
already set. 

`dot()` checks if the config file you wish to link already exists as a symbolic
link or as a regular file. If it's a symbolic links, it assumes all is well and
skips it, if it's a regular file, it will delete it and link it in it's place. 

`folder()` checks to see if a config folder doesn't exist, and if so, creates
it. 

## future:

In the future I want a switch to forcefully relink every file, and also specific
ones. I also want to make it a bit more automated, having you edit a "config
file", basically a list, to add new configs.

I would also like to split up config files to make it easier to deal with
multiple systems that aren't compatible. Currently I have this issue with my
desktop running Fedora and my laptop running Ubuntu, but just keeping i3wm and
i3blocks seperate works for now.
