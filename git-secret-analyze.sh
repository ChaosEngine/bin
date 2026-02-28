#!/bin/bash

#
# Taken from: https://medium.com/@sharon.brizinov/how-i-made-64k-from-deleted-files-a-bug-bounty-story-c5bd3a6f5f9b
#

# cd to cloned repo
mkdir -p "__ANALYSIS/del"
# Extract all commits and process each commit
git rev-list --all | while read -r commit; do
    echo "Processing commit: $commit"

    # Get the parent commit
    parent_commit=$(git log --pretty=format:"%P" -n 1 "$commit")
    if [ -z "$parent_commit" ]; then
        continue
    fi
    parent_commit=$(echo "$parent_commit" | awk '{print $1}')

    # Get the diff for the commit
    git diff --name-status "$parent_commit" "$commit" | while read -r file_status file; do
        # Replace / with _ for filenames in binary_files_dir
        safe_file_name=$(echo "$file" | sed 's/\//_/g')

        # Handle deleted files
        if [ "$file_status" = "D" ]; then
                # Handle binary files
                echo "Binary file deleted: $file" | tee -a "__ANALYSIS/del.log"
                echo "Saving to __ANALYSIS/del/${commit}___${safe_file_name}"
                git show "$parent_commit:$file" > "__ANALYSIS/del/${safe_file_name}"
        fi
    done
done

