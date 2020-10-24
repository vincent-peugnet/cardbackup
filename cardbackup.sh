#!/bin/bash

export TMP_DIR=$(mktemp -dt cardbackup-XXXXXXXX)
echo "tmp_dir : "$TMP_DIR

# Copy all output to log file without ansi color tags
exec &> >(tee >(sed 's/\x1b\[[0-9;]*m//g' > $TMP_DIR/cardbackup.log))

confirm() {
    echo -e "\n\e[44m$*\e[49m"
    read -p "continue (y/N)?" choice
    case "$choice" in
    y | Y) echo "yes !" ;;
    *) exit 1 ;;
    esac
}

report() {
    template="./report/report_template.tex"
    report="$TMP_DIR/report.tex"
    summary="$TMP_DIR/summary.tex"
    log="$TMP_DIR/rsync.log"
    ./analysedir.sh "$1"
    cat $template \
        | sed -e "s#<summary>#\\\input{$summary}#g" \
        | sed -e "s#<log>#\\\VerbatimInput{$log}#g" \
        > $report
    pdflatex $report --interaction batchmode 1> /dev/null
}


echo -e "\e[93m _____               _  ______            _      _   _        ";
echo "/  __ \             | | | ___ \          | |    | | | |       ";
echo "| /  \/ __ _ _ __ __| | | |_/ / __ _  ___| | __ | | | |_ __   ";
echo "| |    / _\` | '__/ _\` | | ___ \/ _\` |/ __| |/ / | | | | '_ \  ";
echo "| \__/\ (_| | | | (_| | | |_/ / (_| | (__|   <  | |_| | |_) | ";
echo -e "\e[48;5;17m \____/\__,_|_|  \__,_| \____/ \__,_|\___|_|\_\  \___/| .__/  \e[49m";
echo "2020                                                  | |     ";
echo -e "                                                      |_|     \e[39m";

date

# _____________ SELECT MEDIA ____________________

echo -e "\n\e[44mList of connected medias\e[49m"


list=$(lsblk -lo MOUNTPOINT | grep ^/media)

if [ -z "$list" ]
then
    echo "none :("
else
    lsblk -lo MOUNTPOINT,SIZE,FSTYPE,NAME | grep ^/media
fi

echo -e "\n\e[44mWich one do you want to backup ?\e[49m (type the corresponding number)"

options=$(lsblk -lo MOUNTPOINT | grep ^/media)

select src in $options cancel
do
    test -n "$src" && break
    echo "Device does not exist"
done

if [ $src = "cancel" ]
then
    exit
fi

cardsize=$(df --output=size -B1 $src | sed -n 2p)
cardused=$(df --output=used -B1 $src | sed -n 2p)


echo -e "\e[33m"
tree -shn $src
echo "==============================="
du -sh $src
echo "==============================="

echo "Card total size         : $(numfmt --to=iec-i --format='%18.2f' $cardsize)o"
echo "Card total size (bytes) : $(printf %16d $cardsize )"
echo "Card used size          : $(numfmt --to=iec-i --format='%18.2f' $cardused)o"
echo "Card used size  (bytes) : $(printf %16d $cardused )"
echo -e "\e[39m"

confirm "You are going to backup this card"





# _____________ SELECT TARGET ____________________



dir=$(zenity --file-selection --directory 2>/dev/null)

if [[ ! -d $dir ]]
then
    echo -e "\n\e[101mdirectory does not exist !!!\e[49m"
    exit
fi

# check if there is enought available disk space

diskavail=$(df --output=avail -B1 $dir | sed -n 2p)


if [[ $cardused -gt $diskavail ]]
then
    let "missingspace = $cardused - $diskavail"
    echo -e "\n\e[101mNot enought disk space available !!!\e[49m"
    echo "Missing space : $(numfmt --to=iec-i --format='%18.2f' $missingspace)o"
    exit
fi

echo -e "\n\e[44mDisk where the card will be copied in :\e[49m"
df -h $dir


echo -e "\n\e[44mDo you want to analyse your backuped card and create a log\e[49m"
read -p "(y/N)?" analyse


# _____________ LAUNCH RSYNC ____________________





confirm "you have choosen the backup directory $dir"


echo -e "\e[34m"
rsync -avh --progress --stats --log-file=$TMP_DIR/rsync.log --preallocate $src $dir
echo -e "\e[39m"

cardname=$(basename $src)

case "$choice" in
y | Y) report "$dir/$cardname" ;;



esac


