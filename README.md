# automated-db-backups

This is based off the DevOps Roadmap Project [Automated DB Backups](https://roadmap.sh/projects/automated-backups)

Setup a scheduled workflow to backup a Database every 12 hours 

This is number 17 of [DevOps Projects](https://roadmap.sh/devops/projects) as per roadmap.sh

## Description From Site 

The goal of this project is to setup a scheduled workflow to backup a Database every 12 hours and upload the backup to Cloudflare R2 which has a free tier for storage.

## Requirements

The pre-requisite for this project is to have a server setup and a database ready to backup. You can use one of the projects did in the other project. Alternatively:

 - Setup a server on Digital Ocean or any other provider
 - Run a MongoDB instance on the server
 - Seed some data to the database

Once you have a server and a database ready, you can proceed to the next step.

### Scheduled Backups

You can do this bit either by setting up a `cron job` on the server or alternatively setup a `scheduled workflow` in Github Actions that runs every 12 hours and execute the backup from there. Database should be backedup up into a tarball and uploaded to `Clouodflare R2`.

Hint: You can use the `mongodump` to dump the database and then use `aws cli` to upload the file to R2.

### Stretch Goal

Write a script to download the latest backup from R2 and restore the database.

Database backups are essential to ensure that you can restore your data in case of a disaster. This project will give you hands on experience on how to setup a scheduled workflow to backup a database and how to restore it from a backup.

## prerequisites

- Setup the following repository secrets:
    - DO_TOKEN : Digital Ocean access token
    - DO_SPACES_SECRET_KEY : Digital Ocean spaces secret key (for Terraform state file)
    - DO_SPACES_ACCESS_KEY : Digital Ocean spaces access key (for Terraform state file)
    - DO_SSH_PUBLIC_KEY : Keypair to be used for VM 
    - DO_SSH_PRIVATE_KEY : Keypair to be used for VM
    - VM_HOST: IP or hostname of VM host

- Will piggyback off of [Multi Container Application](https://github.com/D3jag0re/multi-container-application)
    - While Mongo runs in a container, data is peristed on the host VM

## To Run backup Manually 

- Trigger workflow OR you can:
    - copy backupDB.sh and restoreDB.sh to host VM
    - Run 

## To Run backup Automatically 

- Uncomment lines 5 &  6 in dbBackup.yml 
- Wait

## To Run Restore 

- SSH into host VM:
    - Pull down desired backup from spaces
    - unzip
    - follow manual commands in script 

## Notes 

- Will be using DO spaces instead of cloudflare since it is already setup across the board
- Will implement stretch goal
- Using GHA scheduled workflow instead of cronjob due to key mgmt 

## Lessons Learned

- Mongo was not installed on host VM as it only runs in the container. I wanted to keep everything container based so am running the mongo commands inside the container.
- Was trying to do too many steps in one not realizing I was trying to execute one command inside the remote server instead of on the runner as it should have been. Context is key.
- in scp, cannot read the key directy from the GitHub secret, so had to pass it through first ... but it also doesnt like the format....
- scp was treating the variables timecode literally so had to add a command to interpret them when running 

- Took a step back and re-thought the process. Made sure S3 tools was installed on remote server and then did the upload through the remote server as well. 
