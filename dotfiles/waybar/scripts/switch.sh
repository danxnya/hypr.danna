#!/bin/bash

# Configuraciones disponibles
CONFIGS=(
  "main:$HOME/.config/waybar/mainBar"
  "vert:$HOME/.config/waybar/verticalBar"
)

# Usa Rofi para seleccionar una configuración
OPCION=$(echo -e "main\nvert" | rofi -dmenu -p "Selecciona una configuración de Waybar:")

# Verifica si se seleccionó una opción
if [ -z "$OPCION" ]; then
  echo "No se seleccionó ninguna configuración. Saliendo..."
  exit 1
fi

# Busca la configuración seleccionada
for CONFIG in "${CONFIGS[@]}"; do
  KEY=$(echo "$CONFIG" | cut -d':' -f1)
  DIR=$(echo "$CONFIG" | cut -d':' -f2)
  
  if [ "$KEY" == "$OPCION" ]; then
    # Detiene cualquier instancia de Waybar
    pkill waybar 2>/dev/null

    # Inicia Waybar con la configuración seleccionada
    waybar -c "$DIR/config.jsonc" -s "$DIR/style.css" &
    
    echo "Waybar iniciado con la configuración '$KEY'."
    exit 0
  fi
done

# Si la opción no coincide
echo "Configuración no válida: $OPCION"
exit 1
