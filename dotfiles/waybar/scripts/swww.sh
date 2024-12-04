#!/bin/bash

# Directorio donde se encuentran las imágenes
DIRECTORIO_IMAGENES="/home/dam/.config/hypr/wallpapers"

# Archivo para almacenar el índice de la última imagen seleccionada
ARCHIVO_INDICE="/home/dam/.config/waybar/scripts/indice_imagen.txt"

# Obtiene la lista de archivos de imagen (png o gif) en el directorio
ARCHIVOS_IMAGENES=($(find "$DIRECTORIO_IMAGENES" -type f \( -name "*.png" -o -name "*.gif" \) | sort))

# Número total de imágenes
NUM_IMAGENES=${#ARCHIVOS_IMAGENES[@]}

# Lee el índice de la última imagen seleccionada
if [ -f "$ARCHIVO_INDICE" ]; then
    INDICE=$(cat "$ARCHIVO_INDICE")
else
    INDICE=0
fi

# Selecciona la siguiente imagen en el orden
IMAGEN_SELECCIONADA=${ARCHIVOS_IMAGENES[$INDICE]}

# Incrementa el índice y vuelve al inicio si es necesario
INDICE=$(( (INDICE + 1) % NUM_IMAGENES ))

# Guarda el nuevo índice en el archivo
echo "$INDICE" > "$ARCHIVO_INDICE"

# Ejecuta el comando con la imagen seleccionada
swww img --transition-type outer --transition-pos 0.854,0.977 --transition-step 90 --transition-fps 60 "$IMAGEN_SELECCIONADA"
