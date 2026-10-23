

-- The base config sets QT_QPA_PLATFORMTHEME=kde (hyprland/env.lua:12) so Qt apps
-- pick up KDE's Material You colors. That pipeline is off here
-- (wallpaperTheming.enableQtApps = false), so all it did was render every Qt app
-- in stock Breeze — including hyprland-share-picker, the Qt6 window Meet opens
-- for screen sharing, which is why it looked like KDE.
--
-- gtk3 makes Qt apps follow the GTK theme instead, so they inherit the
-- Kanagawa Blur colours from gtk-3.0/gtk.css. The plugin ships with qt6-base
-- (libqgtk3.so); nothing extra to install. This file loads after hyprland/env.lua.
hl.env("QT_QPA_PLATFORMTHEME", "gtk3")
