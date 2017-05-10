#!/bin/bash

echo "Dump start at $(date)"

config_file="confl_backup.conf"

source ../common.conf
source $config_file

../scripts/mysql_dump.sh $config_file confluencedb
../scripts/data_backup.sh $config_file /var/atlassian/application-data/confluence/
../scripts/rotate.sh $config_file data/$app_name.tar.gz
../scripts/rotate.sh $config_file db/confluencedb.sql.tar.gz

rm -rf $bckp_path/$app_name
#echo "To delete $bckp_path/$app_name"

mail -s "$app_name Backup Log" $mailto < $app_name.log

echo "Dump end at $(date)"
