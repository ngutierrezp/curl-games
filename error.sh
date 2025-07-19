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
for d in */; do
    game="${d%/}"
    if [ -f "$game/$game.sh" ]; then
        echo "  - $game"
    fi
done

echo -e "\nRun: bash <(curl -s games.ngutierrezp.cl/<game>)"
echo -e "\n${BOLD}With ❤️ by ngutierrezp${RESET}"
