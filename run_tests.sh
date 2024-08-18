#!/bin/bash
set -e

# Start the emulator
echo "Starting the emulator..."
emulator -avd Nexus_6 -no-snapshot -no-boot-anim -no-audio -no-window &
adb wait-for-device
adb shell input keyevent 82

# Wait for the emulator to boot
echo "Waiting for the emulator to fully boot..."
sleep 60  # Adjust this if necessary

# Run the integration tests
echo "Running integration tests..."
cd news_app
flutter drive --driver=test_driver/main_test.dart --target=integration_test/app_test.dart --verbose
