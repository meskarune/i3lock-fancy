i3lock-fancy
============

This is an i3lock bash script that takes a screenshot of the desktop, blurs the background and adds a lock icon and text

website: [github pages website](http://meskarune.github.io/i3lock-fancy/)

![screen shot of lockscreen](https://raw.githubusercontent.com/meskarune/i3lock-fancy/master/screenshot.png)

Dependancies
------------
* <s>[i3lock-color-git](https://github.com/eBrnd/i3lock-color)</s>
* [i3lock-color-git](https://github.com/Arcaena/i3lock-color) - this is a fork of i3lock-color that is kept up to date with i3lock
* imagemagick
* scrot
* bash
* awk
* utils-linux

Installation
------------

Installation
------------

To install i3lock-fancy-dualmonitor manually, git clone the repository, checkout
the dual monitors branch and run the make file.:

    git clone https://github.com/meskarune/i3lock-fancy.git
    cd i3lock-fancy
    git checkout i3lock-fancy-dualmonitors
    sudo make install

**IMPORTANT NOTE: the way to install i3lock-fancy has changed! If you are a
package maintainer or previously installed manually you may have to review
and update your configurations. The new change simplifies a lot of
things so updates will be easier in the future.**

Usage
-----

    lock [options]

    Options:
        -h, --help   This help menu.
        -g, --greyscale  Set background to greyscale instead of color.
        -p, --pixelate   Pixelate the background instead of blur, runs faster.
        -f <fontname>, --font <fontname>  Set a custom font. Type 'convert -list font' in a terminal to get a list.

example: ```lock -gpf Comic-Sans-MS```

Extras
------

The lock screen in action:

![lockscreen animation](https://raw.githubusercontent.com/meskarune/i3lock-fancy/master/action.gif)

Use this with xautolock to automatically lock the screen after a set time.

Systemd Unit file (edit for your own use):

    [Unit]
    Description=Lock the screen automatically after a timeout
    
    [Service]
    Type=simple
    User=meskarune
    Environment=DISPLAY=:0
    ExecStart=/usr/bin/xautolock -time 5 -locker /usr/bin/i3lock-fancy-dualmonitor -detectsleep
    
    [Install]
    WantedBy=graphical.target
