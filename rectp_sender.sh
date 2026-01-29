#!/bin/bash


IP_SERVER="$1"


bash cliente.sh $IP_SERVER



echo "`date` $?" >> rectp_sender.log
