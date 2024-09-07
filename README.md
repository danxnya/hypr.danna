# hypr.danna

https://cdn.discordapp.com/attachments/635625917623828520/1279609842687938570/image.png?ex=66dcfa08&is=66dba888&hm=7b6a2e09af94bfba325868113846232f32478357d42c782285b977e0e540a0e0&

## Información

### Welcome! These are my dotfiles <33
This is from the Danna repository. I am going to give you instructions and the necessary dependencies for my theme. ^^

### ‼️ Important !!
- Not works in Nvdia (well, i don't try it xd).
- The fonts will be installed in another steps.
- Change the name of your monitor un the hyprland configs.

### 🍧 Information

-  **OS** Arch Linux
-  **SH** zsh 5.9
-  **TM** kitty 0.35.2
-  **WM** Hyprland (Wayland)

## Steps for install

### Install necessary fonts and reboot.
[Fonts here](https://mega.nz/file/GxFVSLLY#etuNc6QRrEl6wgl_ZatvomojDhkBTFPqlKS7ELk7KAM)
```sh
cd Downloads/
unzip file.zip
sudo cp -r ~/Downloads/* /usr/share/fonts/*
```
Install your favorite desktop manager, I use emptty.
```sh
sudo pacman -S emptty
systemctl enable emptty.service
```

🔧 Script
```sh
git clone https://github.com/danxnya/hypr.danna.git && cd hypr.danna/
chmod +x setup.sh
./setup.sh
```
Now, only wait and ENJOY. ><


👤 Author
danxnya
