#!/bin/bash

# PAQUETES YAY

install_packages_yay=(
    kitty
    hyprland 
    waybar 
    swappy 
    grim 
    slurp 
    nemo 
    pamixer 
    pavucontrol 
    brightnessctl  
    zsh 
    lsd 
    bat 
    zsh-syntax-highlighting 
    zsh-autosuggestions 
    uwufetch
    neovim
    wget 
    unzip
    gtk3
    w3m
    imagemagick
    rustup
    firefox
    wf-recorder
    rofi
)

# VARIABLE PARA GUARDAR LOS LOGS DE CADA INSTALACIÓN

INSTLOG="install.log"

# PRESENTACIÓN

function present() {
    array=(
        "\n"
        "\040b"
        "y\040"
        "d"
        "a"
        "n"
        "n"
        "a"
        "l"
        "^"
        "^\n"
    )

    for letter in ${array[@]}; do
    echo -en "\e[95m$letter\e[0m"
    sleep 0.2
    done
}


# PROGRESO DE BARRA MOSTRADO AL USUARIO

function show_progress() {
    while ps | grep $1 &> /dev/null;
    do
        echo -n "."
        sleep 2
    done
    echo -en "\e[32mOK\e[0m"
    sleep 2
}

# FUNCION ENCARGADA DE INSTALAR LOS PAQUETES Y DEPENDENCIAS

function install_software() {
    echo -en $1
    yay -S --noconfirm $1 &>> $INSTLOG &
    show_progress $!

    # comprobamos si se ha instalado correctamente
    if yay -Q $1 &>> /dev/null ; then
        echo -e ""
    else
        # si no se ha instalado correctamente se imprimirá un mensaje de error
        echo -e "$1 no ha sido instalado correctamente, por favor comprueba >< install.log"
        exit 0
    fi
}

# ACTUALIZAR SISTEMA

function update() {
    echo -en "Actualizando."
    sudo pacman -Syu --noconfirm &>> $INSTLOG &
    show_progress $!
    echo -en "\n"
}

# INSTALACIÓN PACKAGE MANAGER YAY

function packagemanager() {
    if [ ! -f /sbin/yay ]; then  
        echo -en "Instalando yay."
        git clone https://aur.archlinux.org/yay-git &>> $INSTLOG
        cd yay-git
        makepkg -si --noconfirm &>> ../$INSTLOG &
        show_progress $!
        if [ -f /sbin/yay ]; then
            :
        else
            echo -e "La instalación de yay ha fallado, por favor lee el archivo >< install.log"
            exit 0
        fi
    fi
}

# SETUP

function setup() {
    echo -e "\n"
    echo -en "\e[33m[x] Instalando paquetes Yay...\e[0m\n"
    for SOFTWR in ${install_packages_yay[@]}; do
        if [ "$SOFTWR" == 'rustup' ]; then
            sudo pacman -R --noconfirm rust > /dev/null 2>&1
            install_software $SOFTWR
        else
            install_software $SOFTWR 
        fi
    done
}

# SE COPIAN LOS DOTFILES

function copia() {
    echo -en "\n"
    echo -en "\e[33m[x] Copiando configuración...\e[0m\n"
    echo -en "dotfiles."

    mkdir "$HOME/.config" > /dev/null 2>&1

    mkdir "$HOME/.config/hypr" > /dev/null 2>&1
    cp -r $1/dotfiles/hypr/* "$HOME/.config/hypr/"

    mkdir "$HOME/.config/rofi" > /dev/null 2>&1
    cp -r $1/dotfiles/rofi/* "$HOME/.config/rofi/"

    mkdir "$HOME/.config/kitty" > /dev/null 2>&1
    cp -r $1/dotfiles/kitty/* "$HOME/.config/kitty/"

    mkdir "$HOME/.config/BetterDiscord" > /dev/null 2>&1
    cp -r $1/dotfiles/BetterDiscord/* "$HOME/.config/BetterDiscord/"


    mkdir "$HOME/.config/waybar" > /dev/null 2>&1
    cp -r $1/dotfiles/waybar/* "$HOME/.config/waybar/"
    chmod +x "$HOME/.config/waybar/scripts/mediaplayer.py" "$HOME/.config/waybar/scripts/wlrecord.sh"
    chmod +x "$HOME/.config/waybar/scripts/playerctl/playerctl.sh"
    chmod +x "$HOME/.config/waybar/scripts/screen.sh"
    chmod +x "$HOME/.config/waybar/scripts/spotify.sh"
    chmod +x "$HOME/.config/waybar/scripts/rofi-wifi-menu.sh"
    chmod +x "$HOME/.config/waybar/scripts/rofi-bluetooth.sh"

    sudo usermod --shell /usr/bin/zsh $USER > /dev/null 2>&1
    sudo usermod --shell /usr/bin/zsh root > /dev/null 2>&1
    cp -r "$1/dotfiles/.zshrc" "$HOME/"
    sudo ln -s -f "$HOME/.zshrc" "/root/.zshrc"

    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k > /dev/null 2>&1
    sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /root/powerlevel10k > /dev/null 2>&1
    cp -r $1/dotfiles/powerlevel10k/user/.p10k.zsh "$HOME/"
    sudo cp -r $1/dotfiles/powerlevel10k/root/.p10k.zsh "/root/"

    cd /usr/share
    sudo mkdir zsh-sudo
    sudo chown $USER:$USER zsh-sudo/
    cd zsh-sudo
    wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/sudo/sudo.plugin.zsh > /dev/null 2>&1


    mkdir "$HOME/.config/scripts" > /dev/null 2>&1
    cp -r $1/dotfiles/scripts/* "$HOME/.config/scripts"
    chmod +x -R $HOME/.config/scripts/

    mkdir "$HOME/.config/swappy" > /dev/null 2>&1
    cp -r $1/dotfiles/swappy/* "$HOME/.config/swappy"

    echo -en "\e[32mOK\e[0m"
    echo -en "\n"
}

# FINALIZACION

function finalizacion() {
    echo ""
    echo "YA ME VINE. uwu"
    echo ""
}

# SE LLAMA A TODAS LAS FUNCIONES PROGRESIVAMENTE

function call() {
    ruta=$(pwd)
    update
    packagemanager
    setup "$ruta"
    copia "$ruta"
    finalizacion
}

# SE COMPRUEBA SI EL INSTALADOR SE EJECUTA COMO ROOT

if [ $(whoami) != 'root' ]; then
    present
    # confirmación de proceder a instalar
    echo -en '\n'
    read -rep 'Camara culero!! Me instalo o huevos.(y,n)? ' CONTINST
    if [[ $CONTINST == "Y" || $CONTINST == "y" ]]; then
        echo -en "\n"
        echo -en "\e[33m[x] Iniciando >.<...\e[0m\n"
        sudo touch /tmp/hyprv.tmp
        call
    else
        echo -e "Saliendo del script, no se han realizado cambios en tu sistema."
        exit 0
    fi
else
    echo 'Error, el script no debe ser ejecutado como root.'
    exit 0
fi
