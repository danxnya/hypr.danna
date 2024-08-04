#!/bin/bash

# YAY PACKAGES

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

# VARIABLE TO STORE INSTALLATION LOGS

INSTLOG="install.log"

# PRESENTATION

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

# PROGRESS BAR SHOWN TO THE USER

function show_progress() {
    while ps | grep $1 &> /dev/null;
    do
        echo -n "."
        sleep 2
    done
    echo -en "\e[32mOK\e[0m"
    sleep 2
}

# FUNCTION TO INSTALL PACKAGES AND DEPENDENCIES

function install_software() {
    echo -en $1
    yay -S --noconfirm $1 &>> $INSTLOG &
    show_progress $!

    # check if installed correctly
    if yay -Q $1 &>> /dev/null ; then
        echo -e ""
    else
        # if not installed correctly, print an error message
        echo -e "$1 was not installed correctly, please check >< install.log"
        exit 0
    fi
}

# SYSTEM UPDATE

function update() {
    echo -en "Updating."
    sudo pacman -Syu --noconfirm &>> $INSTLOG &
    show_progress $!
    echo -en "\n"
}

# YAY PACKAGE MANAGER INSTALLATION

function packagemanager() {
    if [ ! -f /sbin/yay ]; then  
        echo -en "Installing yay."
        git clone https://aur.archlinux.org/yay-git &>> $INSTLOG
        cd yay-git
        makepkg -si --noconfirm &>> ../$INSTLOG &
        show_progress $!
        if [ -f /sbin/yay ]; then
            :
        else
            echo -e "Yay installation failed, please read the file >< install.log"
            exit 0
        fi
    fi
}

# SETUP

function setup() {
    echo -e "\n"
    echo -en "\e[33m[x] Installing Yay packages...\e[0m\n"
    for SOFTWR in ${install_packages_yay[@]}; do
        if [ "$SOFTWR" == 'rustup' ]; then
            sudo pacman -R --noconfirm rust > /dev/null 2>&1
            install_software $SOFTWR
        else
            install_software $SOFTWR 
        fi
    done
}

# COPY DOTFILES

function copia() {
    echo -en "\n"
    echo -en "\e[33m[x] Copying configuration...\e[0m\n"
    echo -en "dotfiles."

    mkdir -p "$HOME/.config" > /dev/null 2>&1

    mkdir -p "$HOME/.config/hypr" > /dev/null 2>&1
    cp -r $1/dotfiles/hypr/* "$HOME/.config/hypr/"

    mkdir -p "$HOME/.config/rofi" > /dev/null 2>&1
    cp -r $1/dotfiles/rofi/* "$HOME/.config/rofi/"

    mkdir -p "$HOME/.config/kitty" > /dev/null 2>&1
    cp -r $1/dotfiles/kitty/* "$HOME/.config/kitty/"

    mkdir -p "$HOME/.config/BetterDiscord" > /dev/null 2>&1
    cp -r $1/dotfiles/BetterDiscord/* "$HOME/.config/BetterDiscord/"

    mkdir -p "$HOME/.config/waybar" > /dev/null 2>&1
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
    sudo mkdir -p zsh-sudo
    sudo chown $USER:$USER zsh-sudo/
    cd zsh-sudo
    wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/sudo/sudo.plugin.zsh > /dev/null 2>&1

    mkdir -p "$HOME/.config/scripts" > /dev/null 2>&1
    cp -r $1/dotfiles/scripts/* "$HOME/.config/scripts"
    chmod +x -R $HOME/.config/scripts/

    mkdir -p "$HOME/.config/swappy" > /dev/null 2>&1
    cp -r $1/dotfiles/swappy/* "$HOME/.config/swappy"

    echo -en "\e[32mOK\e[0m"
    echo -en "\n"
}

# FINALIZATION

function finalizacion() {
    echo ""
    echo "YA ME VINE. uwu"
    echo ""
}

# CALL ALL FUNCTIONS PROGRESSIVELY

function call() {
    ruta=$(pwd)
    update
    packagemanager
    setup "$ruta"
    copia "$ruta"
    finalizacion
}

# CHECK IF THE INSTALLER IS RUNNING AS ROOT

if [ $(whoami) != 'root' ]; then
    present
    # confirmation to proceed with installation
    echo -en '\n'
    read -rep 'Shall we proceed with the installation? (y,n)? ' CONTINST
    if [[ $CONTINST == "Y" || $CONTINST == "y" ]]; then
        echo -en "\n"
        echo -en "\e[33m[x] Starting >.<...\e[0m\n"
        sudo touch /tmp/hyprv.tmp
        call
    else
        echo -e "Exiting the script, no changes have been made to your system."
        exit 0
    fi
else
    echo 'Error, the script should not be run as root.'
    exit 0
fi
