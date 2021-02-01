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

# Copiamos la configuracion de nginx para comunicarse con php-fpm
cp /home/ubuntu/ASIR2-IAW-Practica06/default /etc/nginx/sites-available/default

# Copiamos la configuracion de php-fpm
cp /home/ubuntu/ASIR2-IAW-Practica06/www.conf /etc/php/7.4/fpm/pool.d/www.conf




# Cambiamos al directorio inicial
cd /home/ubuntu
