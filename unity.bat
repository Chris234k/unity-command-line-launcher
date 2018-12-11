@echo off

REM To debug with visual studio the Unity executable must be named "Unity.exe"
REM So this batch file handles finding the appropriate exe, based on folder name.

REM Folder structure should look something like
REM unity_base_path/[Version Number]/Editor/unity.exe
REM ---- OR ----
REM unity_base_path/[Version Number]/Editor/Unity/unity.exe

REM NOTE(chris) necessary for using the 'version' variable to be set during the IF statement
setlocal enabledelayedexpansion

set unity_base_path=C:\Program Files\Unity Versions

IF "%1"=="" (
    echo Available commands:
    echo    ls -- List the available versions of Unity
    echo    auto -- Launch the version of Unity specified in {CURRENT_DIR}/ProjectSettings/ProjectVersions.txt
    
    GOTO END
) ELSE IF "%1"=="ls" ( REM Print directory contents, folders only
    echo %unity_base_path%
    dir /a:d /b "%unity_base_path%"
    
    GOTO END
) ELSE IF "%1"=="auto" ( REM Detect the Unity version found in the {CURRENT_DIRECTORY}/ProjectSettings/ProjectVersion.txt and match it to one of our versions
    REM NOTE(chris) 'auto' will not work with Unity versions below 5.0.0, because ProjectSettings/ProjectVersions.txt DOES NOT EXIST YET
    
    REM Load the contents of ProjectVersion.txt into a variable
    REM NOTE(chris) ProjectVersion.txt file looks like: "m_EditorVersion: 2018.2.6f1"
    set /p text=<%cd%\ProjectSettings\ProjectVersion.txt
    echo Read file:'%cd%\ProjectSettings\ProjectVersion.txt'

    REM 'm_EditorVersion: ' is 17 characters, so we substring to get the actual version number
    REM 'version' is the variable used when calling :DETECT_FOLDER so we set it and proceed as we would if the user typed:
    REM 'unity 2018.2.6f1'
    set version=!text:~17!
    echo Detected Version: !version!
    
    REM TODO TODO TODO(chris) at this point we may as well pass an argument to unity.exe to launch the folder as well
    GOTO DETECT_FOLDER
) ELSE ( REM an argument has been passed in, and it's not one of the other commands; so we assume it is a version number -- i.e. 'unity 2018.2.6f1'
    set version=%1
    GOTO DETECT_FOLDER
)

:DETECT_FOLDER
set unity_path="%unity_base_path%\!version!\Editor\Unity.exe"

IF EXIST %unity_path% GOTO LAUNCH_UNITY
set unity_path="%unity_base_path%\!version!\Unity\Editor\Unity.exe"

:LAUNCH_UNITY
echo %unity_path%
start "" %unity_path%
goto END

:END
