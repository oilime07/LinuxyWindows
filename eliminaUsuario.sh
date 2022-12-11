#!/bin/bash
mysql -u root -p442737 -e "use usuarios; select nombre from usuario;" > /tmp/usuarioDel.txt
sed -i "1d" /tmp/usuarioDel.txt
dialog --title "Usuarios Existentes" \
       --tailbox /tmp/usuarioDel.txt  0 0; clear 

res=$(dialog --title "INGRESA EL USUARIO A ELIMINAR" \
                   --stdout \
                   --inputbox "¿Cual es tu nombre?" 0 0)

dialog --title "USUARIO INGRESADO ${res^^}" \
       --yesno "¿SEGURO QUE QUIERES ELIMINARLO?" 0 0
ans=$?
if [ $ans -eq 0 ]; then
        mysql -u root -p442737 -e "use usuarios; select nombre from usuario where nombre = '$res'"; > /tmp/usuarioDel1.txt
        sed -i "1d" /tmp/usuarioDel1.txt
        exi=$(sed -n 1p /tmp/usuarioDel1.txt)

		if [ -e /home/emilio/usuario/$res ]; then
			rm -r -f /home/emilio/usuario/$res
			mysql -u root -p442737 -e "use usuarios; DELETE from usuario WHERE nombre = '$res'"; \ 2>&1 >/dev/tty
			sudo deluser $res
			
		else
			mysql -u root -p442737 -e "use usuarios; DELETE from usuario WHERE nombre = '$res'"; \ 2>&1 >/dev/tty
			
		fi
		if [ -e /home/emilio/usuario/$res ]; then
			dialog --msgbox "No se borro" 0 0
                        clear
                        bash /home/emilio/Escritorio/menu.sh
		else
			dialog --msgbox "Se borro con exito a ${res^^}" 0 0
        		clear
        		bash /home/emilio/Escritorio/menu.sh
		fi
else
	bash /home/emilio/Escritorio/menu.sh
fi

use usuarios; delete from usuarios where nombre='Leonardo';
