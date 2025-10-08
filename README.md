# 🐧 Linux Banner Enhanced for Termux

![Termux Banner](https://img.shields.io/badge/Termux-Linux%20Banner-brightgreen)

**Enhanced Termux Banner** script for a stylish, animated, hacker-style terminal experience. Includes owner info, GitHub, WhatsApp, and a fancy simulated prompt.

---

## 🌟 Features

- 🎨 Animated **banner** with gradient colors
- ⏳ Optional **progress bar** on startup
- 🖤 **Matrix-style intro** and **boot messages**
- 💫 **Pulse border** animation around the banner
- 🔊 Optional **sound beeps**
- 💻 Fancy terminal prompt with:
  - 🌈 Rainbow-colored user & host
  - ✨ Animated typing simulation
  - 🔹 Blinking cursor effect
  - ⚡ Simulated command output
- 📌 Footer displaying:
  - 🧑 Owner name
  - 🐱 GitHub link
  - 💬 WhatsApp channel
- 📦 Automatic check & install of required Termux packages:
  - `git`, `curl`, `wget`, `python`, `nodejs`, `figlet`, `toilet`
- 📲 Auto-launch WhatsApp channel (on Android Termux)

---

## 💻 Requirements

- Termux on Android
- Bash (`#!/data/data/com.termux/files/usr/bin/bash`)
- Optional: `figlet` or `toilet` for ASCII banner fonts
- Script auto-installs missing packages

---

## 🛠 Installation

1. Clone the repository:

```bash
git clone https://github.com/mr30iii/linux-banner.git
cd linux-banner
chmod +x linux_banner_enhanced.sh
./linux_banner_enhanced.sh
