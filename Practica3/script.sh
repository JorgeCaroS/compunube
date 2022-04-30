#!/bin/bash
echo "configurando el resolv.conf con cat"
cat <<TEST> /etc/resolv.conf
nameserver 8.8.8.8
TEST
echo "instalando un servidor vsftpd"
sudo apt-get install vsftpd -y
echo “Modificando vsftpd.conf con sed”
sed -i 's/#write_enable=YES/write_enable=YES/g' /etc/vsftpd.conf
echo "configurando ip forwarding con echo"
sudo echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
echo "Instalando Python"
sudo apt install python3-pip -y

echo "Instalando Markupsafe"
sudo apt-get install -y python-markupsafe
echo "Instalando Jupyter"
pip3 install jupyter
export PATH="$HOME/.local/bin:$PATH"

