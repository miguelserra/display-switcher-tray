#!/usr/bin/env bash
set -euo pipefail

SRC_DIR="$(cd "$(dirname "$0")" && pwd)"
BIN_DIR="${XDG_BIN_HOME:-$HOME/.local/bin}"
APP_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/applications"
AUTOSTART_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/autostart"

install -Dm755 "$SRC_DIR/display-switcher-tray" "$BIN_DIR/display-switcher-tray"
install -Dm644 "$SRC_DIR/display-switcher.desktop" "$APP_DIR/display-switcher.desktop"
install -Dm644 "$SRC_DIR/display-switcher.desktop" "$AUTOSTART_DIR/display-switcher.desktop"
sed -i "s|^Exec=.*|Exec=$BIN_DIR/display-switcher-tray|" "$AUTOSTART_DIR/display-switcher.desktop"

echo "Installed:"
echo "  $BIN_DIR/display-switcher-tray"
echo "  $APP_DIR/display-switcher.desktop"
echo "  $AUTOSTART_DIR/display-switcher.desktop (autostart)"
echo
echo "Start it now with: display-switcher-tray &"
echo "or open \"Display Switcher Tray\" from the app grid."
