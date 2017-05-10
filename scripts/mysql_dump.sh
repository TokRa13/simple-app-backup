#!/bin/bash

source ../common.conf
source $1

#echo -e "MySQL dump start at $(date)\n"

db_name=$2

mkdir -p $bckp_path/$app_name/db

# Dumping Mysql

mysqldump -u $mysql_user -p$mysql_pass $db_name > $bckp_path/$app_name/db/$db_name.sql
tar -zcf $bckp_path/$app_name/db/$db_name.sql.tar.gz $bckp_path/$app_name/db/$db_name.sql
rm $bckp_path/$app_name/db/$db_name.sql

echo "File created $bckp_path/$app_name/db/$db_name.sql.tar.gz at $(date)"
#echo -e "\nMySQL dump finish at $(date)"
