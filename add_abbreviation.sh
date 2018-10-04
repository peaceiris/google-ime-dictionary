#!/usr/bin/env bash
set -eu
read -p "abbreviation: " abb
read -p "expanded: " expanded
echo "${abb}\t${expanded}\t名詞" >> abbreviation.txt
sort -u abbreviation.txt -o abbreviation.txt
cp abbreviation.txt ./tsv/abbreviation.tsv
git diff
git add abbreviation.txt ./tsv/abbreviation.tsv
git commit -m "Script: add ${abb} (${expanded})"
