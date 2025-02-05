#!/bin/bash

# Loop through all .md files in the current directory
for file in *.md; do
  # Remove the file extension to get the directory name
  dir_name="${file%.md}"

  # Check if the directory doesn't exist
  if [ ! -d "$dir_name" ]; then
    # Create a directory with the same name as the file (without extension)
    mkdir "$dir_name"
  fi

  # Move the .md file into the newly created directory
  mv "$file" "$dir_name/"
done
