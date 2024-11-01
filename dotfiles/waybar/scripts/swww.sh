#!/bin/bash

#!/bin/bash

# Directorio donde se encuentran las imágenes
DIRECTORIO_IMAGENES="/home/dam/.config/hypr/wallpapers"

# Selecciona aleatoriamente un archivo de imagen (png o gif) en el directorio
IMAGEN_SELECCIONADA=$(find "$DIRECTORIO_IMAGENES" -type f \( -name "*.png" -o -name "*.gif" \) | shuf -n 1)

# Ejecuta el comando con la imagen seleccionada
swww img --transition-type outer --transition-pos 0.854,0.977 --transition-step 90 --transition-fps 60 "$IMAGEN_SELECCIONADA"

