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

# Handle user input
if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
    echo "Checking if Flatpak GZDoom is installed..."

    # Check if Flatpak GZDoom is installed
    if flatpak info org.zdoom.GZDoom > /dev/null 2>&1; then
        echo "GZDoom is installed. Proceeding..."
    else
        echo "GZDoom is not installed. Installing via Flatpak..."
        
        flatpak install flathub org.zdoom.GZDoom

        if [[ $? -ne 0 ]]; then
            echo "Failed to install GZDoom. Exiting..."
            exit 1
        fi
        
        echo "GZDoom installed successfully. Proceeding..."
    fi
sleep 1

    read -p "Enter the full path to the PWAD file (or leave blank to skip): " pwad

    # Check if a PWAD was provided
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


    exit 1
fi
