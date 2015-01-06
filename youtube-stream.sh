#!/bin/bash

# Call the script with ./this-script.sh youtube-id
# Requires youtube-dl

filename=$(youtube-dl --get-filename "$1")
echo "Saving to \"${filename}\""

youtube-dl "$1" -o- | tee "${filename}" | mpv -


# Catch all the exit codes to make sure everything went smoothly
status=$(awk 'BEGIN {t=0; for (i in ARGV) t+=ARGV[i]; print t}' "${PIPESTATUS[@]}")

if [ ${status} -ne "0" ]; then
    echo "Something failed, falling back to wget"
    
    # Get the raw URL so we can continue fetching it with wget
    url=$(youtube-dl --get-url "$1")
    wget -c -O "${filename}" "${url}"

else
    echo "Everything went smoothly"
    
fi
