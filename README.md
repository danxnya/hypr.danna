# hypr.danna
[![image.png](https://i.postimg.cc/s2zMMbt1/image.png)](https://postimg.cc/3kL86frH)
## Information

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
cd Downloads/ && unzip fonts.zip
```
*if you don't have other files on downloads, in another case, switch the directory direction.*
```sh
sudo cp -r ~/Downloads/* /usr/share/fonts/*
```
Install your favorite desktop manager, I use `emptty`.
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
