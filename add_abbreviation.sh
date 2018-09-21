#!/bin/sh

read -p "abbreviation: " abb
read -p "expanded: " expanded

echo "${abb}\t${expanded}\t名詞" >> abbreviation.txt

sort -u abbreviation.txt -o abbreviation.txt

git diff

git add abbreviation.txt
git commit -m "Script: add: ${abb} (${expanded})"
