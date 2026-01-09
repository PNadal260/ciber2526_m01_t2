#!/bin/bash

AUDIO_FILE="audio.wav"

PORT=9999
CURRENT_VERSION="0.5"
IP_SERVER="localhost"

clear

echo "Cliente del protocolo RECTP v$CURRENT_VERSION"

echo "1. SEND. Enviamos la cabecera al servidor"

sleep 1
echo "RECTP $CURRENT_VERSION" | nc $IP_SERVER -q 0 $PORT

RESPONSE=`nc -l -p $PORT`

echo "5. TEST. Header."

if [ "$RESPONSE" != "HEADER_OK" ]
then
	echo "Error 1: Cabeceras mal formadas"
	exit 1
fi

echo "6. SEND. Nombre de archivo"

sleep 1
echo "FILE_NAME $AUDIO_FILE" | nc $IP_SERVER -q 0 $PORT

echo "7. LISTEN. FILE_NAME_OK"

RESPONSE=`nc -l -p $PORT`

echo "10. TEST. FILE_NAME_OK "

if [ "$RESOIBSE" != "FILE_NAME_OK" ]
then
	echo "Error 2: Nombre de archivo incorrecto o mal formado"
	exit 2
fi

echo "11. SEND. FILE DATA"

sleep 1
cat audio.wav | nc $IP_SERVER -q 0 $PORT 

echo "12. LISTEN"

RESPONSE=`nc -l -p $PORT`
