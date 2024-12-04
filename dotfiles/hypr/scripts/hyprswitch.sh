#!/bin/bash

# Define las rutas
PERFILES_DIR="$HOME/.config/hypr/confs"
DESTINO="$HOME/.config/hypr/hyprland.conf"

# Obtiene una lista de perfiles
PERFILES=$(ls -1 "$PERFILES_DIR")

# Verifica si hay perfiles disponibles
if [ -z "$PERFILES" ]; then
    echo "No se encontraron perfiles en $PERFILES_DIR."
    exit 1
fi

# Usa Rofi para seleccionar un perfil
PERFIL_SELECCIONADO=$(echo "$PERFILES" | rofi -dmenu -p "Selecciona un perfil:")

# Verifica si se seleccionó un perfil
if [ -z "$PERFIL_SELECCIONADO" ]; then
    echo "No se seleccionó ningún perfil. Saliendo..."
    exit 1
fi

# Ruta del perfil seleccionado
PERFIL_DIR="$PERFILES_DIR/$PERFIL_SELECCIONADO"

# Verifica si el directorio del perfil existe
if [ ! -d "$PERFIL_DIR" ]; then
    echo "El perfil '$PERFIL_SELECCIONADO' no existe en $PERFILES_DIR."
    exit 1
fi

# Copia el archivo de configuración del perfil al destino
cp "$PERFIL_DIR/hyprland.conf" "$DESTINO"

# Recarga la configuración de Hyprland
hyprctl reload

echo "Perfil cambiado a '$PERFIL_SELECCIONADO' y configuración recargada."
