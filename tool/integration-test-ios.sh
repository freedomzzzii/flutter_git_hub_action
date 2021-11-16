#!/bin/sh

# if has error is not run next step
set -e

echo "Run integration test"
iPhone_device="iPhone 7"

if [[ ! -z `find "./integration_test" -name "main_integration_test.dart"` ]]
  then
    if xcrun simctl list | grep -Eo "$iPhone_device \([A-F0-9]{8}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{12}\)";
    then
      ios_device=$(xcrun simctl list | grep -Eo "$iPhone_device \([A-F0-9]{8}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{12}\)" | grep -Eo "[A-F0-9]{8}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{12}" | head -1)
      xcrun simctl boot $ios_device
      if flutter drive --driver=test_driver/integration_test.dart --target=integration_test/main_integration_test.dart -d $ios_device | grep "All tests passed.";
        then
        echo "Success: ios integration test is pass"
        xcrun simctl shutdown $ios_device
      else
        echo "Error: ios integration test is fail"
        xcrun simctl shutdown $ios_device

        exit 1
      fi
    else
      echo "Error: please install $iPhone_device"

      exit 1
    fi
else
  echo "Skip: can't find main_integration_test.dart"
fi

echo "Run integration test is Succeed"

exit 0