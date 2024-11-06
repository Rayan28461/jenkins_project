@echo off

REM Check if argument is 'remote' or 'local'
set DEPLOY_TARGET=%1

if "%DEPLOY_TARGET%"=="remote" (
    REM Replace these variables with your remote server information
    set REMOTE_USER=your-username
    set REMOTE_HOST=your-server.com
    set REMOTE_DIR=/path/to/deploy  REM Replace with the remote server path

    echo Deploying to remote server...
    
    REM Transfer files using pscp (PuTTY secure copy tool) - adjust paths as needed
    REM Ensure pscp is in your PATH or specify the full path to pscp.exe
    pscp -r * %REMOTE_USER%@%REMOTE_HOST%:%REMOTE_DIR%

    REM Connect to the remote server and run setup commands using plink (PuTTY's ssh client)
    REM Ensure plink is in your PATH or specify the full path to plink.exe
    plink %REMOTE_USER%@%REMOTE_HOST% ^
        "cd %REMOTE_DIR% && python -m src.app"
    
    echo Application deployed and started on remote server.
) else if "%DEPLOY_TARGET%"=="local" (
    echo Deploying locally...
    
    REM Start the application locally in the background
    start python -m src.app  REM Adjust to your main entry file
    
    echo Application deployed and started locally.
) else (
    echo Please specify "remote" or "local" as the deployment target.
)
