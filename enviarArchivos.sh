#!/bin/bash

opc=$(dialog --title "Archivos" \
                   --stdout \
                   --checklist "Selecciona una opción:" 0 0 2 \
                               	1 Enviar off\
                               	2 Regresar off)
case $opc in
	1)
	clear
		res=$(dialog --title "Ingresa el nombre del usuario" \
                   --stdout \
                   --inputbox "¿Cual es el usuario?" 0 0)
			mysql -u root -p442737 -e "use usuarios; SELECT nombre FROM usuario WHERE nombre = '$res';" > /tmp/dire.txt 
		NOMBRE=$( cat /tmp/dire.txt | grep $res )
		echo $NOMBRE
			if [ $res = $NOMBRE ]; then
				clear
				cd /home/emilio/usuario/$res
				sudo zip -r $res.zip /home/emilio/usuario/$res
				mysql -u root -p442737 -e "use usuarios; SELECT publica FROM usuario WHERE nombre = '$res';" > /tmp/dire.txt
				ruta=`sed -n 1p /tmp/dire.txt`
				sudo zip $res.zip /home/emilio/usuario/$res
				sudo openssl rsautl -encrypt -inkey $ruta -pubin -in $res.zip -out ENC$res.zip
				sudo rm -f /home/emilio/usuario/$res.zip
				sudo mv /home/emilio/usuario/ENC$res.zip /home/emilio/Escritorio/syc/archivoDirectorio/
				
			else
				clear
				dialog --title "ERROR" \
       					--begin 10 60 \
       					--msgbox "LO SIENTO EL USUARIO ${res^^} NO EXISTE" 10 30
				bash /home/emilio/Escritorio/menu.sh
			fi
	;;
	3)
	clear
	bash /home/emilio/Escritorio/menu.sh	
	;;
	*)
	clear
	dialog --title "ERROR" \
       --backtitle "Ups......" \
       --begin 10 60 \
       --msgbox "No puedes seleccionar dos opciones al mismo tiempo" 10 30
	bash /home/emilio/Escritorio/menu.sh
	;;
esac

 
