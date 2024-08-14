#!/bin/bash

clear

echo " _____                       "
echo "|  _  \                      "
echo "| | | |___   ___  _ __ ___   "
echo "| | | / _ \ / _ \| '_ \` _ \ "
echo "| |/ / (_) | (_) | | | | | | "
echo "|___/ \___/ \___/|_| |_| |_| "

echo ""
echo "You are about to run GZDoom. Are you sure you want to run it? (y/n)"
echo ""

read -p "Your choice: " choice

if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
    echo "Checking if Flatpak is installed..."

    # Check if Flatpak is installed
    if command -v flatpak > /dev/null 2>&1; then
        echo "Flatpak is installed. Checking if GZDoom is installed..."
    else
        echo "Flatpak is not installed. Installing Flatpak..."

        # Install Flatpak based on the Linux distribution
        if [ -f /etc/debian_version ]; then
            sudo apt-get update
            sudo apt-get install -y flatpak
        elif [ -f /etc/redhat-release ]; then
            sudo dnf install -y flatpak
        elif [ -f /etc/arch-release ]; then
            sudo pacman -Syu --noconfirm flatpak
        else
            echo "Unsupported distribution. Please install Flatpak manually."
            exit 1
        fi

        if [[ $? -ne 0 ]]; then
            echo "Failed to install Flatpak. Exiting..."
            exit 1
        fi

        echo "Flatpak installed successfully. Proceeding..."
    fi

    sleep 1

    echo "Checking if GZDoom is installed..."

    if flatpak info org.zdoom.GZDoom > /dev/null 2>&1; then
        echo "GZDoom is installed. Proceeding..."
        sleep 1
    else
        echo "GZDoom is not installed. Installing via Flatpak..."
        sleep 1

        flatpak install -y flathub org.zdoom.GZDoom

        if [[ $? -ne 0 ]]; then
            echo "Failed to install GZDoom. Exiting..."
            exit 1
        fi
        
        echo "GZDoom installed successfully. Proceeding..."
    fi

    sleep 1

    read -p "Enter the full path to the PWAD file (or leave blank to skip): " pwad

    if [[ -n "$pwad" ]]; then
        echo "Running GZDoom with PWAD..."
        sleep 1
        flatpak run org.zdoom.GZDoom -file "$pwad"
    else
        echo "Running GZDoom without PWAD..."
        sleep 1
        flatpak run org.zdoom.GZDoom
    fi

elif [[ "$choice" == "n" || "$choice" == "N" ]]; then
    echo "Exiting..."
    exit 0
else
    echo "Invalid choice. Exiting..."
    exit 1
fi
