#!/bin/bash

# Directorio donde se encuentran las imágenes
DIRECTORIO_IMAGENES="/home/dam/.config/hypr/wallpapers"

# Selecciona aleatoriamente un archivo de imagen en el directorio
IMAGEN_SELECCIONADA=$(ls "$DIRECTORIO_IMAGENES"/*.png | shuf -n 1)

# Ejecuta el comando con la imagen seleccionada
swww img --transition-type outer --transition-pos 0.854,0.977 --transition-step 90 --transition-fps 60 "$IMAGEN_SELECCIONADA"
