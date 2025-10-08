#!/data/data/com.termux/files/usr/bin/bash
# linux_banner_enhanced.sh - Enhanced Termux banner with Owner/GitHub/WhatsApp

### USER CONFIG
SLEEP_CHAR=0.002       # typing speed per character
SLEEP_LINE=0.01        # extra delay after each line
BANNER_DELAY=0.5
USE_SHADOW=1           # 1 = show shadow
CENTER_TEXT=1          # 1 = center banner horizontally
USE_PROGRESS=1         # small loading bar before banner
GRADIENT_STYLE="rainbow"  # options: rainbow, teal, sunset, green

# New visual features
MATRIX_INTRO=1
BOOT_MESSAGES=1
PULSE_BORDER=1
SOUND_BEEP=0

# Owner Info
OWNER_NAME="RAJA"
GITHUB_LINK="https://github.com/mr30iii"
WHATSAPP_CHANNEL="https://www.whatsapp.com/channel/0029VbBTcfJCHDys1Q2ltf0n"

ESC="\e"
RESET="${ESC}[0m"
BOLD="${ESC}[1m"
DIM="${ESC}[2m"
UNDER="${ESC}[4m"

# 256-color helpers
fg() { printf "%b" "${ESC}[38;5;$1m"; }
bgc() { printf "%b" "${ESC}[48;5;$1m"; }

get_cols() {
  cols=$(tput cols 2>/dev/null || echo 80)
  echo $cols
}

center_line() {
  local line="$1"
  if [ "$CENTER_TEXT" -eq 1 ]; then
    local cols=$(get_cols)
    local len=${#line}
    if [ "$len" -lt "$cols" ]; then
      local pad=$(( (cols - len) / 2 ))
      printf "%*s%s\n" $pad "" "$line"
    else
      printf "%s\n" "$line"
    fi
  else
    printf "%s\n" "$line"
  fi
}

gradient_color() {
  local idx=$1
  case "$GRADIENT_STYLE" in
    rainbow) colors=(196 202 208 214 220 226 190 154 118 82 46 47 48 51 39 27 21) ;;
    teal)    colors=(30 31 36 37 43 44 50 51) ;;
    sunset)  colors=(160 166 172 178 184 220 208) ;;
    green)   colors=(22 28 34 40 46 82 118 154) ;;
    *)       colors=(82 118 154 190 226) ;;
  esac
  local n=${#colors[@]}
  echo "${colors[$(( idx % n ))]}"
}

