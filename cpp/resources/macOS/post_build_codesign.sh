#!/usr/bin/env bash

APP_BUNDLE_PATH=$1

# Code sign
codesign --deep --force --verify --verbose --options runtime --sign "${CODE_SIGN_IDENTITY}" ${APP_BUNDLE_PATH}
