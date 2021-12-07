#!/bin/bash
set -e

# you can pass variable by export e.g. export BUILD_NUMBER=123
perl -i -pe 's/^((version:\s+\d+\.\d+\.\d+\+)|(version:\s+\d+\.\d+\.\d+\-\w+\+))(\d+)$/$1.('$BUILD_NUMBER')/e' ../pubspec.yaml