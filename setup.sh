#!/bin/bash
clear

# warna hidup wkwkwk
red='\e[1;31m'
green='\e[0;32m'
yell='\e[1;33m'
C='\e[1;32m'
G='\e[1;32m'
N='\e[0m'
W='\e[1;37m'
purple() { echo -e "\\033[35;1m${*}\\033[0m"; }
tyblue() { echo -e "\\033[36;1m${*}\\033[0m"; }
yellow() { echo -e "\\033[33;1m${*}\\033[0m"; }
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }

# REPOSITORY
REPOKU="https://raw.githubusercontent.com/sengnawang/permission/main"
REPOSC="https://raw.githubusercontent.com/sengnawang/premium/main"
# TELEGRAMKU
CHATID="6447416716"
TOKENBOT="6951295400:AAF8_cbbAezmjkC55ygrXPEAoabr7OWgbL8"
# cek cek vps dulu kak
cd /root
if [ "${EUID}" -ne 0 ]; then
    echo "You need to run this script as root"
    exit 1
fi

if [ "$(systemd-detect-virt)" == "openvz" ]; then
    echo "OpenVZ is not supported"
    exit 1
fi

localip=$(hostname -I | cut -d\  -f1)
hst=( `hostname` )
dart=$(cat /etc/hosts | grep -w `hostname` | awk '{print $2}')
if [[ "$hst" != "$dart" ]]; then
    echo "$localip $(hostname)" >> /etc/hosts
fi

function STARTING() {
    echo
    echo -e "  Waktu instalasi :${C} $(( ${1} / 3600 )) ${N}jam${C} $(( (${1} / 60) % 60 )) ${N}menit${C} $(( ${1} % 60 )) ${N}detik"
}
rm -rf /etc/rmbl
mkdir -p /etc/rmbl
mkdir -p /etc/rmbl/theme
mkdir -p /var/lib/ >/dev/null 2>&1
echo "IP=" >> /var/lib/ipvps.conf
clear
echo
echo -e  "${C}┌──────────────────────────────────────────┐${N}"
echo -e  "${C}│${W}            MASUKKAN NAMA KAMU            ${C}│${N}"
echo -e  "${C}└──────────────────────────────────────────┘${N}"
echo " "
until [[ $name =~ ^[a-zA-Z0-9_.-]+$ ]]; do
    read -rp "Masukan Nama Kamu Disini tanpa spasi : " -e name
