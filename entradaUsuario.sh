#!/bin/bash

dialog --backtitle "Ingresa nuevo usuario:" --clear --title "Registro"  --form "\nNombre:" 20 50 1 \ "Usuario:" 1 1 "" 1 20 30 30 > /tmp/usr \
2>&1 >/dev/tty 

CONTRA=$(dialog --title "Contraseña" \
                 --stdout \
                 --passwordbox "Introduce la contraseña:" 0 0)
retval=$?
if [ $retval -eq 0 ]; then

NOMBRE=`sed -n 1p /tmp/usr`

if [ -d "/home/emilio/usuario/$NOMBRE" ]; then
		dialog --title "El usuario ya existe y tiene vinculado un directorio" \
       		--yesno "¿Quieres regresar al menu principal :) ?" 0 0
		ans=$?
		if [ $ans -eq 0 ];then
    			bash menu.sh
		else
   	 		clear
		fi 
else
	mkdir /home/emilio/usuario/$NOMBRE
	cd /home/emilio/usuario/$NOMBRE
fi
clear

#Creamos la llave PRIVADA DEL USUARIO
openssl genrsa -aes256 -out privada$NOMBRE 4096

cd /home/emilio/usuario/$NOMBRE

#Creamos la la PUBLICA DEL USUARIO
openssl rsa -pubout -out publica$NOMBRE -in privada$NOMBRE 

#Creamos la FIRMA del usuario
touch /home/emilio/usuario/$NOMBRE/correo.txt
openssl dgst -c -sign privada$NOMBRE -out firma.sig correo.txt


PUBLICA=/home/emilio/usuario/$NOMBRE/publica$NOMBRE
PRIVADA=/home/emilio/usuario/$NOMBRE/privada$NOMBRE
FIRMA=/home/emilio/usuario/$NOMBRE/firma.sg
sleep 3
echo $NOMBRE > /home/emilio/Escritorio/syc/usuario1/altaLinux.txt
echo $CONTRA >> /home/emilio/Escritorio/syc/usuario1/altaLinux.txt
echo $PUBLICA >> /home/emilio/Escritorio/syc/usuario1/altaLinux.txt
echo $PRIVADA >> /home/emilio/Escritorio/syc/usuario1/altaLinux.txt
echo $FIRMA >> /home/emilio/Escritorio/syc/usuario1/altaLinux.txt




mysql -u root -p442737 -e "insert into usuarios.usuario (nombre, contrasena, publica, privada, firma) values ('$NOMBRE', '$CONTRA', '$PUBLICA', '$PRIVADA', '$FIRMA' )" 2>/dev/null

	if [ -e $PUBLICA  ];then
		if [ -e  $PRIVADA ];then
				dialog --title "EXITO" \
      				 --msgbox "SALIDA EXITOSA" 0 0
				clear
				sudo adduser $NOMBRE --home /home/emilio/usuario/$NOMBRE --disabled-password
				sudo passwd $NOMBRE
				clear
				sleep 8
				sudo chown -R $NOMBRE: /home/emilio/usuario/$NOMBRE
				clear 
				bash /home/emilio/Escritorio/menu.sh
				if [ -e /home/emilio/Escritorio/syc/usuario1/respuesta/respuestaCrea.txt ]; then
					 dialog --title "BIEN" \
                 			--msgbox "CREADO REMOTO" 0 0 
					rm -r -f /home/emilio/Escritorio/syc/usuario1/respuesta/respuestaCrea.txt
				else
				 dialog --title "ERROR" \
                 			--msgbox "NO SE PUDO CREAR DE MANERA REMOTA" 0 0 
				fi
		else
			dialog --title "ERROR" \
      		 --msgbox "NO SE PUDO CREAR LA LLAVE PRIVADA" 0 0 

		fi
	else
		dialog --title "ERROR" \
       	--msgbox "NO SE PUDO CREAR LA LLAVE PUBLICA" 0 0 

	fi

fi
