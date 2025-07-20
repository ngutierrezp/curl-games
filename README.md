# Curl Games 🎮

<img width="596" height="563" alt="image" src="https://github.com/user-attachments/assets/c765a39e-880d-4ecc-b042-fc714472d3db" />

A collection of classic and modern terminal games written in Bash, ready to play with a single command. Each game is self-contained in its own folder, with a script and README for easy use and documentation.

---

## 🗂️ Project Structure
- Each game lives in its own folder (e.g. `snake/`)
- Every game folder must contain:
  - A Bash script named after the folder (e.g. `snake/snake.sh`)
  - A `README.md` with instructions and description
- The root contains a `main.sh` launcher that lists and runs all available games
- The project is designed for easy deployment and extension (just add a new folder with the required files!)

---

## 🚀 How to Play

1. **Clone the repository:**
   ```bash
   git clone https://github.com/ngutierrezp/curl-games.git
   cd curl-games
   bash main.sh
   ```
2. **Or run a specific game via HTTP:**
   ```bash
   bash <(curl -s games.ngutierrezp.cl)
   ```

---

## 📦 Included Games
- All games in this repo are listed automatically in the main menu.
- To add a new game, just create a folder with a `.sh` script and a `README.md`.

---

## 🛠️ Deployment
- Includes GitHub Actions for automatic deployment to a VM and validation of game structure.
- Nginx config and scripts are provided for easy HTTP serving and updates.

## Contributing
- Contributions are welcome!

---
if you like this project, consider starring it on GitHub! ⭐
I appreciate your support! ❤️

