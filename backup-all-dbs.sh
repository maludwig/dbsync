#!/bin/sh

if [ $# -ne 2 ] ; then
    echo "usage: $0 <user> <password>"
    exit 1
fi

TODAY=$(date +%F)
USER=$1
PASSWORD=$2
CWD=`pwd`
DUMPDIR="${HOME}/dumps/"

mkdir -p $DUMPDIR
cd $DUMPDIR

touch /home/sql02az/bin/this_dump.touch

DATABASES=`echo "show databases;" | mysql -u"${USER}" -p"${PASSWORD}" --skip-column-names 2> /dev/null | grep -v "information_schema" | grep -v "performance_schema" | grep -v "mysql"`
echo -e "### DATABASES ###\n${DATABASES}\n--- DATABASES ---"
for DB in $DATABASES; do
	mkdir $DB
	cd $DB
	pwd
	TABLES=`sudo /usr/local/sbin/updated-tables.sh ${DB} /home/sql02az/bin/last_dump.touch`
	for TABLE in $TABLES; do
		echo $TABLE > $TABLE
#		d=$(date +%s)
#		echo -n "#-# ${TABLE}.gz"
#		mysqldump -u ${USER} -p${PASSWORD} ${DB} ${TABLE} 2> /dev/null | gzip > "${TABLE}.sql.gz" 
#		el=`expr $(date +%s) - $d`
#		echo " ${el}s #-#"
	done
	cd ..
done
mv -f /home/sql02az/bin/this_dump.touch /home/sql02az/bin/last_dump.touch
cd ${CWD}
