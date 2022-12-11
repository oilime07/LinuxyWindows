#!/bin/bash
mysql -u root -p442737 -e "use usuarios; select nombre from usuario;" > /tmp/usuario.txt
sed -i "1d" /tmp/usuario.txt
dialog --title "Usuarios Existentes" \
       --tailbox /tmp/usuario.txt  0 0; clear 

res=$(dialog --title "INGRESA EL USUARIO A MODIFICAR" \
                   --stdout \
                   --inputbox "¿Cual es tu nombre?" 0 0)

dialog --title "USUARIO INGRESADO ${res^^}" \
       --yesno "¿Quiere continuar?" 0 0
ans=$?
if [ $ans -eq 0 ]; then
	mysql -u root -p442737 -e "use usuarios; select nombre from usuario where nombre = '$res';" > /tmp/usuarionuevo.txt
	sed -i "1d" /tmp/usuarionuevo.txt
	exi=$(sed -n 1p /tmp/usuarionuevo.txt)
	
	if [ $res = $exi ]; then
	opc=$(dialog --title "Proyecto En Redes" \
                   --stdout \
                   --checklist "${res^^}:" 0 0 2 \
                               	1 CambiarNombre off\
                               	2 Contraseña off)
		echo "Has elegido: $opc"
		case $opc in
		1)
		clear
			
		dialog --backtitle "ACTUALIZACION:" --clear --title "Nuevos Datos"  --form "\nIngresa los datos:" 20 50 3 \ "Nuevo nombre:" 1 1 "" 1 20 30 30  > /tmp/new \
		2>&1 >/dev/tty
		retval=$?
		NOMBRE=`sed -n 1p /tmp/new`
		if [ $retval -eq 0 ]; then
				
				mysql -u root -p442737 -e "use usuarios; update usuario SET nombre = '$NOMBRE' WHERE nombre = '$res'"; \ 2>&1 >/dev/tty
				PUB=/home/emilio/usuario/$res/publica$res
                                PRI=/home/emilio/usuario/$res/privada$res
                                FIR=/home/emilio/usuario/$res/firma.sg
				
				mv -f /home/emilio/usuario/$res/publica$res /home/emilio/usuario/$NOMBRE/publica$NOMBRE
				mv -f $NOMBRE/privada$res $NOMBRE/privada$NOMBRE \ 2>&1 >/dev/tty
				
				PUBLICA=/home/emilio/usuario/$NOMBRE/publica$NOMBRE
				PRIVADA=/home/emilio/usuario/$NOMBRE/privada$NOMBRE
				FIRMA=/home/emilio/usuario/$NOMBRE/firma.sg
				
				mysql -u root -p442737 -e "use usuarios; update usuario SET publica = '$PUBLICA' WHERE publica = '$PUB'"; \ 2>&1 >/dev/tty
				mysql -u root -p442737 -e "use usuarios; update usuario SET privada = '$PRIVADA' WHERE privada = '$PRI'"; \ 2>&1 >/dev/tty
				mysql -u root -p442737 -e "use usuarios; update usuario SET firma = '$FIRMA' WHERE firma = '$FIR'"; \ 2>&1 >/dev/tty
				dialog --clear --msgbox "LISTO...Se creo ${NOMBRE^^}" 0 0
				sudo usermod -l $NOMBRE $res
				bash /home/emilio/Escritorio/menu.sh
		else
			echo "ups algo salio mal"
		fi
		;;
		2)
		dialog --backtitle "ACTUALIZACION:" --clear --title "Nuevos Datos"  --form "\nIngresa los datos:" 20 50 3 \ "Contraseña:" 1 1 "" 1 20 30 30  \ "Nueva Contrasena:" 2 1 "" 2 20 30 30 > /tmp/new \
		2>&1 >/dev/tty
		retval=$?
		CONTRA=`sed -n 1p /tmp/new`
		CONTRA2=`sed -n 2p /tmp/new`
		if [ $retval -eq 0 ]; then
				clear
				sudo passwd $res
				mysql -u root -p442737 -e "use usuarios; update usuario SET contrasena = '$CONTRA2' WHERE contrasena = '$CONTRA'"; \ 2>&1 >/dev/tty 
				
				mysql -u root -p442737 -e "use usuarios; update usuario SET contrasena = '$CONTRA2' WHERE contrasena = '$CONTRA'"; \ 2>&1 >/dev/tty
				dialog --clear --msgbox "LISTO...Se creo ${NOMBRE^^}" 0 0
				
				bash /home/emilio/Escritorio/menu.sh
		else
			echo "ups algo salio mal"
		fi
		clear
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
	else
        dialog --msgbox "Lo siento el usuario ${res^^} no existe" 0 0
	clear
	bash /home/emilio/Escritorio/menu.sh
	fi
else
	bash /home/emilio/Escritorio/menu.sh

fi
