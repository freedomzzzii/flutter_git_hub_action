#!/bin/sh

ios_device="iPhone 7"

if xcrun simctl list | grep -Eo "$ios_device \([A-F0-9]{8}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{12}\)";
then
  iPhone=$(xcrun simctl list | grep -Eo "$ios_device \([A-F0-9]{8}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{12}\)" | grep -Eo "[A-F0-9]{8}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{12}")
  if ! xcrun simctl list | grep $iPhone | grep Booted;
  then
    xcrun simctl boot $iPhone; open -a Simulator
  fi
  flutter run --debug --device-id=$iPhone
fi
