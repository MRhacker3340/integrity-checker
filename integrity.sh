#!/bin/bash

# Function to calculate the SHA-256 checksum of a file
calculate_checksum() {
  sha256sum "$1" | awk '{print $1}'
}

# Function to check file integrity
check_integrity() {
  file="$1"
  stored_checksum="$2"

  # Check if the file exists
  if [ ! -e "$file" ]; then
    echo "Error: File '$file' not found."
    exit 1
  fi

  # Calculate the current checksum of the file
  current_checksum=$(calculate_checksum "$file")

  # Compare the current checksum with the stored checksum
  if [ "$current_checksum" == "$stored_checksum" ]; then
    echo "File integrity check: OK"
  else
    echo "File integrity check: FAILED - File may be intercepted or corrupted."
    exit 1
  fi
}

# Ask the user for the file to check
read -p "Enter the file path: " file_to_check

# Ask the user for the stored checksum
read -p "Enter the stored checksum: " stored_checksum

# Check file integrity
check_integrity "$file_to_check" "$stored_checksum"

# Display a message to the user
echo "File is safe. Thanks for using this tool!"
