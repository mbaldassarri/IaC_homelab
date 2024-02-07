#!/bin/bash

echo "Deleting junk files from Samsung SSD Drive"

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

echo "Cleanup Data disk Completed ! :)"
