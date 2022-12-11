#!/bin/bash


res=$(dialog --title "PROCESOS" \
                   --stdout \
                   --inputbox "¿Cual es el usuario?" 0 0)
$res > /home/emilio/Escritorio/syc/procesos2/setprocesos.txt

while IFS= read -r line
do
	echo "$line"

done < /home/emilio/Escritorio/syc/procesos2/listaW.txt

read  -t  10  -p  "10 segundos..."


