#!/bin/sh

# if has error is not run next step
set -e

echo "Run integration test"
android_device="Nexus_6_API_25"
android_device_m1="Nexus_6_API_S"

if [[ ! -z `find "./integration_test" -name "main_integration_test.dart"` ]]
  then
    if flutter emulators | grep "$android_device";
    then
      flutter emulators --launch $android_device

      androidId=$(flutter devices | grep -Eo "emulator-[0-9][0-9][0-9][0-9]")

      if flutter drive --driver=test_driver/integration_test.dart --target=integration_test/main_integration_test.dart -d $androidId | grep "All tests passed.";
      then
        echo "Success: android integration test is pass"
      else
        echo "Error: android integration is failure"

        exit 1
      fi
    elif  flutter emulators | grep "$android_device_m1";
      then
        flutter emulators --launch $android_device_m1

        androidId=$(flutter devices | grep -Eo "emulator-[0-9][0-9][0-9][0-9]")

        if flutter drive --driver=test_driver/integration_test.dart --target=integration_test/main_integration_test.dart -d $androidId | grep "All tests passed.";
        then
          echo "Success: android integration test is pass"
        else
          echo "Error: android integration is failure"

          exit 1
        fi
    else
      echo "Error: please install $android_device"

      exit 1
    fi
else
  echo "Skip: can't find main_integration_test.dart"
fi

echo "Run integration test is Succeed"

exit 0