#!/bin/bash

PROJECT_ROOT_PATH=$1

# Debug: Print the contents of the coverage directory
echo "Contents of $PROJECT_ROOT_PATH/coverage/:"
ls "$PROJECT_ROOT_PATH/coverage/"

# Initialize the LCOV input files variable
LCOV_INPUT_FILES=""

# Populate LCOV_INPUT_FILES with paths to coverage files
while read FILENAME; do
  LCOV_INPUT_FILES="$LCOV_INPUT_FILES -a \"$PROJECT_ROOT_PATH/coverage/$FILENAME\""
done < <( ls "$1/coverage/" )

# Debug: Print the LCOV input files
echo "LCOV_INPUT_FILES: $LCOV_INPUT_FILES"

# Check if LCOV_INPUT_FILES is empty
if [ -z "$LCOV_INPUT_FILES" ]; then
  echo "Error: No LCOV input files found."
  exit 1
fi

# Combine coverage files into a single report
eval lcov $LCOV_INPUT_FILES -o $PROJECT_ROOT_PATH/coverage_report/combined_lcov.info

# Remove unwanted files from the combined report
lcov --remove $PROJECT_ROOT_PATH/coverage_report/combined_lcov.info \
  "lib/main_*.dart" \
  "*.gr.dart" \
  "*.g.dart" \
  "*.freezed.dart" \
  "*di.config.dart" \
  "*.i69n.dart" \
  "*/generated/*" \
  "*.theme_extension.dart" \
  -o $PROJECT_ROOT_PATH/coverage_report/cleaned_combined_lcov.info

# Debug: Check if the cleaned combined report exists
if [ ! -f "$PROJECT_ROOT_PATH/coverage_report/cleaned_combined_lcov.info" ]; then
  echo "Error: Cleaned combined coverage report not found."
  exit 1
fi
