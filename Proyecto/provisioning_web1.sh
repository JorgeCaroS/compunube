#!/bin/bash

echo "************ INICIO ARCHIVO DE PROVISIONAMIENTO WEB1 ************"

sudo usermod -a -G lxd $(whoami)

echo " ---------- Nuevo grupo LXD ---------- "
sudo newgrp lxd

echo " ---------- Tiempo de espera... ---------- "
sudo sleep 20

echo " ---------- Iniciar LXD ---------- "
sudo lxd init --auto

echo " ---------- Tiempo de espera... ---------- "
sudo sleep 20

echo " ---------- Instalar contenedor WEB1  ---------- "
sudo lxc launch ubuntu:18.04 web1

echo " ---------- Tiempo de espera... ---------- "
sudo sleep 20

echo " ---------- Actualizar contenedor WEB1 ---------- "
lxc exec web1 -- sudo apt -y update
lxc exec web1 -- sudo apt -y upgrade

echo " ---------- Tiempo de espera... ---------- "
sudo sleep 20

echo " ---------- Instalar APACHE ---------- "
lxc exec web1 -- sudo apt -y install apache2

echo " ---------- Tiempo de espera... ---------- "
sudo sleep 20

echo "---------------Instalando apache---------"
lxc exec web1 -- sudo apt-get install apache2
sudo sleep 20

echo " ---------- Iniciar APACHE ---------- "
lxc exec web1 -- sudo systemctl enable apache2

echo " ---------- Tiempo de espera... ---------- "
sudo sleep 20

echo " ---------- Configurar index.html ---------- "
lxc file push /vagrant/shared_folder/index_web1.html web1/var/www/html/index.html

echo " ---------- Tiempo de espera... ---------- "
sudo sleep 20

echo " ---------- Reiniciar APACHE ---------- "
lxc exec web1 -- sudo systemctl restart apache2

echo " ---------- Tiempo de espera... ---------- "
sudo sleep 20

echo " ---------- Forwarding de puertos ---------- "
sudo lxc config device add web1 http proxy listen=tcp:0.0.0.0:80 connect=tcp:127.0.0.1:80

echo "************ FIN ARCHIVO DE PROVISIONAMIENTO WEB1 ************"
