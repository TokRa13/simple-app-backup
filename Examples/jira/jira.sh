#!/bin/bash

echo "Dump start at $(date)"

source_file="jira.conf"

source ../common.conf
source $source_file

../scripts/mysql_dump.sh $source_file jiradb
../scripts/mysql_dump.sh $source_file jiralicensedb
../scripts/data_backup.sh $source_file /home/jira
../scripts/rotate.sh $source_file data/$app_name.tar.gz
../scripts/rotate.sh $source_file db/jiradb.sql.tar.gz
../scripts/rotate.sh $source_file db/jiralicensedb.sql.tar.gz

rm -rf $bckp_path/$app_name
#echo "To delete $bckp_path/$app_name"

mail -s "$app_name Backup Log" $mailto < $app_name.log

echo "Dump end at $(date)"
