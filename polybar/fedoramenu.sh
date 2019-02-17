#!/bin/sh
#
# This script launches jgmenu in short-lived mode.
# It can be run with a parallel with a long-running invocation of jgmenu
#

config_file=$(mktemp)
trap "rm -f ${config_file}" EXIT

cat <<'EOF' >${config_file}
menu_margin_y       = 25
menu_halign         = left
menu_valign         = top

font                = Cantarell 12
icon_size           = 0
EOF

. "$HOME/.cache/wal/colors.sh"

echo "color_menu_bg       = $background 100" >> ${config_file}
echo "color_menu_border   = $background 0" >> ${config_file}

echo "color_norm_bg       = $background 100" >> ${config_file}
echo "color_norm_fg       = $foreground 100" >> ${config_file}

echo "color_sel_bg        = $foreground 100" >> ${config_file}
echo "color_sel_fg        = $background 100" >> ${config_file}
echo "color_sel_border    = $background 0" >> ${config_file}

echo "color_sep_fg        = $background 0" >> ${config_file}

cat $XDG_CONFIG_HOME/polybar/fedoramenu.csv | jgmenu --simple --config-file=${config_file}
