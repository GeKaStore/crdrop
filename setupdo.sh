#!/bin/bash

#update dan upgrade repository serta install python3 dan pip
sudo apt update -y && sudo apt upgrade -y && sudo apt install python3 -y && sudo apt install python3-pip -y

#bot telegram untuk regis ip
echo -e "MEMBUAT BOT TELEGRAM UNTUK REGIS IP"
read -p "Masukkan Token Telegram: " token_tele_git
read -p "Masukkan Token Github: " token_git
clear

echo "============================"
echo "       MENYIMPAN DATA       "
echo "============================"
sleep 2
clear

#bot telegram untuk create droplet
echo -e "MEMBUAT BOT TELEGRAM UNTUK CREATE DROPLET"
echo -p "Masukkan Token Telegram: " token_tele_do
echo -p "Masukkan Token DO: " token_do
clear

echo "============================"
echo "       MENYIMPAN DATA       "
echo "============================"
sleep 2
clear

sudo timedatectl set-timezone Asia/Jakarta

#mengunduh script
mkdir -p vpn/bot
cd vpn/bot
wget https://raw.githubusercontent.com/GeKaStore/crdrop/main/regis.py
wget https://raw.githubusercontent.com/GeKaStore/crdrop/main/Do.py

#setup regis ip
TOKEN_GITHUB="$token_git"
TOKEN_TELE_GIT="$token_tele_git"
sed -i "s/{TOKEN_GITHUB}/$TOKEN_GITHUB/g" regis.py
sed -i "s/{TOKEN_TELE_GIT}/$TOKEN_TELE_GIT/g" regis.py

#setup create do
TOKEN_DO="$token_do"
TOKEN_TELE_DO="$token_tele_do"
sed -i "s/{TOKEN_DO}/$TOKEN_DO/g" Do.py
sed -i "s/{TOKEN_TELE_DO}/$TOKEN_TELE_DO/g" Do.py

#running di system
cd
cd /etc/systemd/system
wget https://raw.githubusercontent.com/GeKaStore/crdrop/main/Do.service
sudo systemctl daemon-reload
sudo systemctl start Do
sudo systemctl enable Do
sudo systemctl restart Do

wget https://raw.githubusercontent.com/GeKaStore/crdrop/main/regis.service
sudo systemctl daemon-reload
sudo systemctl start regis
sudo systemctl enable regis
sudo systemctl restart regis

echo "============================"
echo "  PROSES INSTALASI SELESAI  "
echo "============================"

cd
rm setup.sh