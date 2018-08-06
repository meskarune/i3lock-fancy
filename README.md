i3lock-fancy
============

This is an i3lock bash script that takes a screenshot of the desktop, blurs the background and adds a lock icon and text

website: [github pages website](http://meskarune.github.io/i3lock-fancy/)

![screen shot of lockscreen](https://raw.githubusercontent.com/meskarune/i3lock-fancy/master/screenshot.png)

Dependencies
------------
* <s>[i3lock-color-git](https://github.com/eBrnd/i3lock-color)</s>
* [i3lock-color-git](https://github.com/PandorasFox/i3lock-color) - this is a fork of i3lock-color that is kept up to date with i3lock
* imagemagick
* bash
* awk
* util-linux

Optional Dependencies
---------------------
* wmctrl
* a screenshot utility such as scrot or maim.

Installation
------------
* Arch Linux Package: https://aur.archlinux.org/packages/i3lock-fancy-git/
* GNU Guix: Run `guix package --install i3lock-fancy`
* GNU GuixSD: Define a screenlocker service in your system config to use. For example `(screen-locker-service i3lock-color "i3lock")` for i3lock-color, and add 'i3lock-fancy' to your global profile (or user profile).
* From source: git clone the repository and copy lock and /icons to "/usr/local/bin"

Usage
-----

    i3lock-fancy [options]
    
    Options:
        -h, --help       This help menu.
    
        -d, --desktop    Attempt to minimize all windows before locking. Requires wmctrl.
    
        -g, --greyscale  Set background to greyscale instead of color.
    
        -p, --pixelate   Pixelate the background instead of blur, runs faster.
    
        -f <fontname>, --font <fontname>  Set a custom font.
    
        -t <text>, --text <text> Set a custom text prompt.

        -l, --listfonts  Display a list of possible fonts for use with -f/--font.
                         Note: this option will not lock the screen, it displays
                         the list and exits immediately.

        -n, --nofork     Do not fork i3lock after starting.
    
        --               Must be last option. Set command to use for taking a
                         screenshot. Default is 'import -window root'. Using 'scrot'
                         or 'maim' will increase script speed and allow setting
                         custom flags like haing a delay.

example: ```i3lock-fancy -gpf Comic-Sans-MS -- scrot -z```

Extras
------

The lock screen in action:

![lockscreen animation](https://raw.githubusercontent.com/meskarune/i3lock-fancy/master/action.gif)

To use this script you can set a hotkey in your window manager to run the lock command,
set xautolock to run at boot, or use a systemd script to either lock on suspend or run xautolock.

xautolock is a utility to automatically lock the screen after a set time. It also 
supports hot corners.

Systemd Unit file example (edit for your own use):

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
