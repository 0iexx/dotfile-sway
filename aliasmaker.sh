#!/usr/bin/bash

echo -e "\e[36m"
cat << "EOF"
   ___   ___            __  ___     __          
  / _ | / (_)__ ____   /  |/  /__ _/ /_____ ____
 / __ |/ / / _ `(_-<  / /|_/ / _ `/  '_/ -_) __/
/_/ |_/_/_/\_,_/___/ /_/  /_/\_,_/_/\_\\__/_/   
EOF
echo -e "\e[0m"
echo

read -p "Alias name: " alias_name
if [[ -z "$alias_name" ]]; then
    echo "❌ No alias name provided. Aborting."
    exit 1
fi

read -p "Command to execute: " alias_cmd
if [[ -z "$alias_cmd" ]]; then
    echo "❌ No command provided. Aborting."
    exit 1
fi

echo
echo "This will create the following alias:"
echo -e "➡️  alias \e[33m$alias_name\e[0m='\e[32m$alias_cmd\e[0m'"
echo
read -p "Add this alias to ~/.zshrc ? (y/n): " confirm

if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
    echo -e "\n# Added by Alias Maker - $(date)" >> ~/.zshrc
    echo "alias $alias_name='$alias_cmd'" >> ~/.zshrc
    echo -e "\n✅ Alias added successfully!"
    echo "Reload your shell or run:  source ~/.zshrc"
else
    echo "🚫 Operation canceled."
fi
