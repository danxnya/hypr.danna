#!/bin/bash

# Configuración base
CONFIG_DIR="$HOME/.config/waybar"
VERTICAL_BAR_DIR="$CONFIG_DIR/verticalBar"
DEFAULT_CONFIG="$VERTICAL_BAR_DIR/config.jsonc"
DEFAULT_STYLE="$VERTICAL_BAR_DIR/style.css"

# Detectar monitores activos con hyprctl o xrandr
if command -v hyprctl &> /dev/null; then
  ACTIVE_MONITORS=$(hyprctl monitors | grep "Monitor" | awk '{print $2}')
elif command -v xrandr &> /dev/null; then
  ACTIVE_MONITORS=$(xrandr --listactivemonitors | tail -n +2 | awk '{print $NF}')
else
  echo "Error: No se detectó hyprctl ni xrandr."
  exit 1
fi

# Asignar configuración según el monitor activo
if echo "$ACTIVE_MONITORS" | grep -q "HDMI-A-1"; then
  echo "Monitor HDMI-A-1 detectado."
  CONFIG="$VERTICAL_BAR_DIR/config.jsonc"
  STYLE="$VERTICAL_BAR_DIR/style.css"
elif echo "$ACTIVE_MONITORS" | grep -q "eDP-1"; then
  echo "Monitor eDP-1 detectado."
  CONFIG="$VERTICAL_BAR_DIR/secondmonitor.jsonc"
  STYLE="$VERTICAL_BAR_DIR/style.css"
else
  echo "No se detectó monitor específico, usando configuración por defecto."
  CONFIG="$DEFAULT_CONFIG"
  STYLE="$DEFAULT_STYLE"
fi

# Cierra cualquier instancia de Waybar
echo "Cerrando Waybar existente..."
pgrep -x waybar > /dev/null && pkill -f 'waybar -c' 2>/dev/null || echo "No se encontró Waybar corriendo."

# Verifica que los archivos de configuración existen
if [[ ! -f "$CONFIG" ]]; then
  echo "Error: Configuración no encontrada en $CONFIG."
  exit 1
fi
if [[ ! -f "$STYLE" ]]; then
  echo "Error: Estilo no encontrado en $STYLE."
  exit 1
fi

# Inicia Waybar con la configuración y estilo seleccionados
echo "Iniciando Waybar con configuración en $CONFIG y estilo en $STYLE..."
waybar -c "$CONFIG" -s "$STYLE" &

# Verifica si Waybar inició correctamente
if [[ $? -ne 0 ]]; then
  echo "Error al iniciar Waybar. Revisa los logs."
  exit 1
fi

echo "Waybar iniciado correctamente."