done
rm -rf /etc/profil
echo "$name" > /etc/profil
echo ""
clear
author=$(cat /etc/profil | awk '{print $1}')
echo ""
echo ""
function isi_github_info(){
matanah=$(wget -qO- https://pastebin.com/raw/ASigWhmd)
echo -e "$matanah" > /etc/github/api
echo -e "v@gmail.com" > /etc/github/email
echo -e "celakgede" > /etc/github/username
}

function isikey(){
    clear
    echo
    echo -e "${C}┌──────────────────────────────────────────┐${N}"
    echo -e "${C}│${W}       MENU PILIHAN AKTIVASI SCRIPT       ${C}│${N}"
    echo -e "${C}└──────────────────────────────────────────┘${N}"
    echo -e "${C}┌──────────────────────────────────────────┐${N}"
    echo -e "${C}│                                          │${N}"
    echo -e "${C}│${W}  [${C}01${W}] TRIAL 1 HARI                       ${C}│${N}"
    echo -e "${C}│                                          │${N}"
    echo -e "${C}│${W}  [${C}02${W}] MEMBER SUDAH BELI                  ${C}│${N}"
    echo -e "${C}│                                          │${N}"
    echo -e "${C}└──────────────────────────────────────────┘${N}"
    until [[ $key =~ ^[12]+$ ]]; do
        read -p "   Please select numbers 1 atau 2 : " key
    done
    if [[ $key == "1" ]]; then
        MYIP=$(curl -sS ipv4.icanhazip.com)
        rm -rf /etc/github
        mkdir -p /etc/github
        isi_github_info
        clear
        APIGIT=$(cat /etc/github/api)
        EMAILGIT=$(cat /etc/github/email)
        USERGIT=$(cat /etc/github/username)
        hhari=$(date -d "1 days" +"%Y-%m-%d")
        mkdir -p /root/rmbl
        cd /root/rmbl
        wget ${REPOKU}/permission/main/ipmini >/dev/null 2>&1
        echo "### $author $hhari $MYIP @trial" >> ipmini
        sleep 1
        rm -rf .git
        git config --global user.email "${EMAILGIT}" >/dev/null 2>&1
        git config --global user.name "${USERGIT}" >/dev/null 2>&1
        git init >/dev/null 2>&1
        git add ipmini
        git commit -m register >/dev/null 2>&1
        git branch -M main >/dev/null 2>&1
        git remote add origin https://github.com/${USERGIT}/permission >/dev/null 2>&1
        git push -f https://${APIGIT}@github.com/${USERGIT}/permission >/dev/null 2>&1
        sleep 1
        rm -rf /root/rmbl
        rm -rf /etc/github
        clear
    fi
    if [[ $key == "2" ]]; then
        clear
        echo
        echo -e  "${C}┌──────────────────────────────────────────┐${N}"
        echo -e  "${C}│${W}           MASUKKAN KEY LICENSE           ${C}│${N}"
        echo -e  "${C}└──────────────────────────────────────────┘${N}"
        echo " "
        read -rp " Masukan Key Kamu di sini (Ctrl + C Exit) : " -e kode

        if [ -z $kode ]; then
            echo -e " KODE SALAH SILAHKAN MASUKKAN ULANG KODENYA"
            key2
        fi
        LIST=$(curl -sS ${REPOKU}/license/main/key | grep $kode | awk '{print $2}')
        Key=$(curl -sS ${REPOKU}/license/main/key | grep $kode | awk '{print $3}')
        KEY2=$(curl -sS ${REPOKU}/license/main/key | grep $kode | awk '{print $4}')
        ADMIN=$(curl -sS ${REPOKU}/license/main/key | grep $kode | awk '{print $5}')
        TOTALIP=$(curl -sS ${REPOKU}/license/main/key | grep $kode | awk '{print $6}')
        cd
        if [[ $kode == "RMBL" ]]; then
            MYIP=$(curl -sS ipv4.icanhazip.com)
            rm -rf /etc/github
            mkdir -p /etc/github
            isi_github_info
            clear
            APIGIT=$(cat /etc/github/api)
            EMAILGIT=$(cat /etc/github/email)
            USERGIT=$(cat /etc/github/username)
            hhari=$(date -d "30 days" +"%Y-%m-%d")
            mkdir -p /root/rmbl
            cd /root/rmbl
            wget ${REPOKU}/permission/main/ipmini >/dev/null 2>&1

            echo "### $author $hhari $MYIP @rmbl" >> ipmini

            sleep 0.5
            rm -rf .git
            git config --global user.email "${EMAILGIT}" >/dev/null 2>&1
            git config --global user.name "${USERGIT}" >/dev/null 2>&1
            git init >/dev/null 2>&1
            git add ipmini
            git commit -m register >/dev/null 2>&1
            git branch -M main >/dev/null 2>&1
            git remote add origin https://github.com/${USERGIT}/permission >/dev/null 2>&1
            git push -f https://${APIGIT}@github.com/${USERGIT}/permission >/dev/null 2>&1
            sleep 0.5
            rm ipmini
        elif [[ $kode == "RMBLVIP" ]]; then
            MYIP2=$(curl -sS ipv4.icanhazip.com)
            rm -rf /etc/github
            mkdir -p /etc/github
            isi_github_info
            clear
            APIGIT=$(cat /etc/github/api)
            EMAILGIT=$(cat /etc/github/email)
            USERGIT=$(cat /etc/github/username)
            hhari2=$(date -d "999 days" +"%Y-%m-%d")
            mkdir -p /root/rmbl
            cd /root/rmbl
            wget ${REPOKU}/permission/main/ipmini >/dev/null 2>&1

            sed -i "/# VIP/a ### ${author} ${hhari2} ${MYIP2} ON 999 VIP" /root/rmbl/ipmini

            sleep 0.5
            rm -rf .git
            git config --global user.email "${EMAILGIT}" >/dev/null 2>&1
            git config --global user.name "${USERGIT}" >/dev/null 2>&1
            git init >/dev/null 2>&1
            git add ipmini
            git commit -m register >/dev/null 2>&1
            git branch -M main >/dev/null 2>&1
            git remote add origin https://github.com/${USERGIT}/permission >/dev/null 2>&1
            git push -f https://${APIGIT}@github.com/${USERGIT}/permission >/dev/null 2>&1
            sleep 0.5
            rm ipmini
        elif [[ $kode == "RMBLVVIP" ]]; then
            MYIP3=$(curl -sS ipv4.icanhazip.com)
            rm -rf /etc/github
            mkdir -p /etc/github
            isi_github_info
            clear
            APIGIT=$(cat /etc/github/api)
            EMAILGIT=$(cat /etc/github/email)
            USERGIT=$(cat /etc/github/username)
            hhari3=$(date -d "999 days" +"%Y-%m-%d")
            mkdir -p /root/rmbl
            cd /root/rmbl
            wget ${REPOKU}/permission/main/ipmini >/dev/null 2>&1

            sed -i "/# RESELLER/a ### ${author} ${hhari3} ${MYIP3} ON 999" /root/rmbl/ipmini

            sleep 0.5
            rm -rf .git
            git config --global user.email "${EMAILGIT}" >/dev/null 2>&1
            git config --global user.name "${USERGIT}" >/dev/null 2>&1
            git init >/dev/null 2>&1
            git add ipmini
            git commit -m register >/dev/null 2>&1
            git branch -M main >/dev/null 2>&1
            git remote add origin https://github.com/${USERGIT}/permission >/dev/null 2>&1
            git push -f https://${APIGIT}@github.com/${USERGIT}/permission >/dev/null 2>&1
            sleep 0.5
            rm ipmini
        elif [[ $kode == $Key ]]; then
            MYIP=$(curl -sS ipv4.icanhazip.com)
            rm -rf /etc/github
            mkdir -p /etc/github
            isi_github_info
            clear
            APIGIT=$(cat /etc/github/api)
            EMAILGIT=$(cat /etc/github/email)
            USERGIT=$(cat /etc/github/username)
            hhari=$(date -d "$KEY2 days" +"%Y-%m-%d")
            mkdir -p /root/rmbl
            cd /root/rmbl
            wget ${REPOKU}/permission/main/ipmini >/dev/null 2>&1
            if [ "$ADMIN" = "ON" ]; then
                sed -i "/# RESELLER/a ### ${author} ${hhari} ${MYIP} ${ADMIN} ${TOTALIP}" /root/rmbl/ipmini
            else
                echo "### $author $hhari $MYIP @$LIST" >> ipmini
            fi

            sleep 0.5
            rm -rf .git
            git config --global user.email "${EMAILGIT}" >/dev/null 2>&1
            git config --global user.name "${USERGIT}" >/dev/null 2>&1
            git init >/dev/null 2>&1
            git add ipmini
            git commit -m register >/dev/null 2>&1
            git branch -M main >/dev/null 2>&1
            git remote add origin https://github.com/${USERGIT}/permission >/dev/null 2>&1
            git push -f https://${APIGIT}@github.com/${USERGIT}/permission >/dev/null 2>&1
            sleep 0.5
            rm ipmini
            wget ${REPOKU}/license/main/key >/dev/null 2>&1
            if [ "$ADMIN" = "ON" ]; then
                sed -i "/^### $LIST $Key $KEY2 $ADMIN $TOTALIP/d" /root/rmbl/key
            else
                sed -i "/^### $LIST $Key $KEY2/d" /root/rmbl/key
            fi
            sleep 0.5
            rm -rf .git
            git config --global user.email "${EMAILGIT}" >/dev/null 2>&1
            git config --global user.name "${USERGIT}" >/dev/null 2>&1
            git init >/dev/null 2>&1
            git add key
            git commit -m register >/dev/null 2>&1
            git branch -M main >/dev/null 2>&1
            git remote add origin https://github.com/${USERGIT}/license >/dev/null 2>&1
            git push -f https://${APIGIT}@github.com/${USERGIT}/license >/dev/null 2>&1
            rm -rf /root/rmbl
            rm -rf /etc/github
            clear
        else
            echo -e " KODE SALAH SILAHKAN MASUKKAN ULANG KODENYA"
            sleep 1
            key2
        fi
    fi
}
function domain(){
fun_bar() {
    CMD[0]="$1"
    CMD[1]="$2"
    (
        [[ -e $HOME/fim ]] && rm $HOME/fim
        ${CMD[0]} -y >/dev/null 2>&1
        ${CMD[1]} -y >/dev/null 2>&1
        touch $HOME/fim
    ) >/dev/null 2>&1 &
    tput civis
    echo -ne " \033[1;33m Update Domain... \033[1;37m- \033[1;33m["
    while true; do
        for ((i = 0; i < 18; i++)); do
            echo -ne "\033[0;32m●"
            sleep 0.1s
        done
        [[ -e $HOME/fim ]] && rm $HOME/fim && break
        echo -e "\033[0;33m]"
        sleep 1s
        tput cuu1
        tput dl1
        echo -ne " \033[1;33m Update Domain... \033[1;37m- \033[1;33m["
    done
    echo -e "\033[1;33m]\033[1;37m -\033[1;32m Succes !\033[1;37m"
    tput cnorm
}
res1() {
    wget -q ${REPOSC}/install/pointing.sh && chmod +x pointing.sh && ./pointing.sh
    clear
}
cd
clear
echo
echo -e " ${C}┌──────────────────────────────────────────┐${N}"
echo -e " ${C}│${W}       MENU PILIHAN INPUT DOMAIN VPS      ${C}│${N}"
echo -e " ${C}└──────────────────────────────────────────┘${N}"
echo -e " ${C}┌──────────────────────────────────────────┐${N}"
echo -e " ${C}│${W} [${C}01${W}] Domain kamu sendiri                 ${C}│${N}"
echo -e " ${C}│                                          │${N}"
echo -e " ${C}│${W} [${C}02${W}] Domain Yang Punya Script            ${C}│${N}"
#echo -e " ${C}│                                          │${N}"
#echo -e " ${C}│${W} [${C}03${W}] Domain Host & SlowDNS Sendiri       ${C}│${N}"
echo -e " ${C}└──────────────────────────────────────────┘${N}"
until [[ $domain =~ ^[132]+$ ]]; do
    read -p " Masukkan pilihan kamu 1/2 : " domain
done
if [[ $domain == "1" ]]; then
    until [[ $dnss =~ ^[a-zA-Z0-9_.-]+$ ]]; do
        echo
        read -rp " Masukan domain kamu di sini : " -e dnss
    done
    rm -rf /etc/xray
    rm -rf /etc/v2ray
    rm -rf /etc/nsdomain
    rm -rf /etc/per
    mkdir -p /etc/xray
    mkdir -p /etc/v2ray
    mkdir -p /etc/nsdomain
    touch /etc/xray/domain
    touch /etc/v2ray/domain
    touch /etc/xray/slwdomain
    touch /etc/v2ray/scdomain
    echo "$dnss" > /root/domain
    echo "$dnss" > /root/scdomain
    echo "$dnss" > /etc/xray/scdomain
    echo "$dnss" > /etc/v2ray/scdomain
    echo "$dnss" > /etc/xray/domain
    echo "$dnss" > /etc/v2ray/domain
    echo "IP=$dnss" > /var/lib/ipvps.conf
    echo ""
    clear
fi
if [[ $domain == "2" ]]; then
    clear
    echo
    echo -e " ${C}┌──────────────────────────────────────────┐${N}"
    echo -e " ${C}│${W}     MENU PILIHAN DOMAIN BAWAAN SCRIPT    ${C}│${N}"
    echo -e " ${C}└──────────────────────────────────────────┘${N}"
    echo -e " ${C}┌──────────────────────────────────────────┐${N}"
    echo -e " ${C}│${W} [${C}01${W}] Domain xxx.rmbltunel.cloud           ${C}│${N}"
    echo -e " ${C}└──────────────────────────────────────────┘${N}"
    until [[ $domain2 =~ ^[1-5]+$ ]]; do
        read -p " Masukkan pilihan angka 1 : " domain2
    done
fi
if [[ $domain2 == "1" ]]; then
    until [[ $dn1 =~ ^[a-zA-Z0-9_.-]+$ ]]; do
        echo
        read -rp " Masukan subdomain kamu di sini tanpa spasi: " -e dn1
    done
    rm -rf /etc/xray
    rm -rf /etc/v2ray
    rm -rf /etc/nsdomain
    rm -rf /etc/per
    mkdir -p /etc/xray
    mkdir -p /etc/v2ray
    mkdir -p /etc/nsdomain
    mkdir -p /etc/per
    touch /etc/per/id
    touch /etc/per/token
    touch /etc/xray/domain
    touch /etc/v2ray/domain
    touch /etc/xray/slwdomain
    touch /etc/v2ray/scdomain
    echo "$dn1" > /root/subdomainx
    cd
    sleep 1
    clear
    echo
    echo -e " ${C}┌──────────────────────────────────────────┐${N}"
    echo -e " ${C}│${W}   PROSES POINTING DOMAIN KE CLOUDFLARE   ${C}│"
    echo -e " ${C}└──────────────────────────────────────────┘${N}"
    res1
    clear
    rm /root/subdomainx
fi

if [[ $domain == "3" ]]; then
    until [[ $dns1 =~ ^[a-zA-Z0-9_.-]+$ ]]; do
        read -rp " Masukan domain kamu di sini : " -e dns1
    done
    echo ""
    echo "$dns1" > /etc/xray/domain
    echo "$dns1" > /etc/v2ray/domain
    echo "IP=$dns1" > /var/lib/ipvps.conf
    until [[ $dns2 =~ ^[a-zA-Z0-9_.-]+$ ]]; do
        read -rp " Masukan Domain SlowDNS kamu di sini : " -e dns2
    done
    echo $dns2 >/etc/xray/dns
fi
}
cat <<EOF>> /etc/rmbl/theme/green
BG : \e[37;1;42m
TEXT : \033[0;32m
EOF
cat <<EOF>> /etc/rmbl/theme/yellow
BG : \e[37;1;43m
TEXT : \033[0;33m
EOF
cat <<EOF>> /etc/rmbl/theme/red
BG : \e[37;1;41m
TEXT : \033[0;31m
EOF
cat <<EOF>> /etc/rmbl/theme/blue
BG : \e[37;1;44m
TEXT : \033[0;34m
EOF
cat <<EOF>> /etc/rmbl/theme/magenta
BG : \e[37;1;45m
TEXT : \033[0;35m
EOF
cat <<EOF>> /etc/rmbl/theme/cyan
BG : \e[37;1;46m
TEXT : \033[0;36m
EOF
cat <<EOF>> /etc/rmbl/theme/lightgray
BG : \e[37;1;47m
TEXT : \033[0;37m
EOF
cat <<EOF>> /etc/rmbl/theme/darkgray
BG : \e[37;1;100m
TEXT : \033[0;90m
EOF
cat <<EOF>> /etc/rmbl/theme/lightred
BG : \e[37;1;101m
TEXT : \033[0;91m
EOF
cat <<EOF>> /etc/rmbl/theme/lightgreen
BG : \e[37;1;102m
TEXT : \033[0;92m
EOF
cat <<EOF>> /etc/rmbl/theme/lightyellow
BG : \e[37;1;103m
TEXT : \033[0;93m
EOF
cat <<EOF>> /etc/rmbl/theme/lightblue
BG : \e[37;1;104m
TEXT : \033[0;94m
EOF
cat <<EOF>> /etc/rmbl/theme/lightmagenta
BG : \e[37;1;105m
TEXT : \033[0;95m
EOF
cat <<EOF>> /etc/rmbl/theme/lightcyan
BG : \e[37;1;106m
TEXT : \033[0;96m
EOF
cat <<EOF>> /etc/rmbl/theme/color.conf
lightgreen
EOF
function RMBL(){
    cd
    sysctl -w net.ipv6.conf.all.disable_ipv6=1 >/dev/null 2>&1
    sysctl -w net.ipv6.conf.default.disable_ipv6=1 >/dev/null 2>&1
    clear
    wget -q ${REPOSC}/tools.sh &> /dev/null
    chmod +x tools.sh
    ./tools.sh
    clear
    start=$(date +%s)
    ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
    apt install git curl -y >/dev/null 2>&1
    apt install python -y >/dev/null 2>&1
}

function CEKIP () {
    MYIP=$(curl -sS ipv4.icanhazip.com)
    IPVPS=$(curl -sS $REPOKU/permission/main/ipmini | grep $MYIP | awk '{print $4}')
    if [[ $MYIP == $IPVPS ]]; then
        domain
        RMBL
    else
        isikey
        domain
        RMBL
    fi
}

function RMBLANIMASI(){
    fun_bar() {
        CMD[0]="$1"
        CMD[1]="$2"
        (
            [[ -e $HOME/fim ]] && rm $HOME/fim
            ${CMD[0]} -y >/dev/null 2>&1
            ${CMD[1]} -y >/dev/null 2>&1
            touch $HOME/fim
        ) >/dev/null 2>&1 &
        tput civis
        echo -ne " \033[1;33m Sedang Menginstal File \033[1;37m- \033[1;33m["
        while true; do
            for ((i = 0; i < 16; i++)); do
                echo -ne "\033[0;32m●"
                sleep 0.1s
            done
            [[ -e $HOME/fim ]] && rm $HOME/fim && break
            echo -e "\033[0;33m]"
            sleep 1s
            tput cuu1
            tput dl1
            echo -ne " \033[1;33m Sedang Menginstal File \033[1;37m- \033[1;33m["
        done
        echo -e "\033[1;33m]\033[1;37m -\033[1;32m OK !\033[1;37m"
        tput cnorm
    }


    res2() {
        wget -q ${REPOSC}/install/ssh-vpn.sh && chmod +x ssh-vpn.sh && ./ssh-vpn.sh
        clear
    }

    res3() {
        wget -q ${REPOSC}/install/ins-xray.sh && chmod +x ins-xray.sh && ./ins-xray.sh
        clear
    }

    res4() {
        wget -q ${REPOSC}/sshws/insshws.sh && chmod +x insshws.sh && ./insshws.sh
        clear
    }

    res5() {
        wget -q ${REPOSC}/install/set-br.sh && chmod +x set-br.sh && ./set-br.sh
        clear
    }

    res6() {
        wget -q ${REPOSC}/sshws/ohp.sh && chmod +x ohp.sh && ./ohp.sh
        clear
    }

    res7() {
        wget -q ${REPOSC}/menu/ekstra.sh && chmod +x ekstra.sh && ./ekstra.sh
        clear
    }

    res8() {
#        wget -q ${REPOSC}/slowdns/installsl.sh && chmod +x installsl.sh && ./installsl.sh
        echo " tidak dipaai"
        clear
    }

    res9() {
        wget -q ${REPOSC}/install/udp-custom.sh && chmod +x udp-custom.sh && ./udp-custom.sh
        clear
    }

    echo -e " ${C}┌──────────────────────────────────────────┐${N}"
    echo -e " ${C}│${W}       PROSES INSTALASI SSH & OVPN        ${C}│${N}"
    echo -e " ${C}└──────────────────────────────────────────┘${N}"
    fun_bar 'res2'
    echo -e " ${C}┌──────────────────────────────────────────┐${N}"
    echo -e " ${C}│${W}          PROSES INSTALASI XRAY           ${C}│${N}"
    echo -e " ${C}└──────────────────────────────────────────┘${N}"
    fun_bar 'res3'
    echo -e " ${C}┌──────────────────────────────────────────┐${N}"
    echo -e " ${C}│${W}      PROSES INSTALASI SSH WEBSOCKET      ${C}│${N}"
    echo -e " ${C}└──────────────────────────────────────────┘${N}"
    fun_bar 'res4'
    echo -e " ${C}┌──────────────────────────────────────────┐${N}"
    echo -e " ${C}│${W}       PROSES INSTALASI MENU BACKUP       ${C}│${N}"
    echo -e " ${C}└──────────────────────────────────────────┘${N}"
    fun_bar 'res5'
    echo -e " ${C}┌──────────────────────────────────────────┐${N}"
    echo -e " ${C}│${W}           PROSES INSTALASI OHP           ${C}│${N}"
    echo -e " ${C}└──────────────────────────────────────────┘${N}"
    fun_bar 'res6'
    echo -e " ${C}┌──────────────────────────────────────────┐${N}"
    echo -e " ${C}│${W}       PROSES INSTALASI MENU EKSTRA       ${C}│${N}"
    echo -e " ${C}└──────────────────────────────────────────┘${N}"
    fun_bar 'res7'
    echo -e " ${C}┌──────────────────────────────────────────┐${N}"
    echo -e " ${C}│${W}       PROSES INSTALASI UDP CUSTOM        ${C}│${N}"
    echo -e " ${C}└──────────────────────────────────────────┘${N}"
    fun_bar 'res9'
    echo -e " ${C}┌──────────────────────────────────────────┐${N}"
    echo -e " ${C}│${W}          WAKTU INSTALASI SCRIPT          ${C}│${N}"
    echo -e " ${C}└──────────────────────────────────────────┘${N}"
    STARTING "$(($(date +%s) - ${start}))" | tee -a log-install.txt
}

function convert() {
    local -i megabytes=$1
    if [[ $megabytes -lt 1024 ]]; then
        echo "${megabytes} MB"
    else
        echo "$(awk "BEGIN {printf \"%.1f\", $megabytes/1024}" | sed 's/\.0$//') GB"
    fi
}

function TERAKHIR(){
    TIMES="10"
    CHATID="$CHATID"
    KEY="$TOKENBOT"
    URL="https://api.telegram.org/bot$KEY/sendMessage"
    ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10)
    CITY=$(curl -s ipinfo.io/city)
    domain=$(cat /etc/xray/domain)
    TIME=$(date +'%d-%m-%Y | %H:%M %Z')
    RAM=$(free -m | awk 'NR==2 {print $2}'); RAM=$(convert $RAM)
    MODEL2=$(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')
    MYIP=$(curl -sS ipv4.icanhazip.com)
    IZIN=$(curl -sS ${REPOKU}/permission/main/ipmini | grep $MYIP | awk '{print $3}' )
    d1=$(date -d "$IZIN" +%s)
    d2=$(date -d "$today" +%s)
    EXP=$(( (d1 - d2) / 86400 ))

    TEXT="
╔━━━━━━━━━━━━━━━━━━━╗
<code> ⚠️AUTOSCRIPT PREMIUM </code>
╚━━━━━━━━━━━━━━━━━━━╝
╔─━━━━━━━ ◙ ━━━━━━━─╗
<code>├NAME       :</code> <code>${author}</code>
<code>├TIME       :</code> <code>${TIME} WIB</code>
<code>├DOMAIN     :</code> <code>${domain}</code>
<code>├IP         :</code> <code>${MYIP}</code>
<code>├ISP        :</code> <code>${ISP}</code>
<code>├CITY       :</code> <code>$CITY</code>
<code>├OS LINUX   :</code> <code>${MODEL2}</code>
<code>├RAM        :</code> <code>${RAMMS} MB</code>
<code>├EXP SCRIPT :</code> <code>$EXP Days</code>
╚─━━━━━━━ ◙ ━━━━━━━─╝
╔─━━━━━━━ ◙ ━━━━━━━─╗
  <i>Notification Installer Script...</i>
╚─━━━━━━━ ◙ ━━━━━━━─╝
"'&reply_markup={"inline_keyboard":[[{"text":"🔥 ORDER","url":"https://t.me/rmblvpn1"},{"text":"GROUP 🔥","url":"https://t.me/configopok"}]]}'
    curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null
}

function FINISHING() {
    cat> /root/.profile << END
if [ "$BASH" ]; then
    if [ -f ~/.bashrc ]; then
        . ~/.bashrc
    fi
fi
mesg n || true
clear
menu
END
    chmod 644 /root/.profile
    if [ -f "/root/log-install.txt" ]; then
        rm /root/log-install.txt > /dev/null 2>&1
    fi
    if [ -f "/etc/afak.conf" ]; then
        rm /etc/afak.conf > /dev/null 2>&1
    fi
    if [ ! -f "/etc/log-create-user.log" ]; then
        echo "Log All Account " > /etc/log-create-user.log
    fi
    history -c
    serverV=$( curl -sS ${REPOSC}/versi  )
    echo $serverV > /opt/.ver
    aureb=$(cat /home/re_otm)
    b=11
    if [ $aureb -gt $b ]; then
        gg="PM"
    else
        gg="AM"
    fi
    cd
    curl -sS ipv4.icanhazip.com > /etc/myipvps
    curl -s ipinfo.io/city?token=75082b4831f909 >> /etc/xray/city
    curl -s ipinfo.io/org?token=75082b4831f909  | cut -d " " -f 2-10 >> /etc/xray/isp
    rm /root/setup.sh >/dev/null 2>&1
    rm /root/slhost.sh >/dev/null 2>&1
    rm /root/ssh-vpn.sh >/dev/null 2>&1
    rm /root/ins-xray.sh >/dev/null 2>&1
    rm /root/insshws.sh >/dev/null 2>&1
    rm /root/set-br.sh >/dev/null 2>&1
    rm /root/ohp.sh >/dev/null 2>&1
    rm /root/ekstra.sh >/dev/null 2>&1
    rm /root/slowdns.sh >/dev/null 2>&1
}

CEKIP
RMBLANIMASI
TERAKHIR
FINISHING
sleep 3
echo
cd
rm -rf *
echo -e " ${C}┌──────────────────────────────────────────┐${N}"
echo -e " ${C}│${W}      VPS AKAN REBOOT DALAM 9 DETIK       ${C}│${N}"
echo -e " ${C}└──────────────────────────────────────────┘${N}"
tput civis
for i in {9..1}
do
    echo -ne "\r  Reboot ${G}$i${N} detik lagi.."
    sleep 1
done
echo -ne "\r  Reboot ${G}sekarang..!!    \n"
tput cnorm
reboot
