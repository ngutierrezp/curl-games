#!/bin/bash
# Curl Games Main Menu

BOLD="\033[1m"
CYAN="\033[36m"
YELLOW="\033[33m"
MAGENTA="\033[35m"
RESET="\033[0m"

show_menu() {
    clear
    # Rubik's Cube ASCII Art
    echo -e "${CYAN}"
    cat << "EOF"
                ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⠤⠖⠊⠉⠉⠈⢦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⢤⣴⡖⠋⠈⠀⠀⠀⠀⠀⠀⠀⠀⠱⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣤⠴⠖⠛⠉⠁⠀⠙⣿⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣠⡤⣴⣞⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣷⡀⠀⠀⠀⠀⡀⠀⠀⠀⠀⠈⢳⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
            ⠀⠀⠀⠀⠀⠀⢀⣠⡤⠶⠞⠋⠉⠀⠀⠈⢿⣧⡀⠀⠀⠀⠀⠄⠀⠠⠀⠀⠀⡹⣿⣆⣀⠀⠀⠀⠀⣀⣠⡤⠖⠛⠻⢦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
            ⠀⠀⠀⠀⣔⣯⢉⠀⠀⠀⠀⠀⠀⠀⠀⠐⠀⠻⣿⣄⠀⠐⠈⠂⡀⠄⠀⠀⠀⠀⢌⣿⣿⣿⢷⠞⠛⠉⠁⠀⠀⠀⠀⠀⢳⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
            ⠀⠀⠀⠀⡇⠨⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣿⣦⡀⠀⠀⠀⠂⣀⣠⠴⠲⢛⣻⣿⣿⣄⠀⠀⡀⠀⢠⠀⠀⠀⠀⠀⠙⢆⠀⠀⠀⠀⠀⠀⠀⠀⠀
            ⠀⠀⠀⢸⠀⠀⠑⢿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⢐⢿⣿⣿⣿⣶⠞⠛⠉⠁⠀⠀⠀⠠⠔⠝⢿⣦⢂⠀⠀⠑⠀⢀⠀⢠⠀⠀⠈⠣⡀⠀⠀⠀⠀⠀⠀⠀
            ⠀⠀⠀⡜⠀⠀⠀⠈⢿⣆⠀⠀⠀⠀⢀⣀⣴⡴⠖⠛⠛⠿⣿⣇⠀⠀⠀⠀⠀⢀⠀⠀⠐⠀⠨⠻⣷⡄⠂⠀⠠⠈⠨⢄⠠⠀⡀⣀⣿⣀⠀⠀⠀⠀⠀⠀
            ⠀⠀⠀⢇⠀⠀⠀⠀⠀⠙⢷⣦⠶⠞⠛⠉⠑⢀⠄⠀⠀⡔⠘⢿⣧⡀⠀⠀⠐⠂⠉⠠⠂⠁⠔⠀⠙⣿⣤⣄⡀⢠⣀⣦⢶⡞⠛⠉⠁⠈⢣⡀⠀⠀⠀⠀
            ⠀⠀⢰⠈⢆⠀⠀⠀⠀⠀⡇⠻⣄⠀⠀⠰⠀⠁⠄⢈⠀⠙⡀⠊⢻⣷⡌⢄⠄⢀⠠⠀⠀⠀⠀⡐⢼⣿⣿⣿⣿⠟⠉⠊⠉⠃⠁⠀⠀⠀⠀⠑⣄⠀⠀⠀
            ⠀⠀⡘⠀⠀⠣⣀⠀⠀⣰⠀⠀⠙⣦⠀⠀⠀⠀⠀⠀⠀⠀⠂⠢⠠⡙⣿⣶⣴⣊⡀⣄⣠⣤⠶⠻⠋⠉⠛⠻⣿⣄⠀⠀⠀⠈⠀⠐⠁⣨⠀⠀⠈⢦⡀⠀
            ⠀⠀⠇⠀⠀⠀⠙⢤⡀⡌⠀⠀⠀⠈⢷⡀⠀⠀⠀⠀⢂⠄⠀⠀⡊⢹⣿⣿⣿⣿⠛⡉⠓⠁⢀⠀⢠⡄⠀⠀⠙⣿⣧⡠⠀⠀⠂⠁⢈⢀⢱⠂⠐⠀⢳⡄
            ⠀⢸⠀⠀⠀⠀⠀⠘⡌⡇⠀⠀⠀⠀⠀⠻⡀⠀⠀⠀⣤⣨⡤⠶⡛⠋⠉⠿⣿⣿⣄⡀⠂⠂⠀⠈⠁⠀⠀⠀⠀⠈⠻⣷⡕⠀⠣⠀⠀⢀⡀⣬⣲⠯⠓⡻
            ⠀⡜⠀⢠⠀⠀⠀⠀⢣⠚⣄⠀⠀⠀⠀⠀⢙⣿⠶⠛⢉⠐⠀⢈⠈⠀⠀⠀⠀⠙⣿⣮⠀⠀⠀⠀⠀⠀⢀⠀⠢⡄⢀⡙⣿⣦⣄⣶⠽⠒⠋⠁⠀⠀⢰⠁
            ⠀⠇⠀⠀⠱⡀⠀⠀⡇⠀⠙⣦⠀⠀⠀⠀⡘⠈⢷⡀⠀⢀⠀⠀⠢⠀⠀⠀⠀⡐⠬⢿⣷⡀⠀⠀⠀⠀⠀⠀⣀⣤⣶⠿⢟⡟⠁⠀⠀⠀⠀⠀⠀⢀⠇⠀
            ⢸⠀⠀⠀⠀⠘⢄⣰⠀⠀⠀⠘⢧⡀⠀⢀⠇⠀⠀⠻⣄⠀⠀⠐⠄⠀⠀⠀⠀⠀⠈⠀⠻⣿⣄⣠⣤⣴⠾⠟⠋⠉⠀⠀⣸⠁⠀⠀⠀⠀⠀⠀⠀⡜⠀⠀
            ⠀⠣⡀⠀⠀⠀⢣⠸⡀⠀⠀⠀⠀⢑⢄⣸⠀⠀⠀⠀⠙⣦⠀⠀⠀⠀⠀⠀⠀⣀⢠⣼⣾⠿⡿⠋⠉⠀⠀⠀⠀⠀⠀⢠⠇⠀⠀⠀⢀⣀⠤⠖⡺⠀⠀⠀
            ⠀⠀⠱⡄⠀⠀⢨⠋⠳⡀⠀⠀⠀⠀⠇⣸⠀⠀⠀⠀⠀⠘⢷⣁⣀⣠⣤⡶⠶⠛⠉⠉⠀⣰⠁⠀⠀⠀⠀⠀⠀⠀⣠⣿⣦⠤⠒⠊⠉⠀⠀⢠⠃⠀⠀⠀
            ⠀⠀⠀⠘⢄⠀⡾⠀⠀⠑⡄⠀⠀⠀⢰⠉⢧⠀⠀⠀⠀⠀⠈⣷⠛⠉⠁⠀⠀⠀⠀⠀⢀⡏⠀⠀⠀⠀⢀⣠⠤⠚⣿⠁⠀⠀⠀⠀⠀⠀⢀⠎⠀⠀⠀⠀
            ⠀⠀⠀⠀⠈⢆⠇⠀⠀⠀⠘⢆⠀⠀⡆⠀⠈⢣⠀⠀⠀⠀⢠⠁⠀⠀⠀⠀⠀⠀⠀⢠⣾⣄⣠⠤⠒⠊⠁⠀⠀⢀⠇⠀⠀⠀⠀⠀⠀⣀⡜⠀⠀⠀⠀⠀
            ⠀⠀⠀⠀⠀⠀⢣⠀⠀⠀⠀⠈⡗⢼⠁⠀⠀⠀⠱⡀⠀⠀⡎⠀⠀⠀⠀⠀⢀⣠⠴⢿⡟⠋⠀⠀⠀⠀⠀⠀⠀⡼⠀⠀⣀⡠⠴⠒⠉⣱⠁⠀⠀⠀⠀⠀
            ⠀⠀⠀⠀⠀⠀⠀⠱⡀⠀⠀⠀⢸⢘⡄⠀⠀⠀⠀⠙⣄⢰⠁⢀⣠⠤⠒⠋⠁⠀⠀⡼⠀⠀⠀⠀⠀⠀⠀⣠⣾⡷⠒⠋⠁⠀⠀⠀⢠⠃⠀⠀⠀⠀⠀⠀
            ⠀⠀⠀⠀⠀⠀⠀⠀⠙⣄⠀⠀⢠⠃⠸⡂⠀⠀⠀⠀⠈⡝⠋⠁⠀⠀⠀⠀⠀⠀⢰⠇⠀⠀⠀⣀⠤⠖⠋⢉⡏⠀⠀⠀⠀⠀⠀⢀⡎⠀⠀⠀⠀⠀⠀⠀
            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢆⠀⡘⠀⠀⠙⡄⠀⠀⠀⢰⠃⠀⠀⠀⠀⠀⠀⠀⣠⣿⠶⠖⠚⠉⠀⠀⠀⠀⣼⠁⠀⠀⣀⣠⠴⠖⠋⠀⠀⠀⠀⠀⠀⠀⠀
            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠣⡃⠀⠀⠀⠈⢧⠀⠀⡞⠀⠀⠀⠀⣀⡤⠔⠊⢻⠁⠀⠀⠀⠀⠀⠀⠀⢰⣇⡤⠖⠊⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠱⡄⠀⠀⠀⠀⠣⣸⣃⡠⠴⠚⠉⠀⠀⠀⠀⡏⠀⠀⠀⠀⣀⣠⠴⠚⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢄⠀⠀⠀⠀⡌⠀⠀⠀⠀⠀⠀⠀⠀⣸⢁⣠⠤⠒⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢦⠀⠀⢨⠃⠀⠀⠀⠀⢀⣀⡤⠖⠋⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠣⡀⡾⠀⣀⡤⠴⠚⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠙⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
EOF
    echo -e "${BOLD}"
    cat << "EOF"
 ██████╗██╗   ██╗██████╗ ██╗          ██████╗  █████╗ ███╗   ███╗███████╗███████╗
██╔════╝██║   ██║██╔══██╗██║         ██╔════╝ ██╔══██╗████╗ ████║██╔════╝██╔════╝
██║     ██║   ██║██████╔╝██║         ██║  ███╗███████║██╔████╔██║█████╗  ███████╗
██║     ██║   ██║██╔══██╗██║         ██║   ██║██╔══██║██║╚██╔╝██║██╔══╝  ╚════██║
╚██████╗╚██████╔╝██║  ██║███████╗    ╚██████╔╝██║  ██║██║ ╚═╝ ██║███████╗███████║
 ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝     ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝╚══════╝
EOF
    echo -e "${RESET}\n"
    games=()
    i=1
    # Download the latest games list from the server
    if command -v curl >/dev/null 2>&1; then
        while IFS= read -r game; do
            games+=("$game")
        done < <(curl -fsSL http://games.ngutierrezp.cl/games-list.txt)
    elif command -v wget >/dev/null 2>&1; then
        while IFS= read -r game; do
            games+=("$game")
        done < <(wget -qO- http://games.ngutierrezp.cl/games-list.txt)
    else
        echo "curl or wget is required to fetch the games list." >&2
        exit 1
    fi
    for game in "${games[@]}"; do
        echo -e "${YELLOW}$i)${RESET} $game"
        ((i++))
    done
    echo -e "${YELLOW}$i)${RESET} Open Repository"
    echo -e "${YELLOW}0)${RESET} Exit"
    echo
    echo -e "${MAGENTA}With ❤️ by ngutierrezp${RESET}"
    echo
    echo -ne "Select an option: "
    IFS= read -rsn1 opt
    echo
    if [[ "$opt" =~ ^[0-9]$ ]]; then
        if [ "$opt" -eq 0 ]; then
            clear; exit 0
        elif [ "$opt" -eq "$i" ]; then
            clear
            echo -e "${CYAN}Redirecting to repository...${RESET}"
            sleep 1
            if command -v xdg-open >/dev/null 2>&1; then
                xdg-open "https://github.com/ngutierrezp/curl-games"
            elif command -v open >/dev/null 2>&1; then
                open "https://github.com/ngutierrezp/curl-games"
            else
                echo "Open: https://github.com/ngutierrezp/curl-games"
            fi
            read -n1 -r -p "Press any key to return to menu..."
            show_menu
        elif [ "$opt" -ge 1 ] && [ "$opt" -lt "$i" ]; then
            clear
            # execute the game by downloading the latest script from the server
            bash <(curl -fsSL "http://games.ngutierrezp.cl/${games[$((opt-1))]}")
            echo
            read -n1 -r -p "Press any key to return to menu..."
            show_menu
        else
            show_menu
        fi
    else
        show_menu
    fi
}

show_menu
