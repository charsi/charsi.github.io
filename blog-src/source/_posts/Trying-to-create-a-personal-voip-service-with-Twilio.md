---
title: Trying to create a personal voip service with Twilio
permalink: trying-to-create-a-personal-voip-service-with-twilio
id: 20
updated: '2018-01-10 04:07:22'
date: 2018-01-09 14:48:53
tags:
  - twilio
  - voip
category: Technology
---

#### Background
I have recently moved to Canada and decided to go with a data only plan on my phone because voice plans are quite expensive here. A standard voice plan is around $50-$60 with around 2GB of data. This kind of money can buy you [plans](https://www.uswitch.com/mobiles/iphone_deals/) which include an Iphone in the UK.

The cost of voice plans is a bit surprising because calling rates for VOIP are usually the cheapest for USA/Canada. And companies like Google Voice offer free calling in both countries. But I guess the massive size of Canada and the sparse population increase the cost of building the wireless infrastructure needed.

My current solution for staying connected in Canada uses a combination of Google voice which I use for outbound calls. And a local Canadian number for $3/month from [Callcentric](https://www.callcentric.com/) which forwards calls to my Google Voice number and a VOIP phone at home. So I can answer the call on my mobile if I am out, or on the VOIP phone if I am home. 

This is working flawlessly but there are a few drawbacks.

* Callcentric does not support SMS on its numbers so there is no way for me to receive texts.
* Outbound calls from Google voice show a USA number instead of my Canadian number.

The second issue I can live with. I can always use a VOIP app such as [Linphone](https://play.google.com/store/apps/details?id=org.linphone) or [Grandstream Wave](https://play.google.com/store/apps/details?id=com.grandstream.wave) on my mobile when I want my Canadian number to show as my caller ID. 

The lack of SMS problematic however. Numbers in Canada(and USA), unlike UK and India look the same for mobiles and landlines. This causes most people you call to assume they can text you back. There are some online services such as Skype that only verify the ownership of a number via text messages.

So to fix this I looked for alternatives to callcentric that also offer SMS. [Voip.ms](https://voip.ms/) fits the bill perfectly. However, to activate an account with them I was asked to submit a photo-ID which I currently don't have one of in Canada. And I don't like the idea of it anyway. I tried giving them my provisional driving license but that didn't work for them. 

#### Enter [Twilio](https://www.twilio.com/).
I have tried using Twilio before but their service is geared towards enterprise and people looking to create services using them as a backend. They have a crazy amount of features so figuring out how to setup a basic call forward through their website can be daunting.

I was also under the impression that Twilio needs a separate service which I'd need to host myself. However, they have recently added the ability to host business logic on their platform itself using [Twilio functions](https://www.twilio.com/functions).

##### Voice
First step was to have calls to my Twilio number forwarded to the URI for my SIP extension from Callcentric. 
On my second attempt with Twilio I got things working. However there were a few issues along the way. I used Stack-Overflow to look for solutions to each and got prompt replies from Twilio staff. It took a number of hours to figure things out. But I persevered because I figured there is a gap in the marked and I could conceivably build a viable service of my own using Twilio. Here are the issues I faced and links to Stack Overflow questions I created to try and resolve them -

* Twilio doesn't work with SIP URIs which use SRV records for load balancing. [SO](https://stackoverflow.com/questions/48160769/)

* Twilio can't do multi-ring with phone numbers and SIP addresses at the same time. [SO](https://stackoverflow.com/questions/48158991)
* Twilio answers every call. Even ones that go unanswered at the other end. [SO](https://stackoverflow.com/questions/48175352)

As a workaround for the first issue I wrote a small function (which uses nodejs syntax) to query SRV records for callcentric's SIP host.
For the second one I sidestepped the issue by forwarding to one SIP URI only - My callcentric extension. From there I could set up multiring using their [call treatments](https://www.callcentric.com/features/call_treatments).

The last issue however is a deal breaker. For calls that go unanswered, both the caller and the owner of the number(me, in this case) will get billed. It will also be unusual for callers to see the calls being established (that is when the call timer starts) while still hearing it ring until the call actually gets picked up.

~~So currently it seems Twilio is not the right provider for building a 'seamless' call forwarding service.~~

A [response](https://stackoverflow.com/a/48178707) to my Stack Overflow question regarding the last issue gave me a solution. All I needed was to add a [answerOnBridge](https://www.twilio.com/docs/api/twiml/dial#attributes-answer-on-bridge) attribute in my code. This makes Twilio wait for the outbound call to be answered before it connects the incoming call. Perfect.

This is my function for forwarding calls to my SIP URI. I still need to implement prioritisation according to SRV record priorities and weights.
<script src="https://gist.github.com/charsi/222e6e24577d61d70afac6406d54973d.js"></script>

##### Messaging
Now that the phone calls are working correctly I need to setup SMS. The easiest way to handle this is via emails. However I also want to implement a way to integrate with a open standards([XMPP](https://xmpp.org/) for example) chat protocol. 

To send incoming SMS messages to my email I grabbed some initial code from this reddit post. After a few modifications I had email forwards working perfectly. 
This is my function that forwards SMS- 

 <script src="https://gist.github.com/charsi/d2f377f559519bbbe287f12ef63daf0e.js"></script>

##### To-Do

* Add SMS capabilities to my number
* Build a product out of the whole thing. Profit. Retire. 
* Explore possibilities with Twilio alternatives such as [Pvilo](https://www.plivo.com/) and [Sinch](https://www.sinch.com/). 