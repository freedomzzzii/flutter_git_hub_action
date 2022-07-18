project/init: project/cleanup git-hooks/setup project/install/package l10n/generate test/generate/mock-file
	cp .env.example .env; cp .env-cicd.example .env-cicd; cp ./web/example-firebase-config-service.js ./web/firebase-config-service.js

# flutter pub get VS dart pub get
# see more in https://dart.dev/tools/pub/cmd
project/install/package:
	flutter pub get; dart pub get

project/install/package/codemagic:
	flutter pub get; bash ./tool/install-dart.sh

project/cleanup: analysis/cleanup
	flutter clean

project/repair/package:
	flutter pub cache repair

project/run/ios:
	bash ./tool/run-ios-simulator.sh

project/run/android:
	bash ./tool/run-android-simulator.sh

project/run/web:
	bash ./tool/run-web-browser.sh

project/run/chromedriver:
	bash ./tool/run-chromedriver.sh

project/reset/develop: project/cleanup project/install/package l10n/generate test/generate/mock-file

project/reset/build: project/cleanup project/install/package l10n/generate

git-hooks/cleanup/pre-commit: analysis/cleanup

git-hooks/setup:
	git config core.hooksPath .githooks

analysis/run:
	-flutter analyze --write=static_code_analysis_result.txt

analysis/cleanup:
	rm -f "static_code_analysis_result.txt"

test/run:
	flutter test --coverage; lcov --remove coverage/lcov.info  'lib/src/configs/l10n/**' 'lib/src/modules/todo_module/configs/grpc/**' -o coverage/new_lcov.info

test/check/coverage-score:
	bash ./tool/test-coverage.sh

test/generate/mock-file:
	 flutter pub run build_runner build --delete-conflicting-outputs

test/generate/coverage-report:
	genhtml coverage/new_lcov.info -o coverage/html

integration-test/run/ios:
	bash ./tool/integration-test-ios.sh

integration-test/run/android:
	bash ./tool/integration-test-android.sh

integration-test/run/web:
	bash ./tool/integration-test-web.sh

l10n/generate:
	flutter gen-l10n --arb-dir lib/src/configs/l10n --output-dir=lib/src/configs/l10n --no-synthetic-package

android/build/appbundle/release:
	flutter build appbundle --release

android/build/appbundle/debug:
	flutter build appbundle --debug

android/build/apk/release:
	flutter build apk --release

android/build/apk/debug:
	flutter build apk --debug

android/build/test:
	./android/gradlew app:assembleAndroidTest --settings-file=./android/settings.gradle

android/build/test-debug:
	./android/gradlew app:assembleDebug --settings-file=./android/settings.gradle -Ptarget=integration_test/main_integration_test.dart

ios/build/test:
	flutter build ios integration_test/main_integration_test.dart --release

ios/build/runner-test:
	xcodebuild -workspace ios/Runner.xcworkspace -scheme Runner -config Flutter/Release.xcconfig -derivedDataPath build/ios_integ -sdk iphoneos build-for-testing

ios/config/test-lab:
	flutter build ios --config-only integration_test/main_integration_test.dart

ios/zip/test-lab:
	cd build/ios_integ/Build/Products/; zip -r "ios_tests.zip" "Release-iphoneos" "Runner_iphoneos15.0-arm64.xctestrun"; cd ../../../../

web/build:
	flutter build web

mobsf/run:
	bash ./tool/mobsf-automation.sh

increase-build-number/run:
	bash ./tool/increase-build-number.sh
