#!/bin/bash
RDBUSER=$1
RDBPWD=$2
LDBUSER=$3
LDBPWD=$4

CWD=`pwd`

TABLES=`./fetch-tables.sh $RDBUSER $RDBPWD`

cd /home/shared/dumps/
echo "[ $(date +%F_%H-%M-%S) ] Importing tables..."
for TABLE in $TABLES; do
	echo "[ $(date +%F_%H-%M-%S) ] --- Importing $TABLE ---"
	cat $TABLE | gunzip | mysql -u"$LDBUSER" -p"$LDBPWD" realtalk
done
echo "[ $(date +%F_%H-%M-%S) ] Done
cd $CWD
