#!/bin/bash
# Snake Game - Adapted for macOS bash 3.2 using dd for robust reading
# Author: ngutierrezp

# --- Color configuration ---
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
MAGENTA="\033[35m"
CYAN="\033[36m"
RESET="\033[0m"
BOLD="\033[1m"

ESCAPE_CHAR=$(printf '\033')

MIN_WIDTH=30
MIN_HEIGHT=30

main_menu() {
    # Validate terminal size
    term_width=$(tput cols)
    term_height=$(tput lines)
    if [ "$term_width" -lt "$MIN_WIDTH" ] || [ "$term_height" -lt "$MIN_HEIGHT" ]; then
        clear
        echo -e "${RED}Error: Terminal size too small!${RESET}"
        echo -e "Minimum required: ${MIN_WIDTH}x${MIN_HEIGHT}"
        echo -e "Current: ${term_width}x${term_height}"
        echo -e "\nResize your terminal and try again."
        exit 1
    fi

    clear
    echo -e "${BOLD}${GREEN}"
    cat << "EOF"
                                                              
                     ,--.                      ,--.           
  .--.--.          ,--.'|   ,---,          ,--/  /|    ,---,. 
 /  /    '.    ,--,:  : |  '  .' \      ,---,': / '  ,'  .' | 
|  :  /`. / ,`--.'`|  ' : /  ;    '.    :   : '/ / ,---.'   | 
;  |  |--`  |   :  :  | |:  :       \   |   '   ,  |   |   .' 
|  :  ;_    :   |   \ | ::  |   /\   \  '   |  /   :   :  |-, 
 \  \    `. |   : '  '; ||  :  ' ;.   : |   ;  ;   :   |  ;/| 
  `----.   \'   ' ;.    ;|  |  ;/  \   \:   '   \  |   :   .' 
  __ \  \  ||   | | \   |'  :  | \  \ ,'|   |    ' |   |  |-, 
 /  /`--'  /'   : |  ; .'|  |  '  '--'  '   : |.  \'   :  ;/| 
'--'.     / |   | '`--'  |  :  :        |   | '_\.'|   |    \ 
  `--'---'  '   : |      |  | ,'        '   : |    |   :   .' 
            ;   |.'      `--''          ;   |,'    |   | ,'   
            '---'                       '---'      `----'     
                                                                                                                      
EOF
    echo -e "${CYAN}========================================${RESET}"
    echo -e "${BOLD}${YELLOW}           S N A K E   G A M E${RESET}"
    echo -e "${CYAN}========================================${RESET}"
    echo -e "${BOLD}${MAGENTA}Instructions:${RESET}"
    echo -e "${YELLOW}- Use the ARROW KEYS or WASD to move the snake"
    echo -e "- Eat the food (●) to grow and score points"
    echo -e "- Avoid hitting the walls or yourself"
    echo -e "- Press Q to quit at any time"
    echo -e "${CYAN}========================================${RESET}"
    echo -e "${YELLOW}1) New Game${RESET}"
    echo -e "${YELLOW}2) Open Repository${RESET}"
    echo -e "${YELLOW}3) Exit${RESET}"
    echo -ne "\n${GREEN}Select an option: ${RESET}"
    read -n1 opt
    case $opt in
        1) select_level ;;
        2) open_repository ;;
        3) exit_game ;;
        *) main_menu ;;
    esac
}

open_repository() {
    clear
    echo -e "${BLUE}Repository: https://github.com/ngutierrezp/curl-games${RESET}"
    if command -v open >/dev/null 2>&1; then
        open "https://github.com/ngutierrezp/curl-games"
    elif command -v xdg-open >/dev/null 2>&1; then
        xdg-open "https://github.com/ngutierrezp/curl-games"
    fi
    echo -e "\nPress any key to return to the menu..."
    read -n1
    main_menu
}

select_level() {
    clear
    echo -e "${BOLD}${CYAN}Select difficulty level (1-9):${RESET}"
    for i in {1..9}; do
        echo -e "${YELLOW}$i${RESET}) Level $i"
    done
    echo -ne "\n${GREEN}Level: ${RESET}"
    read -n1 level
    if [[ $level =~ ^[1-9]$ ]]; then
        start_game $level
    else
        select_level
    fi
}

exit_game() {
    clear
    echo -e "${MAGENTA}"
    cat << "EOF"

 _____ _                 _        _ 
|_   _| |               | |      | |
  | | | |__   __ _ _ __ | | _____| |
  | | | '_ \ / _` | '_ \| |/ / __| |
  | | | | | | (_| | | | |   <\__ \_|
  \_/ |_| |_|\__,_|_| |_|_|\_\___(_)
                                    
EOF
    echo -e "${RESET}"
    echo -e "${BOLD}${YELLOW}Thanks for playing!${RESET}\n"
    echo -e "${BOLD}${CYAN}With ❤️  by ngutierrezp${RESET}\n"
    exit 0
}

# Robust key reading using dd
read_chars() {
  eval "$1=\$(dd bs=1 count=$2 2>/dev/null)"
}

game_over_screen() {
    clear
    echo -e "${RED}${BOLD}"
    cat << "EOF"
  ▄████  ▄▄▄      ███▄ ▄███▓▓█████     ▒█████   ██▒   █▓▓█████  ██▀███  
 ██▒ ▀█▒▒████▄   ▓██▒▀█▀ ██▒▓█   ▀    ▒██▒  ██▒▓██░   █▒▓█   ▀ ▓██ ▒ ██▒
▒██░▄▄▄░▒██  ▀█▄ ▓██    ▓██░▒███      ▒██░  ██▒ ▓██  █▒░▒███   ▓██ ░▄█ ▒
░▓█  ██▓░██▄▄▄▄██▒██    ▒██ ▒▓█  ▄    ▒██   ██░  ▒██ █░░▒▓█  ▄ ▒██▀▀█▄  
░▒▓███▀▒ ▓█   ▓██▒██▒   ░██▒░▒████▒   ░ ████▓▒░   ▒▀█░  ░▒████▒░██▓ ▒██▒
 ░▒   ▒  ▒▒   ▓▒█░ ▒░   ░  ░░░ ▒░ ░   ░ ▒░▒░▒░    ░ ▐░  ░░ ▒░ ░░ ▒▓ ░▒▓░
  ░   ░   ▒   ▒▒ ░  ░      ░ ░ ░  ░     ░ ▒ ▒░    ░ ░░   ░ ░  ░  ░▒ ░ ▒░
░ ░   ░   ░   ▒  ░      ░      ░      ░ ░ ░ ▒       ░░     ░     ░░   ░ 
      ░       ░  ░      ░      ░  ░       ░ ░        ░     ░  ░   ░     
                                                    ░                   
EOF
    echo -e "${RESET}"
    echo -e "${BOLD}${YELLOW}GAME OVER!${RESET}\n"
    echo -e "${BOLD}${CYAN}Your score: ${YELLOW}$score${RESET}\n"
    echo -e "${MAGENTA}Better luck next time!${RESET}\n"
    echo -e "Press any key to return to the menu..."
    stty -icanon -echo min 1 time 0
    read -n1 _
    stty icanon echo
    main_menu
}

# Helper to check if a position is on the snake
is_on_snake() {
    local x=$1
    local y=$2
    for seg in "${snake_body[@]}"; do
        if [ "$seg" == "$x,$y" ]; then
            return 0
        fi
    done
    return 1
}

# Generate food not on the snake
generate_food() {
    while true; do
        local fx=$((RANDOM % (width-2) + 2))
        local fy=$((RANDOM % (height-2) + 2))
        if ! is_on_snake $fx $fy; then
            food_x=$fx
            food_y=$fy
            break
        fi
    done
}

win_screen() {
    clear
    echo -e "${GREEN}${BOLD}"
    cat << "EOF"
 __     __          __          ___       _ 
 \ \   / /          \ \        / (_)     | |
  \ \_/ /__  _   _   \ \  /\  / / _ _ __ | |
   \   / _ \| | | |   \ \/  \/ / | | '_ \| |
    | | (_) | |_| |    \  /\  /  | | | | |_|
    |_|\___/ \__,_|     \/  \/   |_|_| |_(_)
EOF
    echo -e "${RESET}"
    echo -e "${BOLD}${YELLOW}YOU WIN!${RESET}\n"
    echo -e "${BOLD}${CYAN}Your score: ${YELLOW}$score${RESET}\n"
    echo -e "${MAGENTA}Congratulations, you filled the board!${RESET}\n"
    echo -e "Press any key to return to the menu..."
    stty -icanon -echo min 1 time 0
    read -n1 _
    stty icanon echo
    main_menu
}

start_game() {
    level=$1
    # Level 1: slowest, Level 9: fastest
    # Normal speed: 120 (ms), fastest: 30 (ms)
    speed=$((120 - (level - 1) * 12))
    [ $speed -lt 30 ] && speed=30
    width=30
    height=15
    lives=3
    score=0
    declare -A walls
    snake_x=15
    snake_y=8
    snake_dir="RIGHT"
    snake_body=("15,8" "14,8" "13,8")
    food_x=$((RANDOM % (width-2) + 2))
    food_y=$((RANDOM % (height-2) + 2))

    generate_food

    draw_board() {
        tput cup 0 0
        for ((y=1;y<=height;y++)); do
            for ((x=1;x<=width;x++)); do
                if [ $x -eq 1 ] || [ $x -eq $width ] || [ $y -eq 1 ] || [ $y -eq $height ]; then
                    echo -ne "${CYAN}█${RESET}"
                elif [ "${walls["$x,$y"]}" == "1" ]; then
                    echo -ne " "
                elif [ $x -eq $food_x ] && [ $y -eq $food_y ]; then
                    echo -ne "${YELLOW}●${RESET}"
                else
                    is_body=0
                    head_idx=$((${#snake_body[@]}-1))
                    for idx in "${!snake_body[@]}"; do
                        seg="${snake_body[$idx]}"
                        if [ "$seg" == "$x,$y" ]; then
                            is_body=1
                            if [ "$idx" -eq "$head_idx" ]; then
                                echo -ne "${GREEN}■${RESET}"
                            else
                                echo -ne "${GREEN}□${RESET}"
                            fi
                            break
                        fi
                    done
                    [ $is_body -eq 0 ] && echo -ne " "
                fi
            done
            echo
        done
        # Show lives as 'N x ❤️' for better proportions
        lives_str="${lives} x ❤️"
        echo -e "${BOLD}Score:${RESET} $score     $lives_str    ${BOLD}Level:${RESET} $level"
    }

    move_snake() {
        case $snake_dir in
            UP)    ((snake_y--));;
            DOWN)  ((snake_y++));;
            LEFT)  ((snake_x--));;
            RIGHT) ((snake_x++));;
        esac

        # Wall collision
        if [ $snake_x -le 1 ] || [ $snake_x -ge $width ] || [ $snake_y -le 1 ] || [ $snake_y -ge $height ]; then
            if [ $lives -le 1 ]; then
                lives=0
                game_over_screen
                return
            else
                lives=$((lives-1))
                snake_x=15; snake_y=8; snake_dir="RIGHT"; snake_body=("15,8" "14,8" "13,8")
                return
            fi
        fi

        # Self collision
        for seg in "${snake_body[@]}"; do
            if [ "$seg" == "$snake_x,$snake_y" ]; then
                if [ $lives -le 1 ]; then
                    lives=0
                    game_over_screen
                    return
                else
                    lives=$((lives-1))
                    snake_x=15; snake_y=8; snake_dir="RIGHT"; snake_body=("15,8" "14,8" "13,8")
                    return
                fi
            fi
        done

        # Eat food
        if [ $snake_x -eq $food_x ] && [ $snake_y -eq $food_y ]; then
            score=$((score+10))
            # Win condition: snake fills the board (all possible positions)
            if [ $(( (${#snake_body[@]}+1) * 2 )) -ge $((width*height)) ]; then
                win_screen
                return
            fi
            generate_food
        else
            unset snake_body[0]
            snake_body=("${snake_body[@]}")
        fi
        snake_body+=("$snake_x,$snake_y")
    }

    read_key() {
      read_chars key 1
      if [ "$key" = "$ESCAPE_CHAR" ]; then
        read_chars rest 2
        key="${rest##*[}"
      fi

      case "$key" in
        q|Q) exit_game ;;
        A) [ "$snake_dir" != "DOWN" ] && snake_dir="UP" ;;
        B) [ "$snake_dir" != "UP" ] && snake_dir="DOWN" ;;
        C) [ "$snake_dir" != "LEFT" ] && snake_dir="RIGHT" ;;
        D) [ "$snake_dir" != "RIGHT" ] && snake_dir="LEFT" ;;
        w|W) [ "$snake_dir" != "DOWN" ] && snake_dir="UP" ;;
        s|S) [ "$snake_dir" != "UP" ] && snake_dir="DOWN" ;;
        d|D) [ "$snake_dir" != "LEFT" ] && snake_dir="RIGHT" ;;
        a|A) [ "$snake_dir" != "RIGHT" ] && snake_dir="LEFT" ;;
      esac
    }

    clear
    tput civis
    old_stty_cfg=$(stty -g)
    stty -icanon -echo time 1 min 0
    trap 'tput cnorm; stty "$old_stty_cfg"; clear; exit' INT TERM

    while true; do
        draw_board
        read_key
        move_snake
        sleep $(echo "scale=2; $speed/1000" | bc)
    done

    tput cnorm
    stty "$old_stty_cfg"
}

main_menu
