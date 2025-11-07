#!/bin/bash

################################################################################
# Colorful.sh - Terminal color demonstration
# Usage: Colorful.sh
################################################################################

# Display banner
echo -e "\033[1;36m╔════════════════════════════════════════════════════════╗\033[0m"
echo -e "\033[1;36m║          Terminal Color Demonstration                 ║\033[0m"
echo -e "\033[1;36m╚════════════════════════════════════════════════════════╝\033[0m\n"

# Basic Colors
echo -e "\033[1;34m[Basic Text Colors]\033[0m"
echo -e "\033[0;30m Black Text   \033[0m (30)"
echo -e "\033[0;31m Red Text     \033[0m (31)"
echo -e "\033[0;32m Green Text   \033[0m (32)"
echo -e "\033[0;33m Yellow Text  \033[0m (33)"
echo -e "\033[0;34m Blue Text    \033[0m (34)"
echo -e "\033[0;35m Magenta Text \033[0m (35)"
echo -e "\033[0;36m Cyan Text    \033[0m (36)"
echo -e "\033[0;37m White Text   \033[0m (37)"

echo ""

# Bold Colors
echo -e "\033[1;34m[Bold Text Colors]\033[0m"
echo -e "\033[1;30m Bold Black   \033[0m (1;30)"
echo -e "\033[1;31m Bold Red     \033[0m (1;31)"
echo -e "\033[1;32m Bold Green   \033[0m (1;32)"
echo -e "\033[1;33m Bold Yellow  \033[0m (1;33)"
echo -e "\033[1;34m Bold Blue    \033[0m (1;34)"
echo -e "\033[1;35m Bold Magenta \033[0m (1;35)"
echo -e "\033[1;36m Bold Cyan    \033[0m (1;36)"
echo -e "\033[1;37m Bold White   \033[0m (1;37)"

echo ""

# Background Colors
echo -e "\033[1;34m[Background Colors]\033[0m"
echo -e "\033[40m Black Background   \033[0m (40)"
echo -e "\033[41m Red Background     \033[0m (41)"
echo -e "\033[42m Green Background   \033[0m (42)"
echo -e "\033[43m Yellow Background  \033[0m (43)"
echo -e "\033[44m Blue Background    \033[0m (44)"
echo -e "\033[45m Magenta Background \033[0m (45)"
echo -e "\033[46m Cyan Background    \033[0m (46)"
echo -e "\033[47m White Background   \033[0m (47)"

echo ""

# Combined Styles
echo -e "\033[1;34m[Combined Styles]\033[0m"
echo -e "\033[1;37;41m Bold White on Red    \033[0m (1;37;41)"
echo -e "\033[1;30;42m Bold Black on Green  \033[0m (1;30;42)"
echo -e "\033[1;37;44m Bold White on Blue   \033[0m (1;37;44)"
echo -e "\033[1;33;40m Bold Yellow on Black \033[0m (1;33;40)"

echo ""

# Text Styles
echo -e "\033[1;34m[Text Styles]\033[0m"
echo -e "\033[1m Bold Text       \033[0m (1)"
echo -e "\033[2m Dim Text        \033[0m (2)"
echo -e "\033[4m Underlined Text \033[0m (4)"
echo -e "\033[5m Blinking Text   \033[0m (5)"
echo -e "\033[7m Inverted Text   \033[0m (7)"

echo ""

# Rainbow effect
echo -e "\033[1;34m[Rainbow Text]\033[0m"
echo -e "\033[0;31mR\033[0;33ma\033[0;32mi\033[0;36mn\033[0;34mb\033[0;35mo\033[0;31mw\033[0m \033[1;37mT\033[1;33me\033[1;32mx\033[1;36mt\033[1;34m!\033[0m"

echo ""

# Color palette
echo -e "\033[1;34m[256 Color Palette Sample]\033[0m"
echo "Standard Colors (0-15):"
for i in {0..15}; do
    echo -ne "\033[48;5;${i}m  \033[0m"
done
echo ""

echo "Grayscale (232-255):"
for i in {232..255}; do
    echo -ne "\033[48;5;${i}m  \033[0m"
done
echo ""

echo ""

# Usage information
echo -e "\033[1;34m[Usage in Bash Scripts]\033[0m"
echo 'Format: echo -e "\033[<style>;<color>m Text \033[0m"'
echo ""
echo "Common codes:"
echo "  0 - Reset/Normal"
echo "  1 - Bold"
echo "  4 - Underline"
echo "  30-37 - Text colors"
echo "  40-47 - Background colors"
echo "  \033[0m - Always reset at the end!"
echo ""

# Fun animation
echo -e "\033[1;34m[Color Animation]\033[0m"
echo -n "Loading: "
for i in {1..5}; do
    echo -ne "\033[0;31m█\033[0m"
    sleep 0.1
    echo -ne "\033[0;33m█\033[0m"
    sleep 0.1
    echo -ne "\033[0;32m█\033[0m"
    sleep 0.1
    echo -ne "\033[0;36m█\033[0m"
    sleep 0.1
    echo -ne "\033[0;34m█\033[0m"
    sleep 0.1
done
echo -e " \033[1;32m✓ Complete!\033[0m"

echo ""
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\033[1;32mColor demonstration complete!\033[0m"
echo ""
