#!/bin/bash

#inits workspace

UUT=$1
static_ip=${2:-$1}

#wdir=$(dirname $(realpath "${BASH_SOURCE[0]}" ))
wdir="workspaces"

create_workspace(){

    if [ -d "$wdir/$UUT" ]; then
        #rm "$wdir/$UUT" -rf #debug
        return 1
    fi

    #Copy and update new workspace
    cp -r $wdir/template "$wdir/$UUT/"
    cd "$wdir/$UUT/"
    find . -type f -exec sed -i 's/'UUT_HOSTNAME'/'$UUT'/g' {} +
    find . -type f -exec sed -i 's/'UUT_IP'/'$static_ip'/g' {} +

    echo "Workspace created hostname: ${UUT} ip: ${static_ip}"
}

if [ -z "$UUT" ]; then
    echo "Using workspace NONE"
    echo "osgi.instance.area.default=@user.home/workspaces/<UUT HERE>" >> ~/PROJECTS/cs-studio/configuration/config.ini
else
    create_workspace
    echo "Using workspace $UUT"
    echo "osgi.instance.area.default=@user.home/workspaces/${UUT}" >> ~/PROJECTS/cs-studio/configuration/config.ini
fi