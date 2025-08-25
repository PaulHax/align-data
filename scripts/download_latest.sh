#!/bin/bash
# Download latest ICL data release from GitHub

REPO="PaulHax/align-data"
OUTPUT_DIR=${1:-.}

echo "Fetching latest release of align-data..."

# Get latest release tarball URL
LATEST_URL=$(curl -s https://api.github.com/repos/$REPO/releases/latest \
  | grep "tarball_url" \
  | cut -d '"' -f 4)

if [ -z "$LATEST_URL" ]; then
  echo "Error: Could not fetch latest release"
  echo "This might mean no releases have been created yet."
  echo "Check https://github.com/$REPO/releases"
  exit 1
fi

# Extract version tag from URL for naming
VERSION=$(echo "$LATEST_URL" | grep -oP 'refs/tags/\K[^/]+$')
echo "Found latest version: $VERSION"

# Download
FILENAME="align-data-${VERSION}.tar.gz"
echo "Downloading to $OUTPUT_DIR/$FILENAME..."
wget -q -O "$OUTPUT_DIR/$FILENAME" "$LATEST_URL"

if [ $? -ne 0 ]; then
  echo "Error: Failed to download release"
  exit 1
fi

# Extract
echo "Extracting..."
tar -xzf "$OUTPUT_DIR/$FILENAME" -C "$OUTPUT_DIR"

# Find extracted directory (GitHub adds repo-commitish to name)
EXTRACTED_DIR=$(find "$OUTPUT_DIR" -maxdepth 1 -type d -name "*align-data*" | grep -v ".tar.gz" | head -1)

if [ -z "$EXTRACTED_DIR" ]; then
  echo "Error: Could not find extracted directory"
  exit 1
fi

# Make absolute path
EXTRACTED_DIR=$(realpath "$EXTRACTED_DIR")

echo ""
echo "Successfully downloaded align-data $VERSION"
echo "Location: $EXTRACTED_DIR"
echo ""
echo "To use with align-system, run:"
echo "  export ICL_DATA_PATH=$EXTRACTED_DIR/data"