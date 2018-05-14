@echo off

REM To debug with visual studio the Unity executable must be named "Unity.exe"
REM So this batch file handles finding the appropriate exe, based on folder name.

REM Folder structure should look something like
REM unity_base_path/[Version Number]/Editor/unity.exe
REM ---- OR ----
REM unity_base_path/[Version Number]/Editor/Unity/unity.exe

set unity_base_path=C:\Program Files (x86)\Unity Versions

IF "%1"=="" GOTO END
IF "%1"=="versions" GOTO PRINT_VERSIONS

set version=%1
set unity_path="%unity_base_path%\%version%\Editor\Unity.exe"

IF EXIST %unity_path% GOTO LAUNCH_UNITY
set unity_path="%unity_base_path%\%version%\Unity\Editor\Unity.exe"


:LAUNCH_UNITY
echo %unity_path%
start "" %unity_path%
goto END


:PRINT_VERSIONS
REM Print directory contents, folders only
echo %unity_base_path%
dir /a:d /b "%unity_base_path%"

:END
