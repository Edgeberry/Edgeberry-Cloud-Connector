#!/bin/bash

##
#   uninstall.sh
#   Uninstall the Edgeberry Cloud Connect software
#
#   by Sanne 'SpuQ' Santens
##

APPNAME=Edgeberry
APPCOMP=CloudConnect

# Start a clean screen
clear;

# Check if this script is running as root. If not, notify the user
# to run this script again as root and exit
if [ "$EUID" -ne 0 ]; then
    echo -e "\e[0;31mUser is not root. Exit.\e[0m"
    echo -e "\e[0mRun this script again as root\e[0m"
    exit 1;
fi

# Prompt the user if they are sure they want to uninstall
# the Edgeberry software
read -r -p "Delete $APPNAME $APPCOMP software? [y/N]: " response
case "$response" in
    [yY])
        ;;
    *) 
        exit 0;
        ;;
esac

# Delete the Edgeberry software directory
echo -n -e "\e[0mDeleting the $APPNAME $APPCOMP software... \e[0m"
rm -rf /opt/$APPNAME/$APPCOMP
echo -e "\e[0;32m[Done] \e[0m";

# Stop the systemd service
systemctl stop io.edgeberry.cloudconnect
systemctl daemon-reload

# Delete the D-Bus policy for Edgeberry
echo -n -e "\e[0mDeleting the $APPNAME $APPCOMP D-Bus policy... \e[0m"
rm  /etc/dbus-1/system.d/edgeberry-cloud-connect.conf
echo -e "\e[0;32m[Done] \e[0m";

# Delete systemd service file for Edgeberry
echo -n -e "\e[0mDeleting the $APPNAME $APPCOMP systemd service... \e[0m"
rm  /etc/systemd/system/io.edgeberry.cloudconnect.service
echo -e "\e[0;32m[Done] \e[0m";

echo -n -e "\e[0mReloading the systemd daemon... \e[0m"
systemctl daemon-reload
echo -e "\e[0;32m[Done] \e[0m";

# Done uninstalling
echo -e "The $APPNAME $APPCOMP software was successfully removed"

exit 0;