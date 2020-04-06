@echo off

REM Folder structure should look something like
REM unity_base_path/[Version Number]/Editor/unity.exe
REM ---- OR ----
REM unity_base_path/[Version Number]/Editor/Unity/unity.exe

REM NOTE(chris) necessary for the 'version' variable to be set inside the scope of an IF statement
setlocal enabledelayedexpansion

set unity_base_path=C:\PROGRA~2\Unity Versions

IF "%1"=="" (
    echo Available commands:
    echo    versions -- List the available versions of Unity
    echo    launch -- Launch the version of Unity specified in {CURRENT_DIR}/ProjectSettings/ProjectVersions.txt
    
    GOTO END
) ELSE IF "%1"=="versions" ( REM Print directory contents, folders only
    echo %unity_base_path%
    dir /a:d /b "%unity_base_path%"
    
    GOTO END
) ELSE IF "%1"=="launch" ( REM Detect the Unity version found in the {CURRENT_DIRECTORY}/ProjectSettings/ProjectVersion.txt and match it to one of our versions
    REM 'launch' will not work with Unity versions below 5.0.0, because ProjectSettings/ProjectVersions.txt DOES NOT EXIST YET
	
	IF "%2"=="version" ( REM user specifies a version ('unity launch version 2018.4f1')
		set version=%3
		echo Set Version: !version!
	) ELSE (
		REM Load the contents of ProjectVersion.txt into a variable
		REM ProjectVersion.txt file looks like: "m_EditorVersion: 2018.2.6f1"
		set /p text=<%cd%\ProjectSettings\ProjectVersion.txt
		echo Read file:'%cd%\ProjectSettings\ProjectVersion.txt'
		
		REM 'm_EditorVersion: ' is 17 characters, so we substring to get the actual version number
		REM 'version' is the variable used when calling :FIND_EDITOR so we set it and proceed as we would if the user typed:
		REM 'unity 2018.2.6f1'
		set version=!text:~17!
		echo Detected Version: !version!
	)
	
	REM "-projectPath" tells unity to skip the project picker dialog and open a project at the given path (we're using the current directory)
	REM https://docs.unity3d.com/Manual/CommandLineArguments.html
	set projectPath=-projectPath "%cd%"
	
    GOTO FIND_EDITOR
) ELSE ( REM an argument has been passed in, and it's not one of the other commands; so we assume it is a version number -- i.e. 'unity 2018.2.6f1'
    set version=%1
    GOTO FIND_EDITOR
)

:FIND_EDITOR
REM Unity seems to have 2 different folder structures (I believe this changed somewhere in 2017 or 2018)
set unity_path="%unity_base_path%\!version!\Editor\Unity.exe"
IF EXIST %unity_path% GOTO LAUNCH_UNITY
set unity_path="%unity_base_path%\!version!\Unity\Editor\Unity.exe"

:LAUNCH_UNITY
echo %unity_path% !projectPath!
start "" %unity_path% !projectPath!
goto END

:END
