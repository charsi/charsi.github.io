---
title: Redundant internet using a Tomato capable router
tags:
  - india
  - internet
permalink: redundant-internet-using-tomato-capable-router
id: 4
updated: '2017-09-12 08:54:25'
date: 2017-03-09 21:54:06
category: Technology
---

![](./tomato-1.jpg)

TLDR; Get a tomato-capable router. Use its multi-WAN function to fuse connections from two ISPs together
### Rant 
Internet situation in India is bad. I am currently living in New Delhi but was based in UK for the last 5 years. I had got used to 50mbps and even 100mbps unlimited connections. After moving back I was a bit surprised to learn things hadn't moved on much at all since I left. Only a couple of ISPs (Airtel and MTNL) in Delhi were capable of providing stable connections. Fast, unlimited plans were nowhere to be found. I was frequently paying more than Rs4,000 per month for internet, due to all the additional data I was using. This was on Airtel's 8mbps plan which came with a 80GB 'FUP'[^1]. I was paying far less for completely unlimited 50mbps/100mbps plans back in UK!

So I bit the bullet and got a connection from a local ISP called 'Excitel'. I had never heard of them and was dubious about their ability to provide a reliable connection. But their 50mbps **unlimited** connection at Rs 800 per month was enticing enough. Four guys turned up to do the installation. The internet came over a LAN cable flung from the nearest khamba[^5]. I had last got internet this way more than 10 years ago[^2]. As expected the connection was very unreliable. I was raising several support tickets each week to get the connectivity restored each time it went down. 
I had wisely not disconnected Airtel yet. So whenever Excitel went down I could switch wifi connections and start using Airtel for a few hours. So I now had unlimited internet for about Rs1800 per month for the two connections(after switching to Airtel's lowest 10GB plan). But the manual switching of wifi connections was getting annoying. 

After a few months of putting up with this I finally put a solution in place. I have been running  [Tomato firmware](https://advancedtomato.com/)[^3] on my router since many years. And recently the developers added multi-WAN functionality to the firmware. Perfect. I updated the router and made the required configuration changes and lived happily ever after. 

### How-To
Here are the steps to follow if you find yourself in a similar situation -

1. Get a router that supports [Tomato firmware](https://advancedtomato.com/) (anything that has a broadcom chip inside). Get one of [these](https://advancedtomato.com/downloads) if you are unsure. I am using a Netgear WNR3500L v2[^4].
- Download tomato  for your router from [here](https://advancedtomato.com/downloads) if you want the new slick UI or from [here](http://tomato.groov.pl/?page_id=164) if you like the old school look.
- Open your router settings page. Usually at `192.168.1.1` or `192.168.0.1`.
- Find the option to upgrade firmware and upload the tomato firmware file.
- Wait for the firmware to be installed and pray your router doesn’t get bricked. 
- Once the new firmware is installed go to `192.168.1.1` and navigate to `Advanced > VLAN` on the sidebar
- Uncheck port 1 for `LAN(br0)`
- On the last row select 'WAN2' from the drop-down and select port 1. Click Add. This will designate Port 1 to be used as your second WAN port. Your screen should be looking like the screenshot below now. ![](./Screenshot_1.png)
- Click save and navigate to `Basic > Network`
- Select '2WAN' for number of WAN ports option.
- Configure WAN 1 details as provided by your ISP. Connection type would probably be DHCP or pppoe with a user name and password.
- For WAN 2 set the connection type to DHCP and load balance weight to 0. 
- Configure your wifi name and password on the same page. Click save and wait for the router to reboot. ![](./Screenshot_3.png)
- Connect an ethernet cable from one of the LAN ports on your Airtel/MTNL modem to port 1 on the tomato router. 
- Done

You should now have an always up connection which automatically falls back to using your 2nd ISP when the first one goes down.

### Notes
- You can also use another open-source firmware - [dd-wrt](http://www.dd-wrt.com/) to achieve similar results. If you already have a router [compatible](https://dd-wrt.com/wiki/index.php/Supported_Devices) with dd-wrt you should give it a shot first. I don't have any experience with it so please get [google](https://www.google.co.in/search?q=ddwrt+multiwan) to help you with this.
- When the router is using ISP2 with the above setup you are accessing the internet via two devices. This will cause a 'double-NAT' situation, which can cause problems for services such as torrents and VOIP. An easy fix would be to put the IP address of the tomato router in 'DMZ' on the modem/router for ISP2.
- It is possible to have the router send push alerts to your phone every time one of the connections goes down. I will write a separate post on how to set this up.
- Airtel has upped its smallest plan's data from 10 to 25 GB now so I am less concerned about going over in the periods Excitel is down. However it would still be a good idea to keep track of usage on the backup connection.
   
   
[^1]: ISPs in India really need to stop abusing the term 'Fair Usage Policy'
[^2]: Anyone remember Sify Broadband?
[^3]: Tomato is an opensource firmware that can supercharge your router.
[^4]: Fun fact, I purchased four of these for &pound;1 each a few years ago :) 
[^5]: Utility pole
