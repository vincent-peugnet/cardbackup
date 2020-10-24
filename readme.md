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

Card BackUp is the only good thing that came up in 2020.

It's an experiment : to have an open source and linux software to manage backup for audiovisual projects.

As backup is a critical step in any production, I don't think this could be serious to use it on any important project at this early stage of devellopement. But maybe, concider using it as a parallel solution to try when everything is already secure.

## Dependencies

- rsync
- mediainfo
- ffmpeg
- tree


## How to use it

1. dowload the folder
2. install dependencies using following line on debian and derivated distributions
    ```
    sudo apt install rsync mediainfo ffmpeg tree
    ```
3. open the terminal in the folder, then type the following
    ```
    ./cardbackup.sh
    ```
4. follow the step inside the program