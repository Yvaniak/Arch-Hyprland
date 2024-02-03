#!/bin/bash
# 💫 https://github.com/JaKooLit 💫 #
# Hyprland-Dots to download from Releases #
if [[ $USE_PRESET = [Yy] ]]; then
  source ./preset.sh
fi

## WARNING: DO NOT EDIT BEYOND THIS LINE IF YOU DON'T KNOW WHAT YOU ARE DOING! ##

source "$(dirname "$(readlink -f "$0")")/Global_functions.sh"

printf "${NOTE} Downloading / Checking for existing Hyprland-Dots.tar.gz...\n"

# Check if Hyprland-Dots.tar.gz exists
if [ -f Hyprland-Dots ]; then
  rm -r Hyprland-Dots
fi

printf "${NOTE} Downloading the latest Hyprland commit...\n"

# Download the latest release source code tarball to the current directory
if git clone "git@github.com:Yvaniak/Hyprland-Dots.git"; then
  cd "Hyprland-Dots" || exit 1

  # Set execute permission for copy.sh and execute it
  chmod +x copy.sh
  ./copy.sh 

  echo -e "${OK} dots installed successfully" 2>&1 | tee -a "../Install-Logs/install-$(date +'%d-%H%M%S')_dotfiles.log"
else
  echo -e "${ERROR} Failed to download the latest commit." 2>&1 | tee -a "../Install-Logs/install-$(date +'%d-%H%M%S')_dotfiles.log"
  exit 1
fi

if [ -f Dots ]; then
  cd Dots
  stow .
else
  git clone "git@codeberg.org:Yvaniak/Dots.git"
  cd Dots
  stow .
fi



clear
