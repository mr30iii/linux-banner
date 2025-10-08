# 🐧 Linux Banner Enhanced for Termux

![Termux Banner](https://img.shields.io/badge/Termux-Linux%20Banner-brightgreen)
![License](https://img.shields.io/badge/License-MIT-blue)
![Platform](https://img.shields.io/badge/Platform-Android%20(Termux)-yellowgreen)

💻 **Give your Termux terminal a stylish, hacker-style look!**  
Animated banner, matrix intro, pulse borders, fancy prompts, and owner info — all in one!

---

## 🌟 Features

✨ **Banner & Effects**
- 🎨 Gradient colored banner (rainbow, teal, sunset, green)
- 🔹 Optional shadow and centering
- ⏳ Progress bar during startup
- 🖤 Matrix-style intro
- 💫 Pulse border animation
- 🔊 Optional beep sounds

💻 **Fancy Terminal Prompt**
- 🌈 Rainbow user & host
- ✨ Animated typing effect
- 🔹 Blinking cursor
- ⚡ Simulated command output

📌 **Footer & Info**
- 🧑 Owner name
- 🐱 GitHub link
- 💬 WhatsApp channel
- 📦 Automatic package check & install
- 📲 Auto-launch WhatsApp channel (Android Termux)

---

## 🛠 Requirements

- Termux on Android  
- Bash (`#!/data/data/com.termux/files/usr/bin/bash`)  
- Optional: `figlet` or `toilet` for fancy ASCII banner fonts  
- Script auto-installs missing packages: `git`, `curl`, `wget`, `python`, `nodejs`, `figlet`, `toilet`

---

## 🚀 Installation & Run

1️⃣ Clone the repo:

```bash
git clone https://github.com/mr30iii/linux-banner.git
cd linux-banner
chmod +x linux_banner_enhanced.sh
./linux_banner_enhanced.sh
