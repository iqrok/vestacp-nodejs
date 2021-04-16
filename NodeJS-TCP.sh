#!/bin/bash

user=$1
domain=$2
ip=$3
home=$4
docroot=$5
nodejsport=$(cat "$home/$user/web/$domain/pm2.json" | grep "PORT" | grep -Po "[\d]+")

find "$home/$user/conf/web/$domain/" -type f -exec sed -i "s/\%nodejsport\%/${nodejsport}/g" {} \;

mkdir -p "$home/$user/web/$domain/nodeapp"
chown -R $user:$user "$home/$user/web/$domain/nodeapp"
runuser -l $user -c "pm2 start $home/$user/web/$domain/pm2.json"
