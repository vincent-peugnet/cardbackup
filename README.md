```
 _____               _  ______            _      _   _        
/  __ \             | | | ___ \          | |    | | | |       
| /  \/ __ _ _ __ __| | | |_/ / __ _  ___| | __ | | | |_ __   
| |    / _` | '__/ _` | | ___ \/ _` |/ __| |/ / | | | | '_ \  
| \__/\ (_| | | | (_| | | |_/ / (_| | (__|   <  | |_| | |_) | 
 \____/\__,_|_|  \__,_| \____/ \__,_|\___|_|\_\  \___/| .__/  
2020                                                  | |     
                                                      |_|     

```

![language badge](https://img.shields.io/github/languages/top/vincent-peugnet/cardbackup?color=green)

Card BackUp is the only good thing that came up in 2020.

It's an experiment : to have an open source and linux software to manage backup for audiovisual projects.

As backup is a critical step in any production, I don't think this could be serious to use it on any important project at this early stage of devellopement. But maybe, concider using it as a parallel solution to try when everything is already secure.

## Interface

Don't expect any GUI fancy button, CBU is an __nteractive Script__ in a __beautifull CLI__ :) But don't worry, there is no needs for any skills in linux bash or anything else, most of the time, the script will ask you for yes or no, name choosing, or open your browser to let you choose a directory.

## Dependencies

- rsync
- mediainfo
- ffmpeg
- tree
- latex
- coreutils


## How to use it

1. dowload the folder, unzip it and open it in a terminal
2. install dependencies on debian and derivatives:
    ```
    sudo apt install rsync mediainfo ffmpeg tree texlive
    ```
3. install cardbackup:
    ```
    sudo make install
    ```
4. run it:
    ```
    cardbackup
    ```
5. follow the step inside the program

## What does CardBackup actually do ?

When you launch the script, it will ask you to choose a removable device to copy.

Then you'll have to choose a back-up destination on your computer or external drives.

Afterwhat you can choose a folder name to put the card in.

Then CBU will copy your files and compare MD5 checksums.

A summary of the copy is displayed in your shell, indicating which files were copied or any errors that occured.

It will analyse the copied card using mediainfo to create a little log and take some screenshots of the video files. A PDF is generated containing media infos of files and 3 screens per video file.


## To Do

- Add the ability to create Preset for projects
- Send the report pdf by email