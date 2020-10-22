#!/bin/bash

echo -e "\e[93m _____               _  ______            _      _   _        ";
echo "/  __ \             | | | ___ \          | |    | | | |       ";
echo "| /  \/ __ _ _ __ __| | | |_/ / __ _  ___| | __ | | | |_ __   ";
echo "| |    / _\` | '__/ _\` | | ___ \/ _\` |/ __| |/ / | | | | '_ \  ";
echo "| \__/\ (_| | | | (_| | | |_/ / (_| | (__|   <  | |_| | |_) | ";
echo -e "\e[48;5;17m \____/\__,_|_|  \__,_| \____/ \__,_|\___|_|\_\  \___/| .__/  \e[49m";
echo "                                                      | |     ";
echo -e "                                                      |_|     \e[39m";

echo -e "\e[44mList of connected medias\e[49m"


lsblk -lo LABEL,MOUNTPOINT,SIZE,FSTYPE,NAME | grep /media

echo -e "\n\e[44mWich one do you want to backup ?\e[49m (type the corresponding number)"

options=$(lsblk -lo MOUNTPOINT | grep ^/media)

select choice in $options cancel
do
        test -n "$choice" && break
        echo "Device does not exist"
done

if [ $choice = "cancel" ]
then
        exit
fi

echo -e "\e[33m"
du -sh $choice
echo "==============================="
tree -shn $choice
echo -e "\e[39m"

echo "Are you sure ?"
