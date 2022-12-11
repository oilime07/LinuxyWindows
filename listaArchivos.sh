#!/bin/bash

opc=$(dialog --title "Archivos" \
                   --stdout \
                   --checklist "Selecciona una opción:" 0 0 3 \
                               	1 ArchivosLocales off\
                               	2 ArchivosRemotos off\
                               	3 Regresar off)
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
				salida=$(dialog --title "Listando Archivo" \
                   			--stdout \
                   			--fselect /home/emilio/usuario/$NOMBRE/  20 70)
				clear
				bash /home/emilio/Escritorio/menu.sh
			else
				clear
				dialog --title "ERROR" \
       					--begin 10 60 \
       					--msgbox "LO SIENTO EL USUARIO ${res^^} NO EXISTE" 10 30
				bash /home/emilio/Escritorio/menu.sh
			fi
	;;
	2)
	clear
		res=$(dialog --title "Ingresa el nombre del usuario" \
                   --stdout \
                   --inputbox "¿Cual es el usuario?" 0 0)
                        mysql -u root -p442737 -e "use usuarios; SELECT nombre FROM usuario WHERE nombre = '$res';" > /tmp/dire.txt 
                NOMBRE=$( cat /tmp/dire.txt | grep $res )
                echo $NOMBRE
		if [ $res = $NOMBRE ]; then
                                clear
                                echo $res > /home/emilio/Escritorio/syc/usuario1/archivo.txt
				cat /home/emilio/Escritorio/syc/usuario1/respuestaW.txt
				
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

