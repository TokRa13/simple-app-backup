#!/bin/bash

source common.conf

# write out current crontab
crontab -l > tmpcron

app1_name="jira"
app2_name="confluence"
grep -v "# $app1_name backup" tmpcron > temp; mv temp tmpcron
grep -v "# $app2_name backup" tmpcron > temp; mv temp tmpcron

echo "00 02 * * * cd /root/backup/$app1_name && ./$app1_name.sh > $app1_name.log 2>&1 # $app1_name backup" >> tmpcron
echo "30 02 * * * cd /root/backup/$app2_name && ./$app2_name.sh > $app2_name.log 2>&1 # $app2_name backup" >> tmpcron

# install new cron file
crontab tmpcron
rm tmpcron
