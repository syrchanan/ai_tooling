#!/bin/bash

# This script checks for goose credentials in env vars as well as local stored files.
# If found in env vars, it initializes them for use in the container.
# If found as a file, copies them to the container.

set -e

# Check for all goose-related env vars (prefix GOOSE_)
for var in $(env | grep '^GOOSE_' | cut -d= -f1); do
  value="${!var}"
  # Export the variable for use in the container
  export "$var=$value"
done

# Check for goose credentials in local files
## Get platform
platform=$(uname -s | tr '[:upper:]' '[:lower:]')

if [[ "$platform" == "linux" ]]; then
    CREDENTIALS_PATH="$HOME/.goose/credentials" # FIXME - path
elif [[ "$platform" == *"nt"* ]]; then
  CREDENTIALS_PATH="%AppData%/Roaming/Goose/credentials" # FIXME - path
fi

