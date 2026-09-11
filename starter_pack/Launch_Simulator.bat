@echo off
setlocal
title PegFX — Virtual Dot-Matrix Hardware Simulator

:: Check if python is available
where python >nul 2>nul
if %ERRORLEVEL% equ 0 (
    set PY_CMD=python
    goto :RUN
)

where py >nul 2>nul
if %ERRORLEVEL% equ 0 (
    set PY_CMD=py
    goto :RUN
)

:: Python was not found
cls
echo ================================================================
echo  PegFX Virtual Dot-Matrix Hardware Simulator
echo ================================================================
echo.
echo  [!] Python 3 is required to run the Virtual Matrix Simulator,
echo      but it was not found on your system PATH.
echo.
echo  Choose an option below to install Python:
echo.
echo   [1] Install Python automatically via Windows Package Manager (winget)
echo   [2] Open official Python website (python.org/downloads)
echo   [3] Open Python in Microsoft Store
echo   [4] Exit
echo.
set /p CHOICE="Enter your choice (1-4): "

if "%CHOICE%"=="1" (
    echo.
    echo Running: winget install Python.Python.3.12 ...
    winget install Python.Python.3.12
    echo.
    echo Please restart this launcher once the installation finishes!
    pause
    exit /b
)
if "%CHOICE%"=="2" (
    start https://www.python.org/downloads/
    exit /b
)
if "%CHOICE%"=="3" (
    start ms-windows-store://pdp/?productid=9NCVDN91XZQP
    exit /b
)
exit /b

:RUN
if exist "..\tools\simulate_matrix.py" (
    start "" "%PY_CMD%w" "..\tools\simulate_matrix.py" %* 2>nul || "%PY_CMD%" "..\tools\simulate_matrix.py" %*
) else if exist "tools\simulate_matrix.py" (
    start "" "%PY_CMD%w" "tools\simulate_matrix.py" %* 2>nul || "%PY_CMD%" "tools\simulate_matrix.py" %*
) else if exist "simulate_matrix.py" (
    start "" "%PY_CMD%w" "simulate_matrix.py" %* 2>nul || "%PY_CMD%" "simulate_matrix.py" %*
) else (
    echo [ERROR] Could not find simulate_matrix.py!
    pause
)
