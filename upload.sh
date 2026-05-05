#!/usr/bin/env bash
# Usage: ./upload.sh <subject-folder> <path/to/file.pdf>
# Example: ./upload.sh numerik-0 ~/Desktop/numerik-vl07-interpolation.pdf
set -e

SUBJECTS=("analyse-2" "datenstrukturen-1" "lineare-algebra-2" "numerik-0" "statistik-0")

if [[ $# -ne 2 ]]; then
  echo "Usage: ./upload.sh <subject-folder> <path/to/file.pdf>"
  echo "Available subjects: ${SUBJECTS[*]}"
  exit 1
fi

FOLDER="$1"
FILE="$2"
BASENAME=$(basename "$FILE")

if [[ ! -d "$FOLDER" ]]; then
  echo "Error: folder '$FOLDER' not found. Available: ${SUBJECTS[*]}"
  exit 1
fi

if [[ ! -f "$FILE" ]]; then
  echo "Error: file '$FILE' not found."
  exit 1
fi

cp "$FILE" "$FOLDER/$BASENAME"
echo "Copied $BASENAME → $FOLDER/"

git add "$FOLDER/$BASENAME"
git commit -m "Add $FOLDER/$BASENAME"
git push origin main
echo "Pushed. Done."
