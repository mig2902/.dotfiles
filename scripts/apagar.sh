#!/bin/sh

var=$(printf "Apagar\nBloquear\nReiniciar\nSalir\nCancelar" | rofi -dmenu -theme material -eh 2 -i -p "¿Desea salir?") 

if [ "$var" == 'Apagar' ]
then
    systemctl poweroff
elif [ "$var" == 'Bloquear' ]
then
    blurlock
elif [ "$var" == 'Reiniciar' ]
then
    systemctl reboot
elif [ "$var" == 'Salir' ]
then
    bspc quit
elif [ "$var" == 'Cancelar' ]
then
    echo cancelado
fi


