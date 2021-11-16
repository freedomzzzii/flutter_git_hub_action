#!/bin/sh

# if has error is not run next step
set -e

echo "Run integration test"
chrome_device="Google Chrome"

if [[ ! -z `find "./integration_test" -name "main_integration_test.dart"` ]]
  then
    if flutter devices | grep "$chrome_device";
      then
        cmd="chromedriver --port=4444"
        $cmd &

        if  flutter drive --driver=test_driver/integration_test.dart --target=integration_test/main_integration_test.dart -d chrome | grep "All tests passed." | lsof -ti tcp:4444 | xargs kill ;
        then
          echo "Success: web integration test is pass"
        else
          echo "Error: web integration test is failure"

          exit 1
        fi
    else
      echo "Error: please install chrome driver version $chrome_device"

      exit 1
    fi
else
  echo "Skip: can't find main_integration_test.dart"
fi

echo "Run integration test is Succeed"

exit 0