@echo off
REM Custom Bash Shell - Windows Launcher
REM This batch file helps Windows users launch the shell

echo.
echo ╔════════════════════════════════════════════════════════╗
echo ║     Custom Bash Shell Environment - Windows Launcher  ║
echo ╚════════════════════════════════════════════════════════╝
echo.

REM Check if running in WSL
where wsl >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo [Option 1] Launch in WSL2 (Recommended - Full Support)
    echo [Option 2] Launch in Git Bash (Partial Support)
    echo [Option 3] Launch in Docker (Full Support)
    echo [Option 4] View Setup Instructions
    echo [Option 5] Exit
    echo.
    set /p choice="Enter your choice (1-5): "
    
    if "%choice%"=="1" goto wsl
    if "%choice%"=="2" goto gitbash
    if "%choice%"=="3" goto docker
    if "%choice%"=="4" goto instructions
    if "%choice%"=="5" goto end
    
    echo Invalid choice. Please try again.
    pause
    exit /b
)

REM If WSL not available, show other options
echo WSL2 not detected. Available options:
echo.
echo [Option 1] Launch in Git Bash (Partial Support)
echo [Option 2] Launch in Docker (Full Support)
echo [Option 3] Install WSL2 (Recommended)
echo [Option 4] View Setup Instructions
echo [Option 5] Exit
echo.
set /p choice="Enter your choice (1-5): "

if "%choice%"=="1" goto gitbash
if "%choice%"=="2" goto docker
if "%choice%"=="3" goto install_wsl
if "%choice%"=="4" goto instructions
if "%choice%"=="5" goto end

echo Invalid choice. Please try again.
pause
exit /b

:wsl
echo.
echo Launching in WSL2...
echo.
wsl bash -c "cd '%CD%' && ./myshell.sh"
goto end

:gitbash
echo.
echo Launching in Git Bash...
echo Note: Some features may not work. Use WSL2 for full support.
echo.
where bash >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    bash myshell.sh
) else (
    echo Git Bash not found!
    echo Please install Git for Windows from: https://git-scm.com/download/win
    echo.
    pause
)
goto end

:docker
echo.
echo Launching in Docker...
echo.
where docker >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo Checking if Docker image exists...
    docker images | findstr myshell >nul 2>&1
    if %ERRORLEVEL% NEQ 0 (
        echo Building Docker image... (this may take a few minutes)
        docker build -t myshell .
    )
    echo Starting container...
    docker run -it --rm myshell
) else (
    echo Docker not found!
    echo Please install Docker Desktop from: https://www.docker.com/products/docker-desktop/
    echo.
    pause
)
goto end

:install_wsl
echo.
echo Installing WSL2...
echo This requires Administrator privileges.
echo.
echo Please run the following command in PowerShell (as Administrator):
echo.
echo     wsl --install
echo.
echo After installation, restart your computer and run this launcher again.
echo.
pause
goto end

:instructions
echo.
echo Opening setup instructions...
echo.
if exist WINDOWS_SETUP.md (
    notepad WINDOWS_SETUP.md
) else (
    echo WINDOWS_SETUP.md not found!
    echo Please visit the project repository for setup instructions.
)
pause
goto end

:end
echo.
echo Thank you for using Custom Bash Shell Environment!
echo.
exit /b
