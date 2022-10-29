#!/bin/bash

helm repo add stable https://charts.longhorn.io
helm repo update
LIST=$(helm search repo longhorn --versions | sed -n '2p')

FILE=./current.txt
# if file existe
if test -f "$FILE"; then
    echo '.file exist'
    CURRENT=$(cat ./current.txt)
    SIZE=${#CURRENT}
    #if variable is not empty
    if [ $CURRENT > 1 ]
    then
        echo '.  variable not empty'
        CURRENT=$(cat ./current.txt | sed -n '1p')
        #if current version is found in list
        if [[ "$LIST" == *"$CURRENT"* ]]; then
          echo '.      last version=yes'
          echo '.        update=no'
          UPDATE='NO'
        else
          echo '.      last version=no'
          echo '.        update=yes'
          UPDATE='YES'
        fi
    else
        echo '.  variable empty'
        echo '.    update=yes'
        UPDATE='YES'
    fi
else
    echo '.file NOT exist'
    echo '.  update=yes'
    UPDATE='YES'
fi

if [[ "$UPDATE" == 'YES' ]]; then
  echo 'Updating helm chart'
  rm -f *.tgz
  rm -Rf ./longhorn
  helm pull stable/longhorn
  helm pull stable/longhorn --untar
  CURRENT=$(ls longhorn-*.* | sed 's/longhorn-//g' | sed 's/.tgz//g')
  echo $CURRENT > ./current.txt
  logDate=$(date '%Y-%m-%d')
  echo "$logDate : update to $CURRENT" >> ./history.log
else
  echo "$logDate : No update needed" >> ./history.log
fi
