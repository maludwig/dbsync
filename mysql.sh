#!/bin/bash
DBUSER=$1
DBPASS=$2
FUNC=$3

function list-dbs {
	echo "show databases;" | mysql -u"${DBUSER}" -p"${DBPASS}" --skip-column-names 2> /dev/null | grep -v "information_schema" | grep -v "performance_schema" | grep -v "mysql"
}
function list-tables {
	find /var/lib/mysql/${1}/ -name '*.ibd' | cut -d'/' -f6 | cut -d'.' -f1
}
function list-updated-tables {
	find /var/lib/mysql/${1}/ -name '*.ibd' -newer ${2} | cut -d'/' -f6 | cut -d'.' -f1
}

if [ "$FUNC" == "list-dbs" ]; then
	list-dbs
elif [ "$FUNC" == "list-tables" ]; then
	list-tables "$4"
elif [ "$FUNC" == "list-updated-tables" ]; then
	list-updated-tables "$4" "$5"
else
	echo 'Unrecognized command, oh no!'
fi

