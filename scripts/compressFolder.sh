#!/bin/bash

# Check if the correct number of arguments were provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <archive_file_name> <folder_to_compress>"
    exit 1
fi

archive_file="$1"
folder_to_compress="$2"

# Run the tar command to compress the specified folder into the archive file
sudo tar -cvzf "$archive_file" "$folder_to_compress"

# Check the exit status of the tar command
if [ $? -eq 0 ]; then
    echo "Compression successful"
else
    echo "Compression failed"
fi
