# Unity Command Line Launcher
Launch Unity versions via command line


# Setup (Windows only)
1. Download the unity.bat file (referred to as "batch file" from here on out)
2. Create a directory containing all your Unity versions. The name of the folder will be what you type to launch its executable.
    - I recommend something like:
    ```
    +-- C:\
        +-- Program Files (x86)
            +-- Unity Versions
            |   +-- 4.7.2f1
            |   +-- 5.3.4
            |   +-- 2017.1.1
            |   +-- ... etc
     ```
3. Put the batch file where ever you prefer. I recommend the same directory as above.
4. Add the batch file [to your path](https://www.howtogeek.com/118594/how-to-edit-your-system-path-for-easy-command-line-access/)
5. Edit the batch file, change the "unity_base_path" to the directory containing your Unity versions
    - Look for this line in the file:
        - set unity_base_path=C:\Program Files (x86)\Unity Versions    <--- Edit text after the equals sign (=)

# Usage
- Open up your favorite console emulator. Since the batch file is on our path, and is named "unity.bat" we're able to type:
    - \> unity versions
        - A list of all folders in your unity_base_path directory. Sample output: 
            >C:\Program Files (x86)\Unity Versions  
            2017.1  
            2017.3  
            2018.1  
            4.7.2f1  
            5.3.4  
            5.4.0  
            5.5.0  
            5.6.3f1  
            5.6.5f1
    - \> unity 5.6.5f1
        - Opens the Unity version in the folder matching the version provided. Sample output:
            >"C:\Program Files (x86)\Unity Versions\5.6.5f1\Editor\Unity.exe"
                
