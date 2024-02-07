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

echo "Copying files from Data Drive to External Backup HHD"

/usr/bin/rsync -zavh --delete --log-file="rsync.log" --exclude-from="rsync-exclude-list.txt" /media/Data/ /media/Backup/

echo "Local Backup Completed ! :)"
