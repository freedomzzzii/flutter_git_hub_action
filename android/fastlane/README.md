fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew install fastlane`

# Available Actions
## Android
### android test_lab
```
fastlane android test_lab
```
Test android in Firebase test lab
### android build_file_for_app_distribution
```
fastlane android build_file_for_app_distribution
```
Build file .apk for deploy firebase app distribute
### android app_distribution_group_developer
```
fastlane android app_distribution_group_developer
```
Deploy a beta version to the Firebase App Distribute for Developer testing
### android app_distribution_group_qa
```
fastlane android app_distribution_group_qa
```
Deploy a beta version to the Firebase App Distribute for QA testing
### android app_distribution_group_user
```
fastlane android app_distribution_group_user
```
Deploy a beta version to the Firebase App Distribute for User testing
### android beta
```
fastlane android beta
```
Deploy a beta version to the Play store

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
