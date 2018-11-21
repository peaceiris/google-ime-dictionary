#!/usr/bin/env bash

# Fail on unset variables and command errors
set -ue -o pipefail

zip abbreviation.zip abbreviation.txt
mv abbreviation.zip ~/Desktop/
