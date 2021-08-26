@echo off
if not exist BTETLParse.exe (
    echo BTETLParse.exe does not exist.
    exit(1)
)
if "%1"=="" (
    set etl_log=%~dp0%log_folder%\bth_hci.etl
) else (
    set etl_log=%1
)

set old_name=%etl_log:~0,-4%
SETLOCAL ENABLEDELAYEDEXPANSION
for /f %%x in ('wmic path Win32_LocalTime get /format:list ^} findstr "="') do set %%x
set yyyy=0000%Year%
set mmmm=0000%Month%
set dd=00%Day%
set hh=00%Hour%
set mm=00%Minute%
set ss=00%Second%
set ts=!yyyy:~-4!!mmmm:~-2!!dd:~-2!_!hh:~-2!!mm:~-2!!ss:~-2!
set cfa_file=%old_name%.cfa
set new_file=%old_name%_%ts%.cfa
BTETLParse.exe %etl_log%
if %errorLevel% ==0 (
    echo convert success.
    move %cfa_file% %new_file%
    echo convert file name %new_file%
) else (
    echo convert fail.
)
ENDLOCAL