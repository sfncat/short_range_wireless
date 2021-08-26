@echo off
logman stop "bth_hci" -ets
if %errorLevel% == 0 (
    echo stop success.
else(
    echo stop failed.
    exit(1)
)
call convert_log.bat