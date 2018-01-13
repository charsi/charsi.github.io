---
title: Setting up OMV on your NAS
permalink: setting-up-omv-on-your-nas
id: 12
updated: '2017-04-26 07:08:57'
tags:
---

I recently moved from WHS 2011 to OMV for my N40L which I use as a NAS box. 

On WHS apart from standard file sharing I also had the following things set up --
Flexraid (Snapshot RAID 5 like protection)
Drivepool
Plex 
Utorrent

On OMV, to get the same kind of functionality I installed the following -
Snapraid
Mergerfs
Plex
Transmission

and a few others which I don't strictly need 
Couchpotato
Sickbeard
NZBget

This is a write up of me recounting the steps I took. But first the TLDR version -

### TLDR;
- Install OMV
- Install the required plugins
- Done

## Installing OMV
- Download the image from [here](https://sourceforge.net/projects/openmediavault/files/2.1/). Go for the 64 bit if your computer supports it.
- Now create a USB drive using the iso file. 
 * On Linux :  `sudo dd if=xxx.iso of=/dev/sdX bs=4096` where `/dev/sdX` is the path to your USB drive. 
 * On Windows : Use [unetbootin](http://unetbootin.github.io/)
- Prepare the computer you want to install OMV on. Shut it down and unplug all drives except the one you want to install OMV on.
- Plug in the installation USB and boot from it. This might happen automatically or else change the boot order in the BIOS. Some systems also let you choose on each boot by pressing Esc or F12.
- Go through the menus to install OMV and restart when done.

OPTIONAL: OMV runs happily with just a 20GB partition. If you are using a larger drive for it you might want to repartition it after installation. To do this use a Ubuntu live CD or similar. Resize the ext4 partition down to 25GB and create a new partition in the remaining space. You can use this partition as the 'active downloads' drive or for other files that change often. This is recommended because you should not have such files in your Snapraid array.  

## Enable the latest kernel

- Go to another computer and browse to the webUI for your OMV box. You can find the IP address from your router.
- Install the OMV extras package from [omv-extras.org](http://omv-extras.org/joomla/index.php/omv-plugins-2/2-stable). This will give you access to a number of useful plugin repositories.
- Navigate to system > Extras > 'OMV-Extras.org'. Click on kernels tab and install the backports kernel; Set it as default.

## Set up the drives and shares
- Go into Storage > file systems and format, mount drives as neccesary
- Go to Access rights management > shares and  

- Enable the repositories for Snapraid, transmission, plex, sickbeard, couchpotato, NZBget
