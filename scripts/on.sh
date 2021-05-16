#!/bin/bash

echo 'as' | cec-client -s -d 1 > /dev/null 2>&1

# Power on script for the Raspberry Pi (libCEC) to turn on a TV over HDMI-CEC

# https://github.com/featherbear/tcl-link