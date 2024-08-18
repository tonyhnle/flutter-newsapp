#!/bin/bash
cd news_app
flutter drive --driver=test_driver/main_test.dart --target=integration_test/app_test.dart --verbose
