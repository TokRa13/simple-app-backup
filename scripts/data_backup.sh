#!/bin/bash

echo -e "Data dump start at $(date)\n"

source ../common.conf
source $1

src_dir=$2

ftp_path=$ftp_path/$app_name

mkdir -p $bckp_path/$app_name/data
mkdir -p $snap_dir
if [ $(date '+%w') -eq $dow ];
then
# If current Day of Week is $dow then:
# create snapshot file and do a full backup
tar --listed-incremental=$snap_dir/$(date '+%A') --totals -cpzf $bckp_path/$app_name/data/$app_name.tar.gz $src_dir

else
# else rename yesterday's snapshot file and do an incremental backup
mv $snap_dir/$(date +%A -d "-1 days") $snap_dir/$(date '+%A')
tar --listed-incremental=$snap_dir/$(date '+%A') --totals -cpzf $bckp_path/$app_name/data/$app_name.tar.gz $src_dir

fi

# Make dir in FTP
remotepath_tmp=$remotepath
for d in $(echo $ftp_path/$(date +%d-%m-%Y) | tr '/' '\n')
do
echo mkdir ${remotepath_tmp}/${d} | sftp $sftp_cred
remotepath_tmp="${remotepath_tmp}/${d}"
echo $remotepath_tmp
done

# Copy files

scp -r $bckp_path/$app_name/data $sftp_cred:$remotepath/$ftp_path/$(date +%d-%m-%Y)
scp -r $bckp_path/$app_name/db $sftp_cred:$remotepath/$ftp_path/$(date +%d-%m-%Y)

echo -e "\nData dump finish at $(date)"
