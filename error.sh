#!/bin/bash
# error.sh - Lists available games if a requested game is not found

BOLD="\033[1m"
RED="\033[31m"
YELLOW="\033[33m"
RESET="\033[0m"

clear
echo -e "${RED}Game Not Found!${RESET}\n"
echo "The requested game does not exist."
echo -e "\n${YELLOW}Available games:${RESET}"
if command -v curl >/dev/null 2>&1; then
    curl -fsSL http://games.ngutierrezp.cl/games-list.txt | awk '{print "  - "$0}'
elif command -v wget >/dev/null 2>&1; then
    wget -qO- http://games.ngutierrezp.cl/games-list.txt | awk '{print "  - "$0}'
else
    echo "Could not fetch games list."
fi

echo -e "\nRun: bash <(curl -s games.ngutierrezp.cl/<game>)"
echo -e "\n${BOLD}With ❤️ by ngutierrezp${RESET}"
