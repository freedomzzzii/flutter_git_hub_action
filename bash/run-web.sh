#!/bin/sh

chrome_device="Google Chrome"

if flutter emulators | grep "chrome_device";
  then
    flutter run --debug chrome
fi