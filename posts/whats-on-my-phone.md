---
title: Whats on my phone
permalink: whats-on-my-phone
date: 2020-09-12
category: Technology
---

This is an attempt to document all the apps I have to install on a new android phone to get it up and running. This is currently from memory. I'll update this post when I have to go though the steps for real next time.

1. Go through all the steps of new phone wizard. Skip google account creation and opt out of all possible data collection *features* from google. 
 - Never sign into the phone with a google account.
 - Disable the play store (can't login anyway) and play services.
- __App store__ Download the apk for the [F-Droid](https://f-droid.org/) application store. This only offers FOSS applications. But covers about 90% of everything that I need on my phone.
- __Web browser__ - Firefox. Not available directly from fdroid. Install [FFUpdater](https://f-droid.org/en/packages/de.marmaro.krt.ffupdater/) first. This pulls latest firefox builds from Mozilla's repos. 
- __File syncing__ - [Syncthing](https://syncthing.net/) - Dropbox replacement. I use it to sync everything to my new phone - Contacts, notes, passwords, TOTP seeds, youtube, podcast and RSS subsctiptions. Add [Cryptomator](https://cryptomator.org/) on top if feeling paranoid
- __Contacts__ - [DecSync CC](https://f-droid.org/en/packages/org.decsync.cc/) uses a file saved in my syncthing directory to store and sync contacts. Completley transparent to the phone's contacts app. I see my contacts there as usual. Just need to choose DecSync as the default location to save new contacts.
- __Passwords__ - [KeePassDX](https://f-droid.org/en/packages/com.kunzisoft.keepass.libre/) for passwords and [andOTP](https://f-droid.org/en/packages/org.shadowice.flocke.andotp/) for OTPs. Both use a file in syncthing as the store. 
- __Email__ - [K-9 Mail](https://f-droid.org/en/packages/com.fsck.k9/)
- __Messengers__
  - Signal - Not on Fdroid. Get APK direct from [signal.org](https://signal.org/android/apk/)
  - [Jami](https://f-droid.org/en/packages/cx.ring/) - Also includes sip calling functionality using general voip accounts like [callcentric](https://www.callcentric.com/).
- __Notes/Tasks__ - [Orgzly](https://f-droid.org/en/packages/com.orgzly/)
- __Media__
  - [NewPipe](https://newpipe.schabi.org/) - youtube client
  - [Kore](https://f-droid.org/en/packages/org.xbmc.kore/) - remote for [kodi](https://kodi.tv/), previously called XBMC. Can also take video links from NewPipe and stream them to the TV. Who needs chromecast?
  - [Escapepod](https://f-droid.org/en/packages/org.y20k.escapepod/) - RSS based podcast subscription manager and player.
  - [Transistor](https://f-droid.org/en/packages/org.y20k.transistor/) - Online radio player. I use it to listed to BC radio.
  - [VLC](https://f-droid.org/en/packages/org.videolan.vlc/) - Video player
- __Navigation__ [Sygic](https://f-droid.org/en/packages/com.fsck.k9/) - Closed source so not available from F-Droid. Get it from [APK mirror](https://apkpure.com/sygic-gps-navigation-offline-maps/com.sygic.aura) 
- [Slide](https://f-droid.org/en/packages/me.ccrama.redditslide/) - Unofficial Reddit client

  
