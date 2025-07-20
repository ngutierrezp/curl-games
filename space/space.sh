#!/bin/bash

RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
CYAN="\033[36m"
MAGENTA="\033[35m"
RESET="\033[0m"
BOLD="\033[1m"

ESCAPE_CHAR=$(printf '\033')

width=20
height=30

score=0
vidas=3
WIN_SCORE=100000

nave_x=$((width/2))
shoots=()
enemies=()
explosions=()
impacts=()

old_stty_cfg=$(stty -g)

cleanup() { tput cnorm; stty "$old_stty_cfg"; clear; }

read_chars() { eval "$1=\$(dd bs=1 count=$2 2>/dev/null)"; }

update_pos() { tput cup "$2" "$1"; echo -ne "$3"; }

draw_border() {
  clear
  for ((y=1;y<=height;y++)); do update_pos 1 $y "${CYAN}█${RESET}"; update_pos $width $y "${CYAN}█${RESET}"; done
  for ((x=1;x<=width;x++)); do update_pos $x 1 "${CYAN}█${RESET}"; update_pos $x $height "${CYAN}█${RESET}"; done
}

# Variable global para mostrar mensaje de impacto
impact_flash=0

validate_terminal_size() {
  term_width=$(tput cols)
  term_height=$(tput lines)
  if [ "$term_width" -lt "$width" ] || [ "$term_height" -lt "$((height+3))" ]; then
    clear
    echo -e "${RED}Error: Terminal size too small!${RESET}"
    echo -e "Minimum required: ${width}x$((height+2))"
    echo -e "Current: ${term_width}x${term_height}"
    echo -e "\nResize your terminal and try again."
    exit 1
  fi
}

draw_status() {
  tput cup $((height+1)) 0
  echo -ne "${BOLD}Score:${RESET} $score  ${BOLD}Lives:${RESET} $vidas ❤️ "
  tput el
  if [ "$impact_flash" -gt 0 ]; then
    tput cup $((height+2)) 0
    echo -e "${RED}${BOLD}IMPACT!!${RESET}"
    tput el
    impact_flash=$((impact_flash-1))
  else
    tput cup $((height+2)) 0
    tput el
  fi
}

spawn_enemy() {
  local max_enemies=6
  [ "$score" -ge 6000 ] && max_enemies=7
  if [ "${#enemies[@]}" -lt "$max_enemies" ]; then
    ex=$((RANDOM % (width - 2) + 2))
    enemies+=("$ex,2")
  fi
}

check_collisions() {
  local new_shoots=()
  local new_enemies=()
  for e in "${enemies[@]}"; do
    IFS=',' read ex ey <<< "$e"
    local hit=0
    for d in "${shoots[@]}"; do
      IFS=',' read dx dy <<< "$d"
      if [ "$dx" -eq "$ex" ] && [ "$dy" -le "$ey" ] && [ $((ey - dy)) -ge 0 ] && [ $((ey - dy)) -le 2 ]; then
        explosions+=("$ex,$ey,5")
        score=$((score+100))
        hit=1
        break
      fi
    done
    [ $hit -eq 0 ] && new_enemies+=("$ex,$ey") || update_pos $ex $ey " "
  done
  for d in "${shoots[@]}"; do
    IFS=',' read dx dy <<< "$d"
    local collided=0
    for e in "${enemies[@]}"; do
      IFS=',' read ex ey <<< "$e"
      if [ "$dx" -eq "$ex" ] && [ "$dy" -le "$ey" ] && [ $((ey - dy)) -ge 0 ] && [ $((ey - dy)) -le 2 ]; then
        collided=1
        break
      fi
    done
    [ $collided -eq 0 ] && new_shoots+=("$dx,$dy")
  done
  shoots=("${new_shoots[@]}")
  enemies=("${new_enemies[@]}")
}

move_shots() {
  local updated_shots=()
  for d in "${shoots[@]}"; do
    IFS=',' read dx dy <<< "$d"
    update_pos $dx $dy " "
    ((dy--))
    [ "$dy" -gt 1 ] && updated_shots+=("$dx,$dy") && update_pos $dx $dy "${GREEN}|${RESET}"
  done
  shoots=("${updated_shots[@]}")
}

move_enemies() {
  local updated_enemies=()
  for e in "${enemies[@]}"; do
    IFS=',' read ex ey <<< "$e"
    update_pos $ex $ey " "
    ((ey++))
    if [ "$ey" -ge "$height" ]; then
      vidas=$((vidas-1))
      impacts+=("$ex,$((height-1)),5")
      impact_flash=5
      [ "$vidas" -le 0 ] && game_over_screen
    else
      updated_enemies+=("$ex,$ey")
      update_pos $ex $ey "${RED}@${RESET}"
    fi
  done
  enemies=("${updated_enemies[@]}")
}

render_explosions() {
  local remaining=()
  for e in "${explosions[@]}"; do
    IFS=',' read ex ey frames <<< "$e"
    update_pos $ex $ey "${YELLOW}*${RESET}"
    frames=$((frames-1))
    [ "$frames" -gt 0 ] && remaining+=("$ex,$ey,$frames") || update_pos $ex $ey " "
  done
  explosions=("${remaining[@]}")
}

render_impacts() {
  local remaining=()
  for i in "${impacts[@]}"; do
    IFS=',' read ix iy frames <<< "$i"
    update_pos $ix $iy "${RED}X${RESET}"
    frames=$((frames-1))
    [ "$frames" -gt 0 ] && remaining+=("$ix,$iy,$frames") || update_pos $ix $iy " "
  done
  impacts=("${remaining[@]}")
}

