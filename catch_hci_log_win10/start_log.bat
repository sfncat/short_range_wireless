@echo off
goto not_need_admin

:check_admin_permission
    echo administrator permission required. detecting...
    net session >nul 2>&12
    if %errorLevel% == 0 (
        echo success:administrator permissions confirmed.
    else (
        echo failure: need administrator permission.
    )
:not_need_admin

set log_folder=hci_log
if not exist %log_folder% (
    mkdir %log_folder%
)
set log_file=%~dp0%log_folder%\bth_hci.etl
logman create trace "bth_hci" -ow -o %log_file% -p {8a1f9517-3a8c-4a9e-a018-4f17a200f277} 0xffffffffffffffff 0xff -nb 16 16 -bs 1024 -mode Circular -f bincirc -max 4096 -ets
if %errorLevel%==0 (
    echo start success,call stop_log.bat to stop
)