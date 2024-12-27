#!/bin/bash

############### Manual ###############
# Make Directory if not already available 
#mkdir -p /mongo-data/backups/

# Backup DB inside container 
#docker exec -it mongo-db mongodump --out /data/dump/

# Copy from container to host VM 
#docker cp mongo-db:/data/dump/ /mongo-data/backups/$(date +'%m-%d-%y')

######################################

# Variables
BACKUP_DIR=/mongo-data/backups/$(date +'%m-%d-%y')
TARBALL_NAME=mongo-backup-$(date +'%m-%d-%y').tar.gz
SPACES_BUCKET_NAME=your-space-name
SPACES_REGION=your-region-name  # Example: nyc3
SPACES_URL=https://$SPACES_BUCKET_NAME.$SPACES_REGION.digitaloceanspaces.com

# Make Directory if not already available 
mkdir -p /mongo-data/backups/

# Backup DB inside container 
docker exec -it mongo-db mongodump --out /data/dump/

# Copy from container to host VM 
docker cp mongo-db:/data/dump/ /mongo-data/backups/$(date +'%m-%d-%y')

# Create a tarball of the backup directory
tar -czvf /mongo-data/backups/$TARBALL_NAME -C /mongo-data/backups/ $(date +'%m-%d-%y')

# Send to Digital Ocean Spaces 



