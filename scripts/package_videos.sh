#!/usr/bin/env bash
set -euo pipefail

MAX_PART_SIZE_MB="${1:-1900}"
ZIP_BASE="videos/videos_bundle.zip"

if ! compgen -G "videos/*" > /dev/null; then
  echo "No files found in videos/."
  exit 1
fi

rm -f videos/videos_bundle.zip videos/videos_bundle.z??

if [[ "$MAX_PART_SIZE_MB" =~ ^[0-9]+$ ]] && [[ "$MAX_PART_SIZE_MB" -gt 0 ]]; then
  zip -r -s "${MAX_PART_SIZE_MB}m" "$ZIP_BASE" videos
  echo "Created split archive with part size ${MAX_PART_SIZE_MB}MB."
else
  zip -r "$ZIP_BASE" videos
  echo "Created single ZIP archive (split disabled)."
fi

ls -lh videos/videos_bundle*
