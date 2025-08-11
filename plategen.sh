#!/bin/bash
set -e
FONT_FILE="CharlesWright-Bold.otf"
usage() {
  echo "Usage: $0 <type> <plate_string>"
  echo "Types:"
  echo "  single      Generates a single-line motorcycle plate (e.g., FAS1234C)."
  echo "  double      Generates a double-line car plate (e.g., SFX6275M)."
  exit 1
}
check_deps() {
  for cmd in convert potrace; do
    if ! command -v "$cmd" &> /dev/null; then
      echo "Error: Required command '$cmd' is not installed."
      echo "On Debian/Ubuntu, run: sudo apt-get update && sudo apt-get install imagemagick potrace"
      exit 1
    fi
  done
}

check_deps
if [ "$#" -ne 2 ]; then
  usage
fi

TYPE="$1"
PLATE_STRING_RAW="$2"
PLATE_STRING="${PLATE_STRING_RAW^^}"
OUTPUT_SVG="${PLATE_STRING}_${TYPE}.svg"
TEMP_BMP="temp_${PLATE_STRING}.bmp"

case "$TYPE" in
  single)
    PREFIX=$(echo "$PLATE_STRING" | grep -oE '^[A-Z]+')
    NUM=$(echo "$PLATE_STRING" | grep -oE '[0-9]+')
    SUFFIX=$(echo "$PLATE_STRING" | grep -oE '[A-Z]$')
    TEXT_CONTENT="$PREFIX  $NUM  $SUFFIX"

    echo "Generating single-line plate for '$PLATE_STRING'..."
    convert -size 720x100 xc:white \
            -font "$FONT_FILE" \
            -pointsize 72 \
            -fill black \
            -gravity Center \
            -draw "text 0,0 '$TEXT_CONTENT'" \
            "$TEMP_BMP"
    ;;

  double)
    PREFIX=$(echo "$PLATE_STRING" | grep -oE '^[A-Z]+')
    NUM=$(echo "$PLATE_STRING" | grep -oE '[0-9]+')
    SUFFIX=$(echo "$PLATE_STRING" | grep -oE '[A-Z]$')
    TEXT_LINE2="$NUM $SUFFIX"

    echo "Generating double-line plate for '$PLATE_STRING'..."
    convert -size 472x295 xc:white \
            -font "$FONT_FILE" \
            -pointsize 133 \
            -fill black \
            -gravity Center \
            -draw "text 0,-65 '$PREFIX'" \
            -draw "text 0,65 '$TEXT_LINE2'" \
            "$TEMP_BMP"
    ;;

  *)
    echo "Error: Invalid type '$TYPE'."
    usage
    ;;
esac

echo "Converting to SVG..."
potrace "$TEMP_BMP" -s -o "$OUTPUT_SVG"

echo "Cleaning up..."
rm "$TEMP_BMP"

echo "Success! Generated ${OUTPUT_SVG}"
