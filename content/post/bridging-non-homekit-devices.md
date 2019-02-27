---
keywords:
- apple
- ios
- homepod
- homekit
- homeautomation
title: "Bridging the HomeKit Divide"
date: 2019-02-27
draft: false
image: "/img/bridging-non-homekit-devices/image1.jpg"
description: Teaching old IoT new tricks
---

So I have been a big believer in the HomeKit ecosystem - I have generally preferred the app (although that might be changing) and found it much more responsive then the google assistant for home automation. 

One big problem with the HomeKit ecosystem is general lack of devices - not just in Australia but globally, up until recently a physical chip was required in each HomeKit comparable device which increased development and hardware costs - this forced a lot of manufactures to just ignore HomeKit and ship google assistant along with Alexa functionality (API only integration).

Thankfully a solution has existed for a while to bring non-HomeKit enabled devices into the HomeKit world - a project called Homebridge.

![Homebridge](/img/bridging-non-homekit-devices/image2.png)

[Homebridge on Github](https://github.com/nfarina/homebridge)

Now homebridge isn’t some user friendly package - you will need to know how to install a Linux distro on a raspberry pi, how use ssh and use the command line and the basics of json - it’s not the hardest technology thing ever but you will need to know the above at a minimum.

I’m not going to walk through the installation steps here as they are well documented in the github repo but I will talk about a few things I think you should keep in mind when deploying homebridge;

- go for a dedicated raspberry pi - or at an absolute minimum if installing on an existing server use docker 
- If you have a lot of cameras, be prepared for not great performance - generally you will use a plugin that uses ffmpeg - the pi doesn’t have enough power in my experience for more then two/three streams 
- If you do intend to have a few cameras (I do) then build ffmpeg from scratch, I found noticeable performance improvements by doing so
- Have a backup strategy - HomeKit has no backup or restore functionally, beyond the config.json you will need to make homebridge work it also has a bunch of other outputs - backup your entire installation directory to make life easier if you need to recover from failure - the config.json will recreate all your devices but everything will need to be re setup in the HomeKit app (found this out the hard way)
- Ethernet produces a slightly better response time then wifi - not much but enough 

Here are the things I bridged through to HomeKit
- first gen lifx globes - these guys worked well with google assistant but no HomeKit support, plugin is super easy to install and use
- Xiaomi local gateway - this exposes a bunch of super cheap sensors (light, motion, temperature, etc...) to HomeKit
- Nest cameras - works surprisingly well, wish it would expose some motion sensors for motion and what not
- RTSP streams - basic cheap cameras work really nicely, can be fiddly with the resolution and FPS so play around here
- Wemo smart switches - they suck a lot, generally bad devices so I put them in the bin 

I have run this setup for about 2 years with zero issues - the only problems I have ever had;
- yeah I fiddled with something, broke the config or updated some nom modules - just leave it alone
- Poor wifi - so many users are annoyed with HomeKit device responsiveness and generally I have found that’s a problem due to poor wifi - google assistant and Alexa will also suffer from this so invest in a rock solid system 