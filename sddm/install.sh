#!/usr/bin/env bash
# Installs the Kanagawa Wave Blur SDDM theme config.
# Run as your normal user; it calls sudo internally where root is needed.
set -euo pipefail

DOTFILES_SDDM="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
THEME_DIR="/usr/share/sddm/themes/sddm-astronaut-theme"

echo "==> Installing IosevkaTerm Nerd Font system-wide"
sudo mkdir -p /usr/share/fonts/iosevka-term-nerd
sudo cp -f "$HOME"/.local/share/fonts/IosevkaTermNerdFont*.ttf /usr/share/fonts/iosevka-term-nerd/
sudo fc-cache -f >/dev/null

echo "==> Copying the wave background into the theme"
sudo cp -f "$DOTFILES_SDDM/kanagawa_wave.jpg" "$THEME_DIR/Backgrounds/kanagawa_wave.jpg"

echo "==> Copying the Kanagawa config over the theme's active config"
sudo cp -f "$DOTFILES_SDDM/matugen.conf" "$THEME_DIR/Themes/matugen.conf"

echo "==> Switching /etc/sddm.conf to sddm-astronaut-theme"
sudo sed -i 's/^Current=.*/Current=sddm-astronaut-theme/' /etc/sddm.conf

echo "==> Done. Preview without logging out:"
echo "    sddm-greeter --test-mode --theme $THEME_DIR"
echo "==> Or just reboot to see it for real."
