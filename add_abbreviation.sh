#!/usr/bin/env bash

# Fail on unset variables and command errors
set -ue -o pipefail

read -p "abbreviation: " abb
read -p "expanded: " expanded
echo -e "${abb}\t${expanded}\t名詞" >> abbreviation.txt
sort -u abbreviation.txt -o abbreviation.txt

cp abbreviation.txt ./tsv/abbreviation.tsv
sed -i '1iReading\tWord\tCategory' ./tsv/abbreviation.tsv

cp abbreviation.txt ./atok/abbreviation.utf16.txt
sed -i '1i!!ATOK_TANGO_TEXT_HEADER_1' ./atok/abbreviation.utf16.txt
nkf -w16 --overwrite ./atok/abbreviation.utf16.txt

git diff
git add abbreviation.txt ./tsv/abbreviation.tsv ./atok/abbreviation.utf16.txt
git commit -m "Script: add ${abb} (${expanded})"
