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

# Reiniciamos los servicios
systemctl restart php7.4-fpm
systemctl restart nginx

############
#PhpMyAdmin#
############

IP_MYSQL=


#Instalamos la utilidad unzip para descomprimir el codigo fuente

apt install unzip -y

#Descargamos el código fuente de phpMyAdmin del repositorio oficial

cd /home/ubuntu

rm -rf phpMyAdmin-5.0.4-all-languages.zip

wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.zip

# Descomprimimos el archivo
unzip phpMyAdmin-5.0.4-all-languages.zip

# Borramos el .zip
rm -rf phpMyAdmin-5.0.4-all-languages.zip

# Movemos el directorio de phpMyadmin
mv phpMyAdmin-5.0.4-all-languages/ /var/www/html/phpmyadmin

#Configuramos el archivo config.inc.php
cd /var/www/html/phpmyadmin

mv config.sample.inc.php config.inc.php

sed -i "s/localhost/$IP_MYSQL/" /var/www/html/phpmyadmin/config.inc.php

# ----------------------------#
# Instalamos la aplicación web#
# ----------------------------#

# Clonamos el repositorio
cd /var/www/html
rm -rf iaw-practica-lamp
git clone https://github.com/josejuansanchez/iaw-practica-lamp
mv /var/www/html/iaw-practica-lamp/src/* /var/www/html/

# Configuramos la IP del config.php
sed -i "s/localhost/$IP_MYSQL/" /var/www/html/config.php

# Eliminamos contenido que no sea útil
rm -rf /var/www/html/index.html
rm -rf /var/www/html/iaw-practica-lamp

#Cambiamos los permisos
chown www-data:www-data * -R

# Reiniciamos el nginx
systemctl restart nginx

# Cambiamos al directorio inicial
cd /home/ubuntu
