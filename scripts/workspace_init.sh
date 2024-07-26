#!/bin/bash

#inits workspace

UUT=$1
IP=${2:-$1}

username=$(whoami)
wdir="/home/$username/workspaces"
macro_file=".metadata/.plugins/org.eclipse.core.runtime/.settings/org.csstudio.opibuilder.prefs"
dns_file=".metadata/.plugins/org.eclipse.core.runtime/.settings/org.csstudio.diirt.util.core.preferences.prefs"

set_key_value(){
    #sets key value in file 
    key=$1
    value=$2
    filename=$3

    if grep -q "$key" "$filename"; then
        #key exists
        sed -i "s/^${key}.*/${key}${value}/" "$filename"
    else
        #key doesnt exist
        echo "${key}${value}" >> $filename
    fi
}

create_workspace(){
    #Creates new workspace from template and updates macro
    #macros="UUT","HOSTNAME"

    if [ -d "$wdir/$UUT" ]; then
        echo "Using existing workspace"
        return 1
    fi

    cp -r $wdir/template "$wdir/$UUT/"
    cd "$wdir/$UUT/"
    set_key_value "macros=" ""UUT","${UUT}"" $macro_file

    #find . -type f -exec sed -i 's/'UUT_HOSTNAME'/'$UUT'/g' {} + #old

    echo "Workspace created hostname: ${UUT} ip: ${IP}"
}

update_ip(){
    #sets the uuts ip because windows wont share its nameserver >:(
    #diirt.ca.addr.list=localhost IP
    cd "$wdir/$UUT/"
    set_key_value "diirt.ca.addr.list=" "localhost ${IP}" $dns_file
}

if [ -z "$UUT" ]; then
    echo "Using workspace NONE"
    echo "osgi.instance.area.default=@user.home/workspaces/<UUT HERE>" >> /d-tacq/cs-studio/configuration/config.ini
else
    create_workspace
    update_ip
    echo "Using workspace $UUT"
    echo "osgi.instance.area.default=@user.home/workspaces/${UUT}" >> /d-tacq/cs-studio/configuration/config.ini
fi
