#!/bin/bash

opc=$(dialog --title "Proyecto En Redes" \
                   --stdout \
                   --checklist "Selecciona una opción:" 0 0 10 \
                               	1 CrearUsuario off\
                               	2 ModificarUsuario off\
                               	3 EliminarUsuario off\
			      	4 ListarProcesos off\
				5 MatarProcesos off\
				6 ListarArchivos off\
				7 EnviarArchivos off\
				8 EnviarMensaje off\
				9 LeerMensajes off\
				10 Salir*** off)
echo "Has elegido: $opc"
case $opc in
	1)
	clear
	bash /home/emilio/Escritorio/entradaUsuario.sh
	;;
	2)
	clear
	bash /home/emilio/Escritorio/editaUsuario.sh
	;;
	3)
	clear
	bash /home/emilio/Escritorio/eliminaUsuario.sh	
	;;
	4)
        clear
	bash /home/emilio/Escritorio/getprocesos.sh         
        ;;
	5)
        clear
        bash /home/emilio/Escritorio/setprocesos.sh
        ;;
	6)
        clear
        bash /home/emilio/Escritorio/listaArchivos.sh
        ;;
	7)
        clear
        bash /home/emilio/Escritorio/enviarArchivos.sh
        ;;
	8)
        clear
          
        ;;
	9)
        clear
          
        ;;
	10)
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
