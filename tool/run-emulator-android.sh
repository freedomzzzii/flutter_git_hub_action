#!/bin/sh

android_device="Nexus_6_API_25"
android_device_m1="Nexus_6_API_S"

if flutter emulators | grep "$android_device";
  then
    androidId=$(flutter devices | grep -Eo "emulator-[0-9][0-9][0-9][0-9]")

    flutter emulators --launch $android_device; flutter run --debug --device-id=$androidId
  elif  flutter emulators | grep "$android_device_m1";
  then
    androidId=$(flutter devices | grep -Eo "emulator-[0-9][0-9][0-9][0-9]")

    flutter emulators --launch $android_device_m1; flutter run --debug --device-id=$androidId
fi