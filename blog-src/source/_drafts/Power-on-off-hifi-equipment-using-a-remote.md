---
title: Power on & off hifi equipment using a remote
permalink: how-to-control-mains-power-for-hifi-equipment-using-raspberry-pi
id: 16
updated: '2017-07-29 10:09:43'
tags:
---

Get a relay  like [this one](http://www.dx.com/p/arduino-2-channel-relay-shield-module-red-144140). I got a two channel one because I wanted to control two separate devices - the TV and some active speakers. Get a single channel one if you just want to to turn on/off one device. Insert the relay into an [extension](http://www.amazon.in/Philips-Surge-Spike-Guard-Metres/dp/B00TIJXCLI). I had to block off one socket to make room. Carefully rewire the sockets so they go via the relays. Make sure you connect mains across the normally open points on the relay.


With the mains power isolated within the extension board I made a small opening and routed jumper cables out of the extension. The cables were connected to the pins on the relay and the other ends I connected these to the Raspberry pi's +5v, GND and GPIO 4, 17.

I then wrote two small python scripts to toggle power for the speakers and the TV. 

I programmed my flirc USB to fire off f6 and f7 when red and green buttons on the tv remote are pressed and plugged it into the rpi.

To have the rpi run the python scripts automatically when f6/f7 are pressed I had two options -- 

xbindkeys
This was dead easy to configure. I pasted the following in ~/.xbindkeysrc and I was done -

    # toggle speakers
    "python2 speakerstoggle.py"
        Mod2 + F7

    # toggle tv
    "python2 tvtoggle.py"
        Mod2 + F6

run `xbindkeys; xbindkeys` to reload xbindkeys.

On the downside. This app needs x server running. This is wasted resource on a headless computer. 

I also couldn't figure out how to run `startx` on boot automatically. 

triggerhappy
This is a daemon written for exactly my use case. Underpowered systems running in headless mode. The challenge was actually installing and getting it running on runeaudio(Archlinux based).

After a number of tries and reinstalls this is what worked for me - 

- `pacman -Sy`  - update the repos
- `pacman -S guile make gcc` install dependencies and build tools
- `git clone https://github.com/wertarbyte/triggerhappy`
- `cd triggerhappy`
- `make`
- `make install`

I then uninstalled gcc and make since they were causing the pi to boot up very slowly. 
 
    pacman -Rns gcc make

I created a file /etc/triggerhappy/triggers.d/tv-speakers.conf (you can name this anything. All files from the folder are loaded by triggerhappy) and pasted the following - 

    KEY_F6 1 python2 /root/tvtoggle.py
    KEY_F7 1 python2 /root/speakerstoggle.py

you can test keycodes by running `thd -d /dev/input/*`

For some reason triggerhappy did not create a service for itself. I created one by creating a file called triggerhappy.service in /etc/systemd/system/ . I pasted the following in the file -

```
[Unit]
Description=triggerhappy global hotkey daemon
After=local-fs.target

[Service]
Type=notify
ExecStart=/usr/sbin/thd --triggers /etc/triggerhappy/triggers.d/ --socket /run/$

[Install]
WantedBy=multi-user.target

```

and to enable the service 

`systemctl enable triggerhappy.service`

All done!
