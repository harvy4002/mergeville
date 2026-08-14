#!/bin/bash

DATE=$(date '+%Y-%m-%d')
VERSION=""
AUTHOR=""
FOLDER="docs"
OUTPUT_NAME=""

# Parse arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --folder)
      FOLDER="$2"
      shift 2
      ;;
    --version)
      VERSION="$2"
      shift 2
      ;;
    --author)
      AUTHOR="$2"
      shift 2
      ;;
    *)
      if [ -z "$OUTPUT_NAME" ]; then
        OUTPUT_NAME="$1"
      else
        echo "Unknown argument: $1"
        exit 1
      fi
      shift
      ;;
  esac
done

# Check if folder argument is provided
if [ -z "$OUTPUT_NAME" ]; then
  echo "Usage: $0 [--folder <date>] [--version <version>] [--author <author>] <output_name>"
  exit 1
fi

# Remove trailing slash for cleaner output names
FOLDER_CLEAN="${FOLDER%/}"
ORDER_FILE="$FOLDER_CLEAN/order"
OUTPUT_FILE="out/${OUTPUT_NAME}.docx"
SCRIPT_DIRECTORY=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

mkdir -p "out" && true

# Check if folder exists
if [ ! -d "$FOLDER_CLEAN" ]; then
  echo "Error: Directory '$FOLDER_CLEAN' does not exist."
  exit 1
fi

# Check if order file exists
if [ ! -f "$ORDER_FILE" ]; then
  echo "Error: Order file '$ORDER_FILE' not found in '$FOLDER_CLEAN'."
  exit 1
fi

# Read the order file and construct the file list
FILES=()
while IFS= read -r file || [ -n "$file" ]; do
  # Trim whitespace
  file=$(echo "$file" | xargs)
  
  # Ignore empty lines and comments
  if [[ -n "$file" && ! "$file" =~ ^# ]]; then
    if [ -f "$FOLDER_CLEAN/$file" ]; then
      FILES+=("$FOLDER_CLEAN/$file")
    else
      echo "Warning: File '$FOLDER_CLEAN/$file' listed in order does not exist, skipping."
    fi
  fi
done < "$ORDER_FILE"

# Check if we have valid files to process
if [ ${#FILES[@]} -eq 0 ]; then
  echo "Error: No valid files found to process."
  exit 1
fi

# Replace {date} or {version} with provided values
TMP_DIR=""
PROCESSED_FILES=()

if [[ -n "$DATE" || -n "$VERSION" ]]; then
  TMP_DIR=$(mktemp -d)
  trap 'rm -rf "$TMP_DIR"' EXIT

  SED_CMD=""
  if [ -n "$DATE" ]; then
    ESCAPED_DATE=$(echo "$DATE" | sed 's/|/\\|/g')
    SED_CMD+="s|{date}|$ESCAPED_DATE|g;"
  fi
  if [ -n "$VERSION" ]; then
    ESCAPED_VERSION=$(echo "$VERSION" | sed 's/|/\\|/g')
    SED_CMD+="s|{version}|$ESCAPED_VERSION|g;"
  fi
  if [ -n "$AUTHOR" ]; then
    ESCAPED_AUTHOR=$(echo "$AUTHOR" | sed 's/|/\\|/g')
    SED_CMD+="s|{author}|$ESCAPED_AUTHOR|g;"
  fi

  for file in "${FILES[@]}"; do
    tmp_file="$TMP_DIR/${file//\//_}"
    sed "$SED_CMD" "$file" > "$tmp_file"
    PROCESSED_FILES+=("$tmp_file")
  done
else
  # If no replacements, just use original files
  PROCESSED_FILES=("${FILES[@]}")
fi

# Run pandoc to generate the DOCX file
echo "Generating $OUTPUT_FILE from ${#PROCESSED_FILES[@]} files..."
pandoc -s --strip-comments --toc --wrap=preserve \
  --reference-doc=$SCRIPT_DIRECTORY/templates/docx-template.docx \
  --template=$SCRIPT_DIRECTORY/templates/default.openxml \
  --lua-filter $SCRIPT_DIRECTORY/filters/diagram-1.2.0/diagram.lua \
  --lua-filter $SCRIPT_DIRECTORY/filters/pagebreak.lua \
  --resource-path=".:${FOLDER_CLEAN}:images" \
  "${PROCESSED_FILES[@]}" -o "$OUTPUT_FILE"

if [ $? -eq 0 ]; then
  echo "Successfully created $OUTPUT_FILE"
else
  echo "Error: pandoc command failed."
  exit 1
fi