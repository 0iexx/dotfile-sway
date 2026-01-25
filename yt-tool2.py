#!/usr/bin/env python3
import os
import subprocess
import sys
import shutil
import termcolor
from termcolor import colored


def get_width():
    return shutil.get_terminal_size().columns

def print_centered(text, color=None, attrs=None):
    width = get_width()
    lines = text.strip().split('\n')
    for line in lines:
        centered_line = line.strip().center(width)
        if color:
            print(colored(centered_line, color, attrs=attrs))
        else:
            print(centered_line)

def print_ascii_art_centered(art, color="cyan"):
    width = get_width()
    lines = art.strip("\n").split("\n")
    
    max_art_width = 0
    for line in lines:
        if len(line) > max_art_width:
            max_art_width = len(line)
    
    padding = (width - max_art_width) // 2
    
    for line in lines:
        padded_line = " " * padding + line
        print(colored(padded_line, color))

def input_centered(prompt_text, color="yellow"):
    width = get_width()
    clean_text = prompt_text.strip()
    padding = (width - len(clean_text) - 2) // 2 
    final_prompt = " " * padding + colored(clean_text, color) + " "
    return input(final_prompt)

def check():
    try:
        subprocess.run(["yt-dlp", "--version"], check=True, stdout=subprocess.DEVNULL)
        subprocess.run(["ffmpeg", "-version"], check=True, stdout=subprocess.DEVNULL)
        return True
    except:
        return False

if check() == False :
    print_centered("We found some missing packages.", "red")
    choice_down = input_centered("Would you like to install them automatically? (yes/no) >")
    if choice_down.lower() == "yes" :
        subprocess.run(["sudo", "apt" , "install" ,"yt-dlp" ,  "-y"])
        subprocess.run(["sudo", "apt", "install" , "ffmpeg" , "-y"])
        subprocess.run(["python3" , "-m" , "pip" , "install", "-U" , "termcolor"])
    elif choice_down.lower() == "no" :
        print_centered("Ok, restart the app when done.", "red")
        input_centered("Enter to exit...")
        sys.exit()

print_centered("\n\nAll packages have been found!\n\n" , "green")
input_centered("Enter to continue....")

def show_logo():
    logo = r'''
    (     (            )
     )\ )  )\ )      ( /(
   (()/( (()/( (    )\())
    /(_)) /(_)))\  ((_)\
   (_))_ (_)) ((_) __((_)
    |   \|_ _|| __|\ \/ /
    | |) || | | _|  >  <
    |___/|___||___|/_/\_\
       _____________
      <_____________> ___
      |             |/ _ \
      |               | | |
      |               |_| |
   ___|             |\___/
  /    \___________/    \
  \_____________________/
  
  >> Youtube Download Tool <<
    '''
    print_ascii_art_centered(logo, "cyan")

def get_filename(url):
    try:
        return subprocess.check_output(
            ['yt-dlp', '--get-filename', '-o', '%(title)s.%(ext)s', url],
            text=True
        ).strip()
    except:
        return "Unknown_File"

def after_dow(result):
    if result.returncode == 0:
        print_centered("Success !!!", "green")
    else:
        print_centered("Download failed ", "red")

formats_1 = {
    "1": 'bv*[vcodec^=avc1][height<=2160]+ba[acodec^=mp4a]/b[height<=2160]',  # 4K
    "2": 'bv*[vcodec^=avc1][height<=1440]+ba[acodec^=mp4a]/b[height<=1440]',  # 2K
    "3": 'bv*[vcodec^=avc1][height<=1080]+ba[acodec^=mp4a]/b[height<=1080]',  # 1080p
    "4": 'bv*[vcodec^=avc1][height<=720]+ba[acodec^=mp4a]/b[height<=720]',    # 720p
    "5": 'bv*[vcodec^=avc1][height<=480]+ba[acodec^=mp4a]/b[height<=480]',    # 480p
}

def get_user_music_path():
    return os.path.join(os.path.expanduser('~'), 'Music')

while True :
    os.system("clear")
    show_logo()
    
    print("\n")
    menu_line_1 = "[1] Download Video   [2] Download Playlist   [3] Download Audio"
    menu_line_2 = "[4] Exit             [5] Common Errors       [6] Help"
    
    print_centered(menu_line_1, "yellow")
    print_centered(menu_line_2, "yellow")
    print("\n")

    choice = input_centered("Choose option >", "cyan")

    if choice == "1" or choice == "2":
        is_playlist = (choice == "2")
        
        print("\n")
        print_centered("Quality: [1] 4K | [2] 2K | [3] 1080p | [4] 720p | [5] 480p", "yellow")
        
        quality = input_centered("Select Quality >")
        if quality not in formats_1:
            print_centered("Invalid quality selection!", "red")
            input_centered("Enter to try again...")
            continue
            
        url = input_centered("Paste URL >")
        download_path = input_centered("Save path (leave empty for current dir) >")
        
        if not download_path:
            download_path = "."
        
        if is_playlist:
            output_template = f"{download_path}/%(playlist_title)s/%(title)s.mp4"
            print_centered("Preparing Playlist Download...", "green")
        else:
            output_template = f"{download_path}/%(title)s.mp4"
            print_centered("Preparing Video Download...", "green")

        cmd = [
            "yt-dlp",
            "-f", formats_1[quality],
            "--merge-output-format", "mp4",
            "-o", output_template,
            url
        ]
        
        print_centered("Downloading... Please wait", "cyan")
        try:
            result = subprocess.run(cmd)
            after_dow(result)
        except Exception as e:
            print_centered(f"Error: {e}", "red")
            
        input_centered("Enter to continue...", "red")

    elif choice == "3":
        is_playlist_audio = input_centered("Is this a playlist? (yes/no) >").lower() == "yes"
        url = input_centered("Paste URL >")
        
        music_path = get_user_music_path()
        
        print_centered(f"Saving to: {music_path}", "cyan")
        
        cmd = [
            'yt-dlp',
            '-x',
            '-P', music_path,
            '--audio-format', 'mp3',
            '--audio-quality', '0',
            url
        ]
        
        if is_playlist_audio:
             cmd.extend(['-o', '%(playlist_index)s - %(title)s.%(ext)s'])
        else:
             cmd.extend(['-o', '%(title)s.%(ext)s'])

        print_centered("Downloading Audio...", "cyan")
        result = subprocess.run(cmd)
        after_dow(result)
        input_centered("Enter to continue...", "red")

    elif choice == "4":
        print_centered("Goodbye!", "cyan")
        break
    elif choice == "5":
        os.system("nano errors.txt")
    elif choice == "6":
        os.system("nano help.txt")
    else:
        print_centered("Invalid choice, try again.", "red")
        input_centered("Enter to continue...")
