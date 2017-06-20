#!/bin/bash
# Extremely simple script to alert when the (inaccurate) size of your backup is less than usual.

BACKUPFILE=$1
MINSIZE=$2


if [[ $# -eq 2 ]]; then

    if [ -e $BACKUPFILE ]; then
        FILESIZE=$(du -m $BACKUPFILE | cut -f1)

        if [[ $FILESIZE -ge $MINSIZE ]]; then
            echo "$BACKUPFILE filesize: ($FILESIZE MiB) OK"
        else
            echo "WARNING! $BACKUPFILE size ($FILESIZE MiB) less than $MINSIZE MiB!"
        fi

    else
        echo "WARNING! No such file: $BACKUPFILE";
    fi

else
    echo    'Usage: checkbackupfile.sh FILE... FILESIZE...'
    echo -e "\tFILESIZE should be specified in Mebibytes (powers of 1024)."
fi
