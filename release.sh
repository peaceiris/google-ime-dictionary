#!/usr/bin/env bash

# Fail on unset variables and command errors
set -ue -o pipefail


TAG_NAME="$1"
RELEASE_ASSETS_SOURCE="abbreviation day_month edict-googleime edict-googleime_us"
RELEASE_ASSETS_DIR="build"
RELEASE_NOTES="release_notes.md"


\rm -rf "${RELEASE_ASSETS_DIR}" || true
mkdir "${RELEASE_ASSETS_DIR}"
(
  cd ./dict

  # Microsoft IME (Windowns)
  for i in ${RELEASE_ASSETS_SOURCE}; do
    nkf -w16L -Lw "./${i}.txt" > "./${i}.windows.txt"
  done

  # ATOK for Mac (macOS)
  sed -e 's/名詞/名詞*/g' ./abbreviation.txt > ./abbreviation.atok-macos.txt
  nkf --overwrite -w16L ./abbreviation.atok-macos.txt
  sed -e 's/名詞/名詞*/g' ./day_month.txt > ./day_month.atok-macos.txt
  nkf --overwrite -w16L ./day_month.atok-macos.txt

  for i in $(echo *.txt); do
    zip "../${RELEASE_ASSETS_DIR}/${i}.zip" "./${i}"
  done
)

sed -i "1iIME 拡張辞書 ${TAG_NAME}\n" "./${RELEASE_NOTES}"

(
  cd "${RELEASE_ASSETS_DIR}"
  hub release edit \
    --file "../${RELEASE_NOTES}" \
    $(for i in $(echo *); do echo -n "--attach ${i}#${i} "; done) \
    "${TAG_NAME}"
)
