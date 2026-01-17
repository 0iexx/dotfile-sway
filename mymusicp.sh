#!/usr/bin/bash
clear
ascii_logo='
                  @@@@               __  ___         _       ___  __
           @@@@@@@@@@@              /  |/  /_ _____ (_)___  / _ \/ /__ ___ _____ ____
       @@@@@@@@@@@@@@@             / /|_/ / // (_-</ / __/ / ___/ / _ `/ // / -_) __/
       @@@@@@@@@@@@  @            /_/  /_/\_,_/___/_/\__/ /_/  /_/\_,_/\_, /\__/_/
       @@@@          @                                                /___/
       @@            @
       @@       @@@@@@
       @@     @@@@@@@@                               By DIEX 
  @@@@@@@     @@@@@@@@
 @@@@@@@@      @@@@@@
 @@@@@@@@
  @@@@@

'
echo "$ascii_logo" | lolcat -a -p 3.0 -F 0.05 -s 20 -d 5 -S 50

type_text() {
    local text="$1"
    local delay=0.04

    for ((i=0; i<${#text}; i++)); do
        printf "%s" "${text:i:1}"
        sleep "$delay"
    done
    echo
}
type_text "Press Enter To Start !" | lolcat -p 5.0 -F 0.05 -S 65

    read
for i in {1..5}; do
    for j in {1..3}; do
        printf "\r  Starting NCMPCPP"
        for ((k=1; k<=j; k++)); do
            printf "."
        done
        sleep 0.1
    done
done
echo

ncmpcpp
