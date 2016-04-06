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
Arch Linux Package: https://aur.archlinux.org/packages/i3lock-fancy-git/

git clone the repository and copy lock, lock.png and lockdark.png to
"/usr/local/bin"

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
    ExecStart=/usr/bin/xautolock -time 5 -locker /usr/local/bin/lock/lock -detectsleep
    
    [Install]
    WantedBy=graphical.target

Multiple Monitors
-----------------
There is a branch called dual monitor with support for multiple monitors. This
branch uses a grey icon and text with outlines to make it visible on light and
dark backgrounds (though it looks better on dark backgrounds). I am still
working to get it looking just right right. The script is usable now, but it's
under developement and things may change.
