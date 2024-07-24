#!/bin/bash

#generate new workspace from template
#Usage: ./new_workspace.sh acq2106_123
#Usage: ./new_workspace.sh acq2106_123 10.12.1.123

new_uut=$1
static_ip=${2:-$1}

echo $new_uut
echo $static_ip

wdir=$(dirname $(realpath "${BASH_SOURCE[0]}" ))

#Check for arg
if [ -z "${new_uut}" ]; then
    echo "USAGE ./new_workspace.sh UUT_HOSTNAME"
    exit 1
fi

#Check doesnt already exist
if [ -d "$wdir/$new_uut" ]; then
    echo "${new_uut} already exists"
    exit 1
fi

#Copy and update new workspace
cp -r $wdir/template "$wdir/$new_uut/"
cd "$wdir/$new_uut/"
find . -type f -exec sed -i 's/'UUT_HOSTNAME'/'$new_uut'/g' {} +
find . -type f -exec sed -i 's/'UUT_IP'/'$static_ip'/g' {} +

echo "Workspace ${new_uut} Created"