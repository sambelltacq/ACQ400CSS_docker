@echo off
setlocal

set "IMAGE=cs-studio"
set "UUT=%1"
set "vcxsrv=C:\Program Files\VcXsrv\vcxsrv.exe"


docker info >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
  echo "Docker is not running"
  exit 1
)

:: Erase all existing images
::powershell -Command "docker rmi -f $(docker images -aq)"

:: Build image if no existing image
docker image inspect "%IMAGE%" > nul 2>&1
if %ERRORLEVEL% neq 0 (
    docker build ^
    --build-arg USER_NAME=%USERNAME% ^
    --build-arg USER_ID="1001" ^
    --build-arg GROUP_NAME=%USERNAME% ^
    --build-arg GROUP_ID="1001" ^
    --tag %IMAGE% ^
    .
)

:: Start vcxsrv if needed
tasklist /FI "IMAGENAME eq vcxsrv.exe" 2>NUL | find /I /N "vcxsrv.exe">NUL
if "%ERRORLEVEL%" GTR "0" (
    echo Starting VcXsrv
    start "" "%vcxsrv%" :0 -multiwindow -clipboard -wgl -ac
    timeout /t 5 >nul
)

::get ip from hostname
set "IP=%2"
if "%2%"=="" (
  for /f "tokens=2 delims=[]" %%a in ('ping -n 1 %UUT% ^| findstr /r /c:"Pinging"') do (
    set "IP=%%a"
  )
)
echo "UUT=%UUT% IP=%IP%"

::Run Image
docker run -it ^
  --rm ^
  -h %COMPUTERNAME% ^
  --network bridge ^
  --env="DISPLAY=host.docker.internal:0.0" ^
  --volume="%cd%\workspaces:/home/%USERNAME%/workspaces" ^
  %IMAGE% ^
  /bin/bash -c "./scripts/workspace_init.sh %UUT% %IP% && cs-studio > /dev/null 2>&1"

