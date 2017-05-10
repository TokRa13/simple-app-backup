#!/bin/bash

source ../common.conf
source $1

toremove=$2

ftp_path=$ftp_path/$app_name

# Removing files older then $data_days days.
echo rm $remotepath/$ftp_path/$(date +%d-%m-%Y -d "-$data_days days")/$toremove | sftp $sftp_cred

# Removing dirs older then $data_days days.
echo rmdir $remotepath/$ftp_path/$(date +%d-%m-%Y -d "-$data_days days")/data/ | sftp $sftp_cred
echo rmdir $remotepath/$ftp_path/$(date +%d-%m-%Y -d "-$data_days days")/db/ | sftp $sftp_cred
echo rmdir $remotepath/$ftp_path/$(date +%d-%m-%Y -d "-$data_days days")/ | sftp $sftp_cred
