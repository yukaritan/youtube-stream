#!/bin/bash

# Call the script with ./this-script.sh youtube-id
# Requires youtube-dl

filename=$(youtube-dl --get-filename "$1")
echo "Saving to \"${filename}\""

youtube-dl "$1" -o- | tee "${filename}" | mpv -
