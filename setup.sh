#!/bin/bash

# 2/25/2022 Maintainer script 

# Author:  2730246+devsecfranklin@users.noreply.github.com 


#Black        0;30     Dark Gray     1;30
#Red          0;31     Light Red     1;31
#Green        0;32     Light Green   1;32
#Brown/Orange 0;33     Yellow        1;33
#Blue         0;34     Light Blue    1;34
#Purple       0;35     Light Purple  1;35
#Cyan         0;36     Light Cyan    1;36
#Light Gray   0;37     White         1;37

RED='\033[0;31m'
LRED='\033[1;31m'
LGREEN='\033[1;32m'
CYAN='\033[0;36m'
LPURP='\033[1;35m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

MY_OS="unknown"

function detect_os() {
    if [ "$(uname)" == "Darwin" ]
    then
        echo -e "${CYAN}Detected MacOS${NC}"
        MY_OS="mac"
    elif [ -f "/etc/redhat-release" ]
    then
        echo -e "${CYAN}Detected Red Hat/CentoOS/RHEL${NC}"
        MY_OS="rh"
    elif [ "$(grep -Ei 'debian|buntu|mint' /etc/*release)" ]
    then
        ID="$(grep -Ei '^ID=' /etc/os-release| cut -d"=" -f2)"
        echo -e "${CYAN}Found Linux: ${ID}${NC}"
        echo -e "${CYAN}Detected Debian/Ubuntu/Mendel/Mint${NC}"
        MY_OS="deb"
    elif grep -q Microsoft /proc/version
    then
        echo -e "${CYAN}Detected Windows pretending to be Linux${NC}"
        MY_OS="win"
    else
        echo -e "${YELLOW}Unrecongnized architecture.${NC}"
        exit 1
    fi
}

#function kicad_theme {

  # Dracula theme: [Original is here](https://draculatheme.com/kicad)
  # Drop the file kicad/dracula.json into the following color themes directory:

  # Linux: `~/.config/kicad/VERSION/colors`
  # Windows Vista & later: `“C:\Users\username\AppData\Roaming” + kicad (= %APPDATA%\kicad) + "VERSION/colors"`
  # OSX: `~/Library/Preferences/kicad/6.0/colors`

#}

# function get_kicad_version {

function debian {

  # Install KiCad
  #sudo add-apt-repository --yes ppa:kicad/kicad-6.0-releases
  #sudo apt update
  #sudo apt install --install-recommends kicad

  echo -e "${CYAN}Copying modules to /usr/share/kicad...${NC}"
  sudo cp -Rp modules /usr/share/kicad

  # Install KiBot
  if [ -d "KiBot" ]; then
    echo -e "${CYAN}Found Clone of KiBot Repo... skipping${NC}"
  else
    echo -e "${CYAN}Found Cloning KiBot Repo...${NC}"
    git clone git@github.com:INTI-CMNB/KiBot.git
    echo -e "${CYAN}Installing KiBot${NC}"
    cd KiBot && pip3 install --user -e .
  fi

  # KiCad Action tools
  # https://github.com/easyw/kicad-action-tools

  if [ -f "~/.config/kicad/6.0/colors/dracula.json" ]; then
    echo -e "${CYAN}Dracula Theme Installed${NC}"
  else
    echo -e "${CYAN}Installing Dracula Theme for KiCad${NC}"
    cp docs/theme/dracula.json ~/.config/kicad/6.0/colors
  fi

}


function main() {
  detect_os
  if [ "${MY_OS}" == "mac" ]; then
    macos
  fi
  if [ "${MY_OS}" == "rh" ]; then
    redhat
  fi
  if [ "${MY_OS}" == "deb" ]; then
    debian
  fi

}

main
