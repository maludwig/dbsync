DBUSER=$1
DBPASS=$2
FUNC=$3

function list-dbs {
	echo "Connecting with: ${DBUSER}:${DBPASS}"
}
function list-tables {
	echo "Listing ${1}, with ${DBUSER}:${DBPASS}"
}
if [ "$FUNC" == "list-dbs" ]; then
	list-dbs
elif [ "$FUNC" == "list-tables" ]; then
	list-tables $4
else
	echo 'Unrecognized command, oh no!'
fi

