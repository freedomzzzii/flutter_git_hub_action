# The Flutter Clean Architecture (v0.1.1-beta)

This project intends to develop the PoC of Clean Architecture with Flutter SDK as well as add the mandatory packages for
rapid Flutter development

## Getting Started
- Download project from Github (https://github.com/HugemanConsultant/template-flutter-clean-arch)
- Run make command `make project/init`
- Add credential
  - Firebase
    - Make sure you have firebase app and create group `developer`, `qa` and `user` in firebase app distribute
    - Android add file `google-services.json` in `/android/app/`
    - iOS add file `GoogleService-Info.plist` into project see more
      in https://firebase.flutter.dev/docs/installation/ios
    - Web update firebase config in file `/web/firebase-config-sw.js`
  - Update value environment variable in ile `.env`
- Start your simulator ios simulator or android emulator
- Run Command `flutter run`

### Setup your workstation

- IntelliJ IDE - https://www.jetbrains.com/idea/
- iTerm2 - https://iterm2.com/
- Oh my zsh - https://ohmyz.sh/
- Docker - https://www.docker.com/products/docker-desktop
- java - https://www.oracle.com/java/technologies/javase/jdk12-archive-downloads.html
- xcode - https://developer.apple.com/xcode/
  - Download iOS 10.0
- Android studio - https://developer.android.com/studio
  - Mac M1
    - Download API S
    - Create AVD Nexus6 API S
  - Not ARM Architect
    - Download API 25
    - Create AVD Nexus6 API 25
- Chromedriver - https://chromedriver.chromium.org/downloads
- Firebase CLI - https://firebase.google.com/docs/cli
- lcov - https://github.com/linux-test-project/lcov
- Cloud SDK - https://cloud.google.com/sdk/docs/install
- Homebrew - https://brew.sh/index_th
- cocoapods - https://formulae.brew.sh/formula/cocoapods
- Fastlane: https://formulae.brew.sh/formula/fastlane
- Flutter and it required packages - https://flutter.dev/docs/get-started/install
  - Setup your editor - https://flutter.dev/docs/get-started/editor

## Package Version
- Flutter: 2.5.3
- Dart: 2.14.4
- java: 12.0
- Xcode: 13.0
- Support mobile version rollback 5 year
  - Android 7.1 (API level 25)
  - iOS 10.0
- Android studio: 2020.3.1

### Other Packages

- Internationalizing - https://flutter.dev/docs/development/accessibility-and-localization/internationalization
- BLoC - https://pub.dev/packages/flutter_bloc
- BLoC test - https://pub.dev/packages/bloc_test
- Modular - https://pub.dev/packages/flutter_modular
- Equatable - https://pub.dev/packages/equatable
- Dio - https://pub.dev/packages/dio
- Mockito - https://pub.dev/packages/mockito
- flutter_localizations , intl - https://pub.dev/packages/intl
- flutter_dotenv - https://pub.dev/packages/flutter_dotenv
- image_picker - https://pub.dev/packages/image_picker
- image_picker_web - https://pub.dev/packages/image_picker_web
- bloc_test - https://pub.dev/packages/bloc_test
- build_runner - https://pub.dev/packages/build_runner
- fastlane - https://fastlane.tools/
- flutter_modular_test - https://pub.dev/packages/flutter_modular_test
- faker - https://pub.dev/packages/faker
- lint - https://pub.dev/packages/lint
- firebase_core - https://pub.dev/packages/firebase_core
- firebase_crashlytics - https://pub.dev/packages/firebase_crashlytics
- firebase_performance - https://pub.dev/packages/firebase_performance
- dio_firebase_performance - https://pub.dev/packages/dio_firebase_performance
- firebase_messaging - https://pub.dev/packages/firebase_messaging
- flutter_local_notifications - https://pub.dev/packages/flutter_local_notifications
- MobSF - https://github.com/MobSF/Mobile-Security-Framework-MobSF
- aws cli - https://docs.aws.amazon.com/cli/latest/userguide/install-cliv1.html
- Google Firebase - Authentication (optional)
- Google Firebase - AB/Testing (optional)
- Google Firebase - Dynamic Link (optional)
- Google Firebase - Remote Config (optional)
- Biometric Authentication (optional)
- Secure Local Storage
- Encryption
- JailBreak and Root Detection
- Logging
- Correlation id

### Usage

- Make Command
  - Init project - `make project/init`
  - Cleanup project - `make project/cleanup`
  - Setup githook - `make git-hooks/setup`
  - Run android in development mode - `make project/run/android`
  - Run ios in development mode - `make project/run/ios`
  - Run web in development mode - `make project/run/web`
  - Install package - `make project/install/package`
  - Generate mock for test - `make test/generate/mock-file`
  - Generate l10n - `make l10n/generate`
  - Run Flutter DevTools - 
  - Run test with coverage - `make test/run`
  - Run integration test - `flutter drive --driver=test_driver/integration_test.dart --target=integration_test/main_integration_test.dart -d $YOUR_DEVICE_ID`
  - Run analysis - `make analysis/run`
  - Run benchmark
  - Build file .ipa (Distribute) - `make ios/build/ipa/distribute`
  - Build file .ipa (AdHoc) - `make ios/build/ipa/adhoc`
  - Build file .apk - `make android/build/apk`
  - Build file .aab - `make android/build/appbundle/release`, `make android/build/appbundle/debug`
  - Patch version -> include CHANGELOG.md
  - CI/CD
  - Build based on environment (mobile: (iOS, Android), web)
  - Mock/gen

## Project Structure

```
├── assets
    ├── mobile/
        ├── images/
        ├── fonts/
    ├── web/
        ├── images/
        ├── fonts/
├── android/ # Add description
    ├── app/
        ├── google-services.json # firebase config
    ├── fastlane/
        ├── Appfile
        ├── Fastfile
├── ios/
    ├── Runner/
        ├── exportOptions.plist # file config for build .ipa for distribute app
        ├── exportOptionsAdHoc.plist # file config for build .ipa for testing (firebase app distribute) app
    ├── fastlane/
        ├── metadata/
        ├── screenshots/
        ├── Appfile
        ├── Delivefile
        ├── Fastfile
    ├── GoogleService-Info.plist # firebase config
├── bin/  bash script for public in project
├── tool/ # bash script for private in project
├── integration_test/
    ├── main_integration_test.dart
├── lib/
    ├── src/
        ├── commons/
            ├── constants/
                ├── api_constant.dart
                ├── env_constant.dart
            ├── errors/
                ├── app_error.dart
            ├── exceptions/
                ├── app_exception.dart
        ├── configs/
            ├── env/
                ├── env_config.dart
            ├── l10n/ # output file from l10n generate store in this folder
                ├── app_en.arb
                ├── app_th.arb
            ├── routes/
                ├── route_config.dart
        ├── helpers/
            ├── firebase_message/
                ├── firebase_message_helper.dart
        ├── modules/
            ├── todo_module/
                ├── applications/
                    ├── bloc/
                        ├── task_bloc/
                            ├── task_bloc.dart
                            ├── task_event.dart
                            ├── task_tate.dart
                    ├── models/
                        ├── task_bloc_models/
                            ├── task_create_bloc_model.dart
                            ├── task_get_bloc_model.dart
                            ├── task_update_bloc_model.dart
                            ├── task_delete_bloc_model.dart
                        ├── error_bloc_model.dart
                        ├── exception_bloc_model.dart
                ├── commons/
                    ├── errors/
                        ├── datasource_error.dart
                        ├── repository_error.dart
                        ├── usecase_error.dart
                    ├── exceptions/
                        ├── usecase_exception.dart
                ├── configs/
                    ├── usecase_message/
                        ├── usecase_message_config.dart
                    ├── widget_key/
                        ├── widget_key_config.dart
                ├── domains/
                    ├── entities/
                        ├── task_create_entity.dart
                        ├── task_get_entity.dart
                        ├── task_delete_entity.dart
                        ├── task_update_entity.dart
                    ├── repositories/
                        ├── task_repository.dart # abstarct
                    ├── usecases/
                        ├── task_usecase.dart # abstarct
                    ├── datasources/
                        ├── datasource.dart # abstarct
                ├── presentations/
                    ├── screens/
                        ├── not_found_screen.dart
                        ├── task_create_screen.dart
                        ├── task_get_screen.dart
                        ├── task_update_screen.dart
                    ├── widgets/
                        ├── bottom_menu_bar_widget.dart
                ├── services/
                    ├── commons/
                        ├── request_query.dart
                        ├── response_json_key.dart
                    ├── datasources/
                        ├── api_datasource.dart
                    ├── models/
                        ├── task_create_datasource_model.dart
                        ├── task_get_datasource_model.dart
                        ├── task_delete_datasource_model.dart
                        ├── task_update_datasource_model.dart
                    ├── repositories/
                        ├── tassk_impl_repository.dart
                ├── task_impl_usecase.dart
                ├── todo_module.dart
            ├── app_module.dart
            ├── app_screen.dart
        ├── utils/
            ├── error_code_util.dart
            ├── image_picker
                ├── image_picker_for_mobile_util.dart
                ├── image_picker_for_web_util.dart
                ├── image_picker_stub_util.dart
                ├── image_picker_util.dart
    ├── main.dart
├── test/
    ├── src/
    ├── test_data/
        ├── import 'package:flutter_starter_kit/src/utils/test_data/mock_test_data.dart';
    ├── rest_resource/
├── test_driver/
    ├── integration_test.dart
├── benchmark/
├── web/
├── .env
├── .env-cicd
├── .env-cicd.example
├── .env.example
├── .gitignore
├── .dockerignore
├── docker-compose-local.yaml
├── Dockerfile
├── makefile
├── analysis_options.yaml
├── build.yaml
├── pubspec.lock
├── pubspec.yaml
├── README.md
├── CHANGELOG.md
```

## CI/CD

- Install Flutter: https://flutter.dev/docs/get-started/install/linux
- Install Java version 12
- Install Fastlane https://docs.fastlane.tools/best-practices/continuous-integration/jenkins/
- Install lcov (for see result from run test (html)) https://github.com/linux-test-project/lcov
- Required chrome browser&chromediver https://chromedriver.chromium.org/downloads
- firebase login https://firebase.google.com/docs/cli#install-cli-mac-linux
- Install gcloud https://cloud.google.com/sdk/docs/install https://firebase.google.com/docs/test-lab/ios/command-line
- MobSF https://github.com/MobSF/Mobile-Security-Framework-MobSF
- Create account bot for build and deploy (Apple store & play store & AWS)

## Example

Todo:

## References

<ul>
<li><a href="https://flutter.dev/" target="_blank">Flutter</a></li>
<li><a href="https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html">Uncle Bob - The Clean Architecture</a></li>
<li><a href="https://github.com/Solido/awesome-flutter">https://github.com/Solido/awesome-flutter</a></li>
<li><a href="https://firebase.google.com/">Google Firebase</a></li>
<li><a href="https://www.markdownguide.org/basic-syntax" target="_blank">Markdown Guide - Basic Syntax</a> </li>
<li><a href="https://github.com/rhwilr/markdown-documentation-template" target="_blank">Markdown Documentation Template</a> </li>
</ul>

## Git flows

When developers want to add feature

- Checkout `develop` branch (latest)
- Fork `feature` branch from `develop` (ex. `feature/hcd-xxx-card-name`)
- Before create `pull request`, rebase `develop` to current branch
- After finished the forked branch and already reviewed, create `pull request` to `develop` branch
- After reviewed the `pull request`, then merge it by use `sqaush merge`
- After testing, create `release` branch from `develop` (ex. `release/0.1.1`)
- Create `pull request` from `release` to `main`
- Review `pull request` then `merge`

When developers want to do hotfix

- Checkout `main` branch (latest)
- Fork `hotfix` branch from `main` (ex. `hotfix/hcd-xxx-card-name`)
- Create `pull request` from `hotfix` to `develop`
- Review `pull request` then `merge`
- After fixed issues, fork `release` branch from `hotfix` (ex. `release/0.1.2`)
- Create `pull request` from `release` to `main`
- Review `pull request` then `merge`

When developers want to do bugfix

- Checkout `develop` or `release` branch (branch that bug occurs)
- Fork `bugfix` branch` (ex. `bugfix/hcd-xxx-card-name`)
- Create `pull request` from `bugfix` to `develop` or `release`
- Review `pull request` then `merge` (`sqaush merge` in case of `develop` branch)

## Git commit and name convention

- feature name ex. feature/hcd-xxx-card-name
- commit message
  - Start with capital letter
  - Details what have done
  - eg. Add 'Dockerfile'
- hotfix name eg. hotfix/hcd-xxx-card-name

## Git hooks

- pre-commit: run these following steps before commit
  - check test coverage is more than 80%
  - check flutter analysis have error-level = 0 issue, warning-level = 0 issue and info-level <= 5 issues
- pre-push: run integration test before push

## Contact

Email - hello@hugeman.co

Project Link - https://github.com/HugemanConsultant/template-flutter-clean-arch

## License

Copyright 2021 © [Hugeman Consultant](https://hugeman.co)
