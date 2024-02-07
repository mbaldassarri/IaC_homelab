#!/bin/bash

echo "Deleting junk files from Data drive"

cd /media/Data

find . -type f -name '._*' -delete
find . -type f -name 'Thumbs.db' -delete
find . -type f -name '.DS_Store' -delete
find . -type f -name '.metadata' -delete
find . -type f -name '.directory' -delete
find . -type f -name '.localized' -delete
find . -type f -name '~$*' -delete
find . -type f -name '*.tmp' -delete
find . -type f -name '*.TMP' -delete

echo "Copying files from Data Drive to Disaster recovery Backup Drive"


SOURCE_DIR="/media/Data/"
DESTINATION_USER="user"
DESTINATION_HOST="destination.host.org"
DESTINATION_DIR="/media/Backup"
DESTINATION_PORT="22"

/usr/bin/rsync -zavh --delete --log-file="rsync.log" --exclude-from="rsync-exclude-list.txt" -e "ssh -p $DESTINATION_PORT" "$SOURCE_DIR" "$DESTINATION_USER"@"$DESTINATION_HOST":"$DESTINATION_DIR"

echo "Remote Backup Completed !"