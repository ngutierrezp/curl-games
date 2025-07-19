#!/bin/bash
# games-list.sh - Outputs the list of available games (for use by main.sh)

for d in */; do
    game="${d%/}"
    if [ -f "$game/$game.sh" ]; then
        echo "$game"
    fi
done

# Generate games-list.txt (to be run on the server after deploy)
find . -mindepth 2 -maxdepth 2 -name '*.sh' \
  | awk -F'/' '{print $(NF-1)}' \
  | sort | uniq > games-list.txt
