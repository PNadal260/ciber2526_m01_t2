#!/bin/bash

PORT=9999
CURRENT_VERSION="0.5"
IP_CLIENT="localhost"

clear

echo "Servidor de RECTP v$CURRENT_VERSION"

echo "0. Listen"

DATA=`nc -l -p $PORT`

echo "3.1. test de datos"

HEADER=`echo $DATA | cut -d " " -f 1`

if [ "$HEADER" != "RECTP" ]
then
	echo "ERROR 1: Cabecera errónea"

	sleep 1
	echo "HEADER_KO" | nc $IP_CLIENT -q 0 $PORT

	exit 1
fi

VERSION=`echo $DATA | cut -d " " -f 2`

if [ "$VERSION" != "$CURRENT_VERSION" ]
then
	echo "ERROR2: Versión errónea"

	sleep 1
	echo "HEADER_KO" | nc $IP_CLIENT -q 0 $PORT

	exit 2
fi

echo "3.2. RESPONSE Enviando Header_OK"

sleep 1
echo "HEADER_OK" | nc $IP_CLIENT -q 0 $PORT

echo "4. LISTEN"

DATA=`nc -l -p $PORT`
