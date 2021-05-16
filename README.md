tcl-link
---

I have a [FFalcon 50UF1 50" TV](https://featherbear.cc/blog/post/my-new-tv/) (A rebranded TCL 50DP648 (likely)) that I want to turn on and off programatically.

# Attempts

## HDMI CEC

CEC is a protocol that allows HDMI-connected devices to control each other.  
_(I had originally tried using a [Banana Pi M2 Zero](http://wiki.banana-pi.org/Banana_Pi_BPI-M2_ZERO) but CEC support was falsely advertised)_  
Using a Raspberry Pi  with `cec-utils` I was able to power on the TV using the `as` or `on 0` instructions.  
**However** powering off the device with `standby 0`, or even the other CEC codes (`10:44:00`, `10:44:6B`, `10:44:6C`) didn't work.

## TCL Remote

The [MagiConnect](https://play.google.com/store/apps/details?id=com.tnscreen.main) (and the former [nScreen](https://play.google.com/store/apps/details?id=com.tcl.nscreen.pro)) applications communicated to the TV over some protocol.  
_(I think the MagiConnect uses some proprietary protocol, whereas the nScreen application used a more legacy XML-based message protocol)_  
It seemed that the power off command was sent as part of the protocol, however power on was performed through WOL (Wake-On-LAN).  
Replicating the power off command was achieved after some network capture and analysis (TCP port `4123`).  
**However** turning on the TV after an extended period of inactivity did not work (despite the _Networked Standby_ setting enabled...)

> Note: I don't particularly want the TV connected to the internet, which is a shame that I have to send the power off command over the network, but at least I can isolate the TV from the rest of the network.

## IR Blaster

I could alternatively just transmit the IR code for the TV remote's power button.  
But I'd have to go and buy some parts for that, and program some Arduino code or something...  
Ugh extra hardware

---

# Solution

> Refer to the [`scripts`](./scripts) directory

* Turn On: Use the CEC protocol
* Turn Off: Send a network packet

As my Pi was connected to my IOT network wirelessly, the Ethernet port was free to use.  
I directly connected the TV and the Pi, and assigned each of them a static IP - as a benefit the TV would have no path to the internet.  
I can then issue the power off command to the TV via `TV_STATIC_IP:4123` (TCP), and turn on the TV over CEC.

In terms of setting the addresses on the Pi...
```bash
ifconfig eth0 10.9.8.8 netmask 255.255.255.0 
ip route add 10.9.8.7 dev eth0
```

On the TV you just need to go to the settings and edit the IP settings for the wired connection

## Related Projects

* https://github.com/popeen/WebRemote-TCL-S69
* https://github.com/Charykun/SymconTCLRemote
* https://github.com/Zigazou/opentclremote
