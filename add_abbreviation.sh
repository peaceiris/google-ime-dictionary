#!/usr/bin/env bash

# Fail on unset variables and command errors
set -ue -o pipefail

ABB_TXT_PATH="./dict/abbreviation.txt"
ABB_TSV_PATH="./tsv/abbreviation.tsv"

read -p "abbreviation: " abb
read -p "expanded: " expanded
echo -e "${abb}\t${expanded}\t名詞" >> "${ABB_TXT_PATH}"
sort -u "${ABB_TXT_PATH}" -o "${ABB_TXT_PATH}"
cp "${ABB_TXT_PATH}" "${ABB_TSV_PATH}"
sed -i '1iReading\tWord\tCategory' "${ABB_TSV_PATH}"

git diff
git add "${ABB_TXT_PATH}" "${ABB_TSV_PATH}"
git commit -m "abb: add ${abb} (${expanded})"
