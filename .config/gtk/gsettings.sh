#!/usr/bin/env bash

# Retrieve system theme vars
source $XDG_CONFIG_HOME/theme/fonts

# TODO: Find a better theme.
# GTK theme: https://www.gnome-look.org/p/1441725
# gsettings set org.gnome.desktop.interface gtk-theme 'Skeuos-Blue-Dark'
# GTK theme: https://github.com/vinceliuice/Qogir-theme
gsettings set org.gnome.desktop.interface gtk-theme 'Qogir-Dark'

# TODO: Replace default icons.
# For icons: Download and install to `.local/share/icons`
# gsettings set org.gnome.desktop.interface icon-theme 'Adwaita'

gsettings set org.gnome.desktop.interface font-name "$font_sans 11"
gsettings set org.gnome.desktop.interface document-font-name "$font_sans 11"
gsettings set org.gnome.desktop.interface monospace-font-name "$font_mono 12"
gsettings set org.gnome.desktop.interface cursor-theme "Simp1e"

# Show hidden files in file dialog.
gsettings set org.gtk.Settings.FileChooser show-hidden true

