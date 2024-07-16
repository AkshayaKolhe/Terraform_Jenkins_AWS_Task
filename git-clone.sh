#!/bin/bash

# Variables
GITHUB_USERNAME="AkshayaKolhe"
GITHUB_REPO="https://github.com/AkshayaKolhe/s3_website_terraform"
LOCAL_DIR="/tmp/website_tos3_from_terraform" #directory is for temporary storage
S3_BUCKET="hellohumans.in"
PRIVATE_REPO="s3_website_terraform"

# Export token as an environment variable for safer access
export GITHUB_TOKEN

# Remove the local directory if it exists
if [ -d "$LOCAL_DIR" ]; then
  rm -rf $LOCAL_DIR
fi

# Create the local directory
mkdir -p $LOCAL_DIR

# Clone the private GitHub repository
git clone https://$GITHUB_USERNAME:$GITHUB_TOKEN@github.com/$GITHUB_USERNAME/$PRIVATE_REPO.git $LOCAL_DIR

# Check if the clone was successful
if [ $? -ne 0 ]; then           #$? variable contains exit status of the previous 
  echo "Failed to clone the repository."
  exit 1
fi

# Sync the local directory to the S3 bucket
aws s3 sync $LOCAL_DIR s3://$S3_BUCKET --delete

# Check if the sync was successful
if [ $? -ne 0 ]; then
  echo "Failed to upload to S3."
  exit 1
fi

echo "Files successfully uploaded to S3."

# Clean up local directory
rm -rf $LOCAL_DIR
