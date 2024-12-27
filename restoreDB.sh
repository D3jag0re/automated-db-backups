#!/bin/bash

############### Manual ###############
# Copy to container from host (manual)
docker cp /mongo-data/backups/12-27-24/ mongo-db:/data/dump

# Restore container 
docker exec -it mongo-db mongorestore --drop /data/dump/

######################################