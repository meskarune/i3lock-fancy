i3lock-fancy
============

This is an i3lock bash script that takes a screenshot of the desktop, blurs the background and adds a lock icon and text

website: [github pages website](http://meskarune.github.io/i3lock-fancy/)

![screen shot of lockscreen](https://raw.githubusercontent.com/meskarune/i3lock-fancy/master/screenshot.png)

Dependancies
------------
* [i3lock-color-git](https://github.com/eBrnd/i3lock-color)
* imagemagick
* scrot
* Liberation Fonts

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
