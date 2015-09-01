#!/bin/bash

USER=root
PASSWD=aeneinoi
DATE=`date +%Y%m%d%H%M`
IGN_TAB=""

for ign_tab in `cat table-ignore.txt`;
do
   IGN_TAB=${IGN_TAB}" --ignore-table=${ign_tab}"
done

for DATABASE in `cat db-list.txt`;
do
    mysqldump -u${USER} -p${PASSWD} --opt $DATABASE ${IGN_TAB} > $DATABASE-$DATE.sql
done

# Compress and clean
tar czvf mysql-back-$DATE.tar.gz *.sql
rm -rf *.sql