check_win() { [ "$score" -ge "$WIN_SCORE" ] && win_screen; }

enemy_speed_threshold() {
  if [ "$score" -ge 50000 ]; then echo 2
  elif [ "$score" -ge 40000 ]; then echo 4
  elif [ "$score" -ge 25000 ]; then echo 6
  elif [ "$score" -ge 10000 ]; then echo 8
  else echo 10
  fi
}

show_start_screen() {
  clear
  echo -e "${BOLD}${CYAN}"
  cat << "EOF"
   _____                      _____ __                __           
  / ___/____  ____ _________ / ___// /_  ____  ____  / /____  _____
  \__ \/ __ \/ __ `/ ___/ _ \\__ \/ __ \/ __ \/ __ \/ __/ _ \/ ___/
 ___/ / /_/ / /_/ / /__/  __/__/ / / / / /_/ / /_/ / /_/  __/ /    
/____/ .___/\__,_/\___/\___/____/_/ /_/\____/\____/\__/\___/_/     
    /_/                                                            
EOF
  echo -e "${RESET}"
  echo -e "${CYAN}========================================${RESET}"
  echo -e "${BOLD}${YELLOW}      S P A C E   S H O O T E R${RESET}"
  echo -e "${CYAN}========================================${RESET}"
  echo -e "${BOLD}${MAGENTA}Instructions:${RESET}"
  echo -e "${YELLOW}- Use A/D or ←/→ to move the ship left/right"
  echo -e "- Press SPACE to shoot"
  echo -e "- Destroy enemies before they reach the bottom"
  echo -e "- You have 3 lives. Good luck!"
  echo -e "- Score increases with each enemy destroyed"
  echo -e "- Reach ${BOLD}${YELLOW}$WIN_SCORE${RESET}${YELLOW} points to win"
  echo -e "- The enemy speed increases as you score more points!! Be careful!"
  echo -e "- Q to quit at any time"
  echo -e "${CYAN}========================================${RESET}"
  echo -e "${YELLOW}1) New Game${RESET}"
  echo -e "${YELLOW}2) Open Repository${RESET}"
  echo -e "${YELLOW}3) Exit${RESET}"
  echo -ne "\n${GREEN}Select an option: ${RESET}"
  read -n1 opt
  case $opt in
    1) start_game ;;
    2) open_repository ;;
    3) cleanup; exit 0 ;;
    *) show_start_screen ;;
  esac
}

open_repository() {
  clear
  echo -e "${BLUE}Repository: https://github.com/ngutierrezp/curl-game/tree/main/space${RESET}"
  if command -v open >/dev/null 2>&1; then
    open "https://github.com/ngutierrezp/curl-game/tree/main/space"
  elif command -v xdg-open >/dev/null 2>&1; then
    xdg-open "https://github.com/ngutierrezp/curl-game/tree/main/space"
  fi
  echo -e "\nPress any key to return to the menu..."
  read -n1
  show_start_screen
}

game_over_screen() {
  cleanup
  echo -e "${RED}${BOLD}"
  cat << "EOF"
   _____                         ____                 
  / ____|                       / __ \                
 | |  __  __ _ _ __ ___   ___  | |  | |_   _____ _ __ 
 | | |_ |/ _` | '_ ` _ \ / _ \ | |  | \ \ / / _ \ '__|
 | |__| | (_| | | | | | |  __/ | |__| |\ V /  __/ |   
  \_____|\__,_|_| |_| |_|\___|  \____/  \_/ \___|_|   
EOF
  echo -e "${RESET}"
  echo -e "${BOLD}${YELLOW}GAME OVER!${RESET}\n"
  echo -e "${BOLD}${CYAN}Your score: ${YELLOW}$score${RESET}\n"
  echo -e "${MAGENTA}Try again!${RESET}\n"
  sleep 2
  echo -e "Press any key to return to the menu..."
  read -n1
  show_start_screen
}

win_screen() {
  cleanup
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
  echo -e "${MAGENTA}Congratulations, you reached the max score!${RESET}\n"
  sleep 2
  echo -e "Press any key to return to the menu..."
  read -n1
  show_start_screen
}

main_menu() {
  validate_terminal_size
  show_start_screen
}

start_game() {
  nave_x=$((width/2))
  shoots=() enemies=() explosions=() impacts=()
  score=0 vidas=3 tick=0

  tput civis
  stty -icanon -echo time 0 min 0
  trap cleanup EXIT

  draw_border
  update_pos $nave_x $((height-1)) "${GREEN}^${RESET}"

  while true; do
    key=""
    read_chars key 1
    if [ "$key" = "$ESCAPE_CHAR" ]; then
      read_chars rest 2
      [[ "$rest" == "[D" ]] && key="LEFT"
      [[ "$rest" == "[C" ]] && key="RIGHT"
    fi
    case "$key" in
      q|Q) cleanup; exit 0 ;;
      a|A|LEFT) [ "$nave_x" -gt 2 ] && { update_pos $nave_x $((height-1)) " "; ((nave_x--)); } ;;
      d|D|RIGHT) [ "$nave_x" -lt $((width-1)) ] && { update_pos $nave_x $((height-1)) " "; ((nave_x++)); } ;;
      " ") shoots+=("$nave_x,$((height-2))") ;;
    esac
    update_pos $nave_x $((height-1)) "${GREEN}^${RESET}"

    move_shots
    check_collisions
    speed=$(enemy_speed_threshold)
    (( tick % speed == 0 )) && move_enemies
    (( tick % 10 == 0 )) && spawn_enemy

    render_explosions
    render_impacts
    draw_status
    check_win

    ((tick++))
    sleep 0.05
  done
}

main_menu