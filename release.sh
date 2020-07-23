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
  for i in ${RELEASE_ASSETS_SOURCE}; do
    zip "../${RELEASE_ASSETS_DIR}/${i}.zip" "./${i}.txt"
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
