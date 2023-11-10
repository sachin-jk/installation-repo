#!/bin/bash

# Check if the required arguments are provided
if [ $# -ne 1 ]; then
  echo "Usage: sh $0 <source_repo_url>"
  exit 1
fi

# Set your source and destination repository URLs
SOURCE_REPO="$1"
DEST_REPO="https://github.com/sachin-jk/installation-repo.git"

# Set the new branch name
NEW_BRANCH=$(echo "$SOURCE_REPO" | awk -F "/" '{print $NF,$(NF-1)}' | sed 's/ /--/' | sed 's/.git//')

# Clone the source repository
git clone "$SOURCE_REPO" source_repo
cd source_repo

# Adding the source.md
echo -e "### Original repo : \n$SOURCE_REPO" > source.md
git add source.md
git commit -m "Adding source"

# Create a new branch
git checkout -b "$NEW_BRANCH"

# Push the new branch to the destination repository
git remote add destination_repo "$DEST_REPO"
git push destination_repo "$NEW_BRANCH"

# Clean up: remove the cloned repository
cd ..
rm -rf source_repo

echo "New branch '$NEW_BRANCH' pushed to the destination repository."
