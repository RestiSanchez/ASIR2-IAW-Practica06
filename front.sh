#!/bin/bash

# Marcamos los pasos
set -x
# Actualizamos la lista de paquetes
apt update

#Actualizamos los paquetes
apt upgrade -y

###########################
#Comenzamos la instalación#
###########################

# Instalamos nginx
apt install nginx -y

# Instalamos los módulos de PHP
apt install php-fpm php-mysql -y

# Cambiamos al directorio inicial
cd /home/ubuntu
