#!/bin/bash

# Script name: prj.sh
# Description: First run prj.sh in HLS/ folders, then in VIVADO/ folders

echo "Running all prj.sh scripts in HLS directories first..."

# Run prj.sh in all HLS folders first
find . -type d -name "HLS" | sort | while read dir; do
    script="$dir/prj.sh"
    if [[ -f "$script" ]]; then
        echo "Running prj.sh in: $dir"
        (cd "$dir" && chmod +x prj.sh && ./prj.sh)
    else
        echo "No prj.sh found in: $dir"
    fi
done

echo "Now running all prj.sh scripts in VIVADO directories..."

# Then run prj.sh in all VIVADO folders
find . -type d -name "VIVADO" | sort | while read dir; do
    script="$dir/prj.sh"
    if [[ -f "$script" ]]; then
        echo "Running prj.sh in: $dir"
        (cd "$dir" && chmod +x prj.sh && ./prj.sh)
    else
        echo "No prj.sh found in: $dir"
    fi
done

echo "Done."

