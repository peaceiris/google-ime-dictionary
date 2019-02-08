#!/usr/bin/env bash

# Fail on unset variables and command errors
set -ue -o pipefail

files="abbreviation abbreviation.utf16"

for i in ${files}; do
    zip ${i}.zip ${i}.txt
    mv ${i}.zip ~/Desktop/
done
