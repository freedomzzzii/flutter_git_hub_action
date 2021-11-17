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
## iOS
### ios test_lab
```
fastlane ios test_lab
```
Test ios in Firebase test lab
### ios build_file_for_app_distribution
```
fastlane ios build_file_for_app_distribution
```
Build file for deploy firebase app distribute
### ios app_distribution_group_developer
```
fastlane ios app_distribution_group_developer
```
Deploy a release version to the Firebase App Distribute for Developer testing
### ios app_distribution_group_qa
```
fastlane ios app_distribution_group_qa
```
Deploy a release version to the Firebase App Distribute for QA testing
### ios app_distribution_group_user
```
fastlane ios app_distribution_group_user
```
Deploy a release version to the Firebase App Distribute for User testing
### ios release
```
fastlane ios release
```
Deploy a release version to the App store

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
