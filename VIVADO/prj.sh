#!/bin/bash

# Script name: run_all_hls_builds.sh
# Description: Recursively find and run all hls_build.sh scripts in subdirectories

echo "Searching for vivado_build.sh in subdirectories..."

# Find and execute hls_build.sh in each subdirectory
find . -type f -name "vivado_build.sh" | while read script; do
    dir=$(dirname "$script")
    echo "Running vivado_build.sh in: $dir"
    (cd "$dir" && chmod +x vivado_build.sh && ./vivado_build.sh)
done

echo "All vivado_build.sh scripts have been executed."
