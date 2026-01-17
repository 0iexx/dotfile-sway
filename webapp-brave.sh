#!/bin/bash
show_header() {
clear
cat << "EOF"
    ____  ___________  __                                         __
   / __ \/  _/ ____/ |/ /   ____ _____  ____     ____ ___  ____ _/ /_____  _____
  / / / // // __/  |   /   / __ `/ __ \/ __ \   / __ `__ \/ __ `/ //_/ _ \/ ___/
 / /_/ // // /___ /   |   / /_/ / /_/ / /_/ /  / / / / / / /_/ / ,< /  __/ /
/_____/___/_____//_/|_|   \__,_/ .___/ .___/  /_/ /_/ /_/\__,_/_/|_|\___/_/
                              /_/   /_/

----------------------------------------------------
EOF
}

pause_and_continue() {
    echo ""
    echo "Enter..."
    read
}


show_header
echo "Enter your app name 󰈆"
read APPNAME

show_header
echo "URL:"
read APPURL

show_header
echo "URL image (PNG/SVG):"
read APPICON

ICON_DIR="$HOME/Pictures/icons/"
mkdir -p "$ICON_DIR"

#extraction imge
EXT="${APPICON##*.}"
ICON_PATH="$ICON_DIR/${APPNAME}.${EXT}"

echo "Downloding icon..."
curl -L "$APPICON" -o "$ICON_PATH"

if [ $? -ne 0 ]; then
    echo "imgae fiald!"
    pause_and_continue
    exit 1
fi

DESKTOP_FILE="$HOME/.local/share/applications/${APPNAME}.desktop"

cat <<EOF > "$DESKTOP_FILE"
[Desktop Entry]
Name=$APPNAME
Exec=brave-browser --app=$APPURL
Terminal=false
Type=Application
Icon=$ICON_PATH
Categories=Network;WebBrowser;
EOF


show_header
echo "Done 󰄳"
echo "$DESKTOP_FILE"
echo ""

pause_and_continue
