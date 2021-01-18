#!/bin/sh
up=''
down=''
altdisplay=''

check_error() {
    if [[$up == "true" && $down == "true" ]]; then
        echo "Can't do up and down!"
        exit 1
    fi
}

while getopts 'uda' flag; do
    case "${flag}" in
        u) up='true' ;;
        d) down='true' ;;
        a) altdisplay='true' ;;
        *) echo "-u for up\n-d for down\n-a for alternate display";;
    esac
done

if [[ $up == "true" && $down == "true" ]]; then
    echo "Can't do up and down!"
    exit 1
fi

if [[ $altdisplay == "true" ]]; then
    mon=$(brightnessctl -l|grep "ddcci*"|awk '{print $2 }'|sed s/\'//g)
    if [[ $mon == "" ]]; then
        echo "No external monitor!"
        exit 1
    fi
else
    mon=$(brightnessctl -l|grep "intel*"|awk '{print $2 }'|sed s/\'//g)
fi

if [[ $up == "true" ]]; then
    brightnessctl --device=$mon set +5%
else
    brightnessctl --device=$mon set 5%-
fi