type_line_colored() {
  local line="$1"
  local baseidx=${2:-0}
  for ((i=0;i<${#line};i++)); do
    ch="${line:i:1}"
    color=$(gradient_color $((baseidx + i)))
    printf "%b" "$(fg $color)${ch}${RESET}"
    sleep $SLEEP_CHAR
  done
  printf "\n"
  sleep $SLEEP_LINE
}

progress_bar() {
  [ "$USE_PROGRESS" -eq 1 ] || return
  local width=36
  local step=0
  printf "%b" "${DIM}Preparing environment:${RESET} "
  while [ $step -le $width ]; do
    local filled=$step
    local empty=$((width - step))
    printf "%b" "["
    for ((i=0;i<filled;i++)); do printf "%b" "$(fg 46)=${RESET}"; done
    for ((i=0;i<empty;i++)); do printf " "; done
    printf "%b" "] %3d%%\r" $(( (step * 100) / width ))
    sleep 0.008
    step=$((step + 1))
  done
  printf "\n"
  sleep 0.08
}

read -r -d '' FALLBACK <<'EOF'

⠀⠀⠀⠈⠉⠉⠉⠉⠉⠉⠉⠉⠙⠛⠛⠛⠛⠛⠻⠿⠷⠶⢶⣶⣶⣤⣤⣤⣄⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠛⠛⠛⠛⠛⠿⠿⣿⣶⣶⣶⣶⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠛⠻⠿⣿⣷⣦⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣀⣀⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣄⣀⣀⣈⣉⠛⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⣀⣀⣤⣤⣴⠶⠶⠿⠿⠛⠛⠛⠛⠛⠋⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠛⠛⠛⠛⠻⠿⠧⢸⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⣤⣤⠶⠶⠟⠛⠛⠋⠉⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣤⣤⣤⣤⣴⣶⣶⡎⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣠⣤⣴⣶⣶⣿⣿⣿⠿⠿⠿⠿⠟⠛⠛⠓⠘⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣤⣶⣶⣿⠿⠿⠛⠛⠉⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠂⠄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣴⣶⠿⠟⠛⠋⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⣷⣦⣤⣤⣤⣤⣤⣄⣀⣀⠀⠀⠀⠀⠈⠑⠢⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⡶⠿⠛⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣴⣿⣿⣿⣿⠿⠿⠿⠿⢿⣿⣿⣿⣿⣷⣶⣼⣄⠀⢠⠈⠑⢦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⠴⠛⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⡿⠟⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠛⠻⢿⣿⣿⣾⣷⣄⢤⠙⢦⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠄⠊⠁⠀ _____  ___      __ ___ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣿⣿⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⠿⢿⣿⣷⣤⣉⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀   / __ \/   |     / /   |⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⣿⣿⣿⢷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀ / /_/ / /| |__  / / /| |         ⠀⠀⠀⣿⣿⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠻⢿⣿⣷⣿⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀/ _, _/ ___ / /_/ / ___ |⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠻⣿⣦⣄⣀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀/_/ |_/_/  |_\____/_/  |_|⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⠟⠉⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢿⣿⣿⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢿⣿⣿⣷⣤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠻⠿⣿⣿⣿⣿⣿⣶⣶⣶⣶⣶⣶⣶⣶⣦⣤⣤⣤⣤⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠉⠛⠛⠛⠛⠛⠛⠛⠻⠿⠿⢿⣿⣿⣿⣿⣿⠿⢷⣶⣤⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀██╗      ██╗ ███╗   ██╗ ██╗   ██╗ ██╗  ██╗                    ⠀⠀⠀⠀⠀⠀⠈⠉⠛⠿⢿⣶⣤⡉⠙⠻⢷⣦⣄⡀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀ ██║     ███║ ████╗  ██║ ██║   ██║ ╚██╗██╔╝⠀              ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⢿⣦⡄⠀⠈⠙⠿⣦⡀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀██║    ╚ ██║ ██╔██╗ ██║ ██║   ██║  ╚███╔╝                                  ⠀⠀⠀⠙⢿⣦⡀⠀⠀⠈⠻⣦⡀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀██║      ██║ ██║╚██╗██║ ██║   ██║  ██╔██╗⠀⠀⠀⠀⠀⠀                       ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠻⣷⡄⠀⠀⠀⠈⢿⡄⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀███████╗ ██║ ██║ ╚████║ ╚██████╔╝ ██╔╝ ██╗⠀⠀⠀⠀⠀⠀⠀                           ⠀⠀⠀⠀⠀⠙⣿⡄⠀⠀⠀⠀⢻⡄
⠀⠀⠀⠀⠀⠀⠀⠀⠀╚══════╝ ╚═╝ ╚═╝  ╚═══╝  ╚═════╝  ╚═╝  ╚═╝⠀⠀⠀⠀⠀⠀⠀⠀                          ⠀⠀⠀⠀⠀⠀⠘⣿⡀⠀⠀⠀⠀⢣
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀    ⠀⠀⠀⠀⠀⠀⠹⣇⠀⠀⠀⠀⠘
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ⠀⠀ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀    ⠀⠀⠀⠀⠀⠀⠀⢻⡄⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀    ⠀⠀⠀⠀⠀⠀⠀⠈⣇⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ⠀⠀⠀⠀⠀⠀⠀ ⠀⠀⠀⠀⠀⠀⠀    ⠀⠀⠀⠀⠀⠀⠀⠀⢹⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⠀⠀⠀⠀⠀    ⠀⠀⠀⠀⠀⠀⠀⠀⠘ 

EOF

build_banner_text() {
  local text="$1"
  if command -v toilet >/dev/null 2>&1; then
    toilet -f term -F border "$text" 2>/dev/null || toilet "$text" 2>/dev/null
  elif command -v figlet >/dev/null 2>&1; then
    figlet -f slant "$text" 2>/dev/null || figlet "$text" 2>/dev/null
  else
    echo "$FALLBACK"
  fi
}

flicker_print() {
  local txt="$1"; local times=${2:-2}
  for ((r=0;r<times;r++)); do
    printf "%b" "$(fg 236)${txt}${RESET}\r"
    sleep 0.04
    printf "%b" "$(fg 250)${txt}${RESET}\r"
    sleep 0.04
  done
  printf "%b\n" "$txt"
}

matrix_intro() {
  # Optional matrix intro animation code
  return
}

pulse_border() {
  # Optional pulse border animation code
  return
}

boot_messages() {
  # Optional boot messages code
  return
}

draw_shadow() {
  # Optional shadow drawing code
  return
}


# === FANCY TERMINAL PROMPT FUNCTION ===
fancy_prompt() {
  # Yeh prompt sirf dikhane ke liye hai. Commands asli mein run nahi honge.
  # Agar aap exit likhenge, toh yeh prompt band ho jayega.
  local username="u0_a326"
  local host="termux"
  local colors_user=(196 202 208 214)     # Red to Yellow gradient
  local colors_host=(46 82 118 154)      # Green to Cyan gradient
  local arrow_colors=(196 202 208 46)   # Arrows rainbow
  local idx=0
  local typing_speed=0.005 # Typing speed thodi fast ki

  printf "\n%b" "${BOLD}Fancy Prompt shuru ho raha hai (rukne ke liye 'exit' likhein)...${RESET}\n"

  while true; do
    # Prompt ke rangon ko banayein
    local user_col=${colors_user[$((idx % ${#colors_user[@]}))]}
    local host_col=${colors_host[$((idx % ${#colors_host[@]}))]}
    local arrow_col=${arrow_colors[$((idx % ${#arrow_colors[@]}))]}
    local dim_arrow_col=240 # Greyish color for separation

    # --- PROMPT DISPLAY ---
    printf "%b" "$(fg 196)╭─["
    printf "%b" "$(fg $user_col)$username"
    printf "%b" "$(fg $dim_arrow_col)@$RESET" # @ sign ko dim kiya
    printf "%b" "$(fg $host_col)$host"
    printf "%b" "$(fg 196)]"
    printf "%b" "~"
    printf "%b" "\n" # Prompt ko next line mein shuru kiya
    # Arrows ko zyada stylized kiya
    printf "%b" "$(fg $arrow_col)╰𓏵𓍯𓂃𓏵─▶ ${RESET}" 

    # User ka input padhein
    IFS= read -r input

    if [ "$input" = "exit" ]; then
        printf "\n%b\n" "${DIM}Fancy Prompt band ho raha hai...${RESET}"
        break
    fi

    # Animated typing ka dikhawa
    # Cursor ko wapas prompt line ki shuruat mein le jao
    printf "\r"
    # Prompt ko dobara print karein (ab tak ka input wahan hai)
    printf "%b" "$(fg 196)╭─["
    printf "%b" "$(fg $user_col)$username"
    printf "%b" "$(fg $dim_arrow_col)@$RESET"
    printf "%b" "$(fg $host_col)$host"
    printf "%b" "$(fg 196)]"
    printf "%b" "~"
    printf "%b" "\n"
    printf "%b" "$(fg $arrow_col)╰─▶ ${RESET}"
    
    # Input ko animatedly print karein
    for ((i=0;i<${#input};i++)); do
      ch="${input:i:1}"
      color=${arrow_colors[$(( (idx+i) % ${#arrow_colors[@]} ))]}
      printf "%b" "$(fg $color)$ch${RESET}"
      sleep $typing_speed
    done
    
    # Blinking Cursor Effect
    printf "%b" "$(fg 226)${BOLD}█${RESET}\r" # Cursor dikhaya
    sleep 0.1
    printf " \r" # Cursor chhupaya
    sleep 0.1
    printf "%b" "$(fg 226)${BOLD}█${RESET}" # Cursor dobara dikhaya
    
    # Command execution ka simulated output (sirf dikhawa)
    printf "\n"
    if [ ! -z "$input" ]; then
        printf "%b" "$(fg 245)${DIM}┌─${RESET}$(fg 250)${BOLD}Output for:${RESET} $(fg 82)${input}${RESET}\n" # Output styling
        printf "%b" "$(fg 245)└─${RESET}$(fg 240)Command executed successfully (simulation).${RESET}\n"
    fi

    idx=$((idx+1))
  done
}
# === MAIN FLOW ===
clear
progress_bar
matrix_intro
pulse_border
printf "%b" "${DIM}${BOLD}Initializing...${RESET}\n"
sleep 0.12
boot_messages

BANNER="$(build_banner_text LINUX)"
IFS=$'\n' read -rd '' -a LINES <<<"$BANNER" || true

cols=$(get_cols)
box_width=0
for l in "${LINES[@]}"; do [ ${#l} -gt $box_width ] && box_width=${#l}; done
box_pad=6
total_width=$((box_width + box_pad))
left_pad=0
[ "$CENTER_TEXT" -eq 1 ] && left_pad=$(( (cols - total_width) / 2 ))
[ $left_pad -lt 0 ] && left_pad=0

# top border
printf "%b" "$(printf '%*s' $left_pad '')"
printf "%b" "$(fg 39)╔"
for ((i=0;i<total_width-2;i++)); do printf "═"; done
printf "╗${RESET}\n"

# banner lines
for i in "${!LINES[@]}"; do
  line="${LINES[$i]}"
  padding_left=$(( (total_width - ${#line}) / 2 - 1 ))
  padding_right=$(( total_width - ${#line} - padding_left - 2 ))
  printf "%b" "$(printf '%*s' $left_pad '')"
  printf "%b" "$(fg 240)║${RESET} "
  type_line_colored "$(printf '%*s' $padding_left '')${line}$(printf '%*s' $padding_right '')" $((i*2))
  printf "%b" "$(printf '%*s' $left_pad '')"
  printf "%b" "$(fg 240)║${RESET}\n"
done

# bottom border
printf "%b" "$(printf '%*s' $left_pad '')"
printf "%b" "$(fg 226)╚"
for ((i=0;i<total_width-2;i++)); do printf "═"; done
printf "╝${RESET}\n"
sleep $BANNER_DELAY

# Footer with Owner/GitHub/WhatsApp
footer_lines=(
  "$(fg 82)⟡${RESET} ${BOLD}Host:${RESET} Termux on Android"
  "$(fg 118)☺${RESET} ${BOLD}User:${RESET} $(whoami 2>/dev/null || echo 'termux')"
  "$(fg 154)⚙${RESET} ${BOLD}Mode:${RESET} $(uname -o 2>/dev/null || echo 'Android')"
  "$(fg 39)★${RESET} ${BOLD}Owner:${RESET} $OWNER_NAME"
  "$(fg 202)🐱${RESET} ${BOLD}GitHub:${RESET} $GITHUB_LINK"
  "$(fg 46)💬${RESET} ${BOLD}WhatsApp Channel:${RESET} $WHATSAPP_CHANNEL"
  "${DIM}This is a decorative banner — use responsibly.${RESET}"
)
for f in "${footer_lines[@]}"; do center_line "$f"; done

# ==============================
# AUTOMATIC TERMUX PACKAGE INSTALLER
PKGS=(git curl wget python nodejs figlet toilet)
printf "\n%b" "${BOLD}Checking & installing selected Termux packages (if missing)...${RESET}"
for pkg in "${PKGS[@]}"; do
  if ! dpkg -s "$pkg" >/dev/null 2>&1; then
    printf "%b\n" "-> Installing $pkg ..."
    pkg install -y "$pkg"
  else
    printf "%b\n" "-> $pkg already installed."
  fi
done
printf "%b\n" "${DIM}Package check complete.${RESET}"
# ==============================

# WhatsApp auto-launch (Android Termux)
if command -v am >/dev/null 2>&1; then
  printf "\n%b" "${BOLD}${UNDER}Opening WhatsApp channel...${RESET}\n"
  am start -a android.intent.action.VIEW -d "$WHATSAPP_CHANNEL" 2>/dev/null || true
  printf "%b\n" "If WhatsApp didn't open automatically, please join manually: $WHATSAPP_CHANNEL"
fi

printf "\n"
# Fancy prompt ko yahan call kiya gaya hai
fancy_prompt

# Jab fancy_prompt se 'exit' type karke bahar aayenge, tab yeh command run hoga.
clear
# Script khatam
