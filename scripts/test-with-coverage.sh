#!/bin/bash

# Generate coverage report
PROJECT_ROOT_PATH=$1
PACKAGE_PATH=$2
PACKAGE_NAME=$3  

PACKAGE_LCOV_INFO_PATH=$PROJECT_ROOT_PATH/coverage/lcov_$PACKAGE_NAME.info
PACKAGE_TEST_REPORT_PATH=$PROJECT_ROOT_PATH/test_reports/${PACKAGE_NAME}_test_report.json

# Print variables for debugging
echo "PROJECT_ROOT_PATH: $PROJECT_ROOT_PATH"
echo "PACKAGE_LCOV_INFO_PATH: $PACKAGE_LCOV_INFO_PATH"
echo "PACKAGE_TEST_REPORT_PATH: $PACKAGE_TEST_REPORT_PATH"

# Run tests with coverage
flutter test \
  --no-pub \
  --machine \
  --coverage \
  --coverage-path $PACKAGE_LCOV_INFO_PATH > $PACKAGE_TEST_REPORT_PATH

# Check if the coverage file was created
if [ ! -f "$PACKAGE_LCOV_INFO_PATH" ]; then
  echo "Error: Coverage file not found at $PACKAGE_LCOV_INFO_PATH"
  exit 1
fi

escapedPath="$(echo $PACKAGE_PATH | sed 's/\//\\\//g')"

# Adjust paths in the coverage file
if [[ "$OSTYPE" =~ ^darwin ]]; then
  gsed -i "s/^SF:lib/SF:$escapedPath\/lib/g" $PACKAGE_LCOV_INFO_PATH
else
  sed -i "s/^SF:lib/SF:$escapedPath\/lib/g" $PACKAGE_LCOV_INFO_PATH
fi
