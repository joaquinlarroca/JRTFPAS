@echo off
setlocal

set "WORKING_DIR=%~dp0"
set "PASCAL=fpc"
set "OUT_DIR=output"
set "FLAGS=-FE%OUT_DIR% -Co -Cr -Miso -gl"

if "%~1"=="" (
    echo Error: You must provide a filename.
    echo Usage: %~nx0 ^<filename^>
    exit /b 1
)

cd /d "%WORKING_DIR%"
set "BASENAME=%~n1"

for /f %%i in ('wsl wslpath -a "%WORKING_DIR%"') do set "WSL_DIR=%%i"

wsl bash -lc "cd '%WSL_DIR%' && mkdir -p '%OUT_DIR%' && if %PASCAL% %FLAGS% '%BASENAME%.pas'; then echo '' && echo 'Running %BASENAME%.pas...' && echo '' && echo 'Output:' && './%OUT_DIR%/%BASENAME%' && rm -r './%OUT_DIR%'; else echo 'Compilation failed.' >&2; exit 1; fi"
