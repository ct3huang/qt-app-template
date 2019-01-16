#!/usr/bin/env bash

APP_BUNDLE_PATH=$1

# Add Qt libraries to the app bundle
macdeployqt ${APP_BUNDLE_PATH}

# Code sign
codesign --deep --force --verify --verbose --options runtime --sign "${CODE_SIGN_IDENTITY}" ${APP_BUNDLE_PATH}
