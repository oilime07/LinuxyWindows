#!/bin/bash

proceso=/home/emilio/Escritorio/syc/procesos2/listaP.txt
if [ -f $proceso ]; then
	rm -f $proceso
	ps -e > /home/emilio/Escritorio/syc/procesos2/listaP.txt
else
	ps -e > /home/emilio/Escritorio/syc/procesos2/listaP.txt
fi

salida=$(dialog --title "KILL" \
                   --stdout \
                   --inputbox "INGRESA EL PID DE LA MUERTE" 0 0)
echo $salida > /home/emilio/Escritorio/syc/procesos2/ejecutableW.txt

bash /home/emilio/Escritorio/menu.sh



