#!/usr/bin/env bash

# Fail on unset variables and command errors
set -ue -o pipefail

read -p "abbreviation: " abb
read -p "expanded: " expanded
echo -e "${abb}\t${expanded}\t名詞" >> abbreviation.txt
sort -u abbreviation.txt -o abbreviation.txt
cp abbreviation.txt ./tsv/abbreviation.tsv
sed -i '1iShort\tExpanded' ./tsv/abbreviation.tsv

git diff
git add abbreviation.txt ./tsv/abbreviation.tsv
git commit -m "Script: add ${abb} (${expanded})"
