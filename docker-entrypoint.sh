#!/bin/bash

echo 'Container is running!!!'

# Authenticate with Google Cloud
gcloud auth activate-service-account --key-file=$GOOGLE_APPLICATION_CREDENTIALS

# Create mount point with consistent naming
mkdir -p /mnt/gcs_data

# Mount the GCS bucket
gcsfuse --key-file=$GOOGLE_APPLICATION_CREDENTIALS $GCS_BUCKET_NAME /mnt/gcs_data
echo 'GCS bucket mounted at /mnt/gcs_data'

# Create directory for cheese dataset
mkdir -p /app/cheese_dataset

# Mount the unlabeled cheeses directory
mount --bind /mnt/gcs_data/cheeses_unlabeled /app/cheese_dataset
echo 'Unlabeled cheese images mounted at /app/cheese_dataset'

# Activate virtual environment
pipenv shell