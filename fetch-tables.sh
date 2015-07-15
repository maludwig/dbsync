#!/bin/bash
RDBUSER=$1
RDBPWD=$2

CWD=`pwd`

echo "[ $(date +%F_%H-%M-%S) ] Creating dumps..."
ssh sql02az@portal.splicesoftware.com "bash -s" -- < /root/bin/backup-all-dbs.sh $RDBUSER $RDBPWD

cd /home/shared/dumps/

echo "[ $(date +%F_%H-%M-%S) ] Downloading dumps..."
TABLES=`rsync -a --out-format='%n' sql02az@portal.splicesoftware.com:/home/sql02az/dumps/ ./`
chown -R root:shared /home/shared/dumps/
chmod -R o-rwx /home/shared/dumps/
echo "[ $(date +%F_%H-%M-%S) ] Done"
cd $CWD
echo $TABLES

