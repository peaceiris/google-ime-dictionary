#!/usr/bin/env bash

# Fail on unset variables and command errors
set -ue -o pipefail
# Prevent commands misbehaving due to locale differences
export LC_ALL=C

read -p "abbreviation: " abb
read -p "expanded: " expanded
echo "${abb}\t${expanded}\t名詞" >> abbreviation.txt
sort -u abbreviation.txt -o abbreviation.txt
cp abbreviation.txt ./tsv/abbreviation.tsv
git diff
git add abbreviation.txt ./tsv/abbreviation.tsv
git commit -m "Script: add ${abb} (${expanded})"
