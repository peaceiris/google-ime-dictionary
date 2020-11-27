#!/usr/bin/env bash

# Fail on unset variables and command errors
set -ue -o pipefail

ABB_TXT_PATH="./dict/abbreviation.txt"
ABB_TSV_PATH="./tsv/abbreviation.tsv"

read -p "abbreviation: " abb
read -p "expanded: " expanded
lower_expanded=$(echo ${expanded} | sed -e 's/[A-Z]/\L&/g;')
title_expanded=$(echo ${expanded} | sed -e 's/[A-Z]/\L&/g; s/\s[a-z]/\U&/g; s/^[a-z]/\U&/;')
echo -e "${abb}\t${lower_expanded}\t名詞" >> "${ABB_TXT_PATH}"
echo -e "${abb}\t${title_expanded}\t名詞" >> "${ABB_TXT_PATH}"
sort -u "${ABB_TXT_PATH}" -o "${ABB_TXT_PATH}"
cp "${ABB_TXT_PATH}" "${ABB_TSV_PATH}"
sed -i '1iReading\tWord\tCategory' "${ABB_TSV_PATH}"

git diff
git add "${ABB_TXT_PATH}" "${ABB_TSV_PATH}"
git commit -m "abb: add ${abb} (${expanded})"
