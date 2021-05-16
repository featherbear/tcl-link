#!/bin/bash

echo '<?xml version="1.0" encoding="utf-8"?><root><action name="setKey" eventAction="TR_DOWN" keyCode="TR_KEY_POWER" /></root>' | nc 10.9.8.7 4123 -N > /dev/null

# Power off script to turn off a TCL TV via the network
# TV IP: 10.9.8.7

# https://github.com/featherbear/tcl-link