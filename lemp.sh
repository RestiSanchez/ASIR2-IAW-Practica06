#!/bin/bash


# Variables
# Definimos la ruta donde vamos a guardar el archivo .htpasswd
HTTPASSWD_DIR=/home/ubuntu
HTTPASSWD_USER=usuario
HTTPASSWD_PASSWD=usuario
# IP Servidor MySQL
IP_PRIVADA=172.31.27.177


#######################################
######   Instalación pila LEMP   ######
#######################################


# Habilitamos el modo de shell para mostrar los comandos que se ejecutan
set -x

# Actualizamos la lista de paquetes
apt-get update

# Instalamos el servidor web Apache -y le decimos que si
apt-get install nginx -y

# Instalamos los módulos necesarios de PHP
apt-get install php-fpm php-mysql -y

# Configuración de php-fpm
sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/7.4/fpm/php.ini

# Reiniciamos el servicio
systemctl restart php7.4-fpm

# Copiamos el archivo de configuración
cp default /etc/nginx/sites-available/

# Reiniciamos el servicio de nginx
systemctl restart nginx

###########################################
######   Instalación aplicación web  ######
###########################################


# Clonamos el repositorio de la aplicación
cd /var/www/html 
rm -rf iaw-practica-lamp 
git clone https://github.com/josejuansanchez/iaw-practica-lamp

# Movemos el contenido del repositorio al home de html
mv /var/www/html/iaw-practica-lamp/src/*  /var/www/html/

# Configuramos el archivo php de la aplicacion
sed -i "s/localhost/$IP_PRIVADA/" /var/www/html/config.php

# Eliminamos el archivo Index.html de nginx
rm -rf /var/www/html/index.html
rm -rf /var/www/html/iaw-practica-lamp/

# Instalamos unzip
apt install unzip -y

# Instalación de Phpmyadmin
cd /home/ubuntu
rm -rf phpMyAdmin-5.0.4-all-lenguages.zip
wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.zip

# Descomprimimos 
unzip phpMyAdmin-5.0.4-all-languages.zip

# Borramos el archivo .zip
rm -rf phpMyAdmin-5.0.4-all-languages.zip
rm -rf /var/www/html/phpmyadmin

# Movemos la carpeta al directorio
mv phpMyAdmin-5.0.4-all-languages /var/www/html/phpmyadmin

# Copiamos el config.inc.php al directorio
cp config.inc.php /var/www/html/phpmyadmin/

# Cambiamos permisos de /var/www/html
cd /var/www/html
chown www-data:www-data * -R
