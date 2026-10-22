@echo off
title PC Assistant v1.0
color OA
setlocal

:MENU
cls
echo
=======================================================================================================================================================================
echo                                     PC ASSISTANT v1.0
echo
======================================================================================================================================================================
echo.
echo 1. View computer information
echo 2. Check disk space
echo 3. View network information
echo 4. View running processes
echo 5. Generate a battery report
echo 6. Save a full system report
echo 7. Exit
echo.
echo
=======================================================================================================================================================================
set /p choice=Choose an option:

if "%choice%"=="1" goto COMPUTER
if "%choice%"=="2" goto DISK
if "%choice%"=="3" goto NETWORK
if "%choice%"=="4" goto PROCESSES
if "%choice%"=="5" goto BATTERY
if "%choice%"=="6" goto REPORT
if "%choice%"=="7" goto END


echo.
echo Invalid choice. Please try again.
pause
goto MENU

:COMPUTER
cls ==== COMPUTER INFORMATION =====
echo.
hostname
ver
echo.
systeminfo | findstr /B /C:"OS Name" /C:"OS Version" /C:"System Manufacturer" /C:"System Model" /C:"Total Physical Memory"
echo.
pause
goto MENU

:DISK
cls
echo =====DISK SPACE=====
echo.
powershell -NoProfile -Command "Get-Volume | Where-Object DriveLetter | Select-Object DriveLetter,FileSystemLabel,@{Name='SizeGB';Expression={[math]::Round($_.Size/1GB,2)}},@{Name='FreeGB';Expression={[math]::Round($_.SizeRemaining/1GB,2)}} | Format-Table -Autosize"
echo.
pause
goto MENU

:NETWORK
cls
echo ===== NETWORK PROCESSES =====
echo.
tasklist
echo.
pause
goto MENU

:BATTERY
cls
echo ====== BATTERY REPORT ======
echo.
powercfg /batteryreport /output "%USERPROFILE%"\Desktop\battery-report.html"
echo.
echo If successful, open battery-report.html on your Desktop.
pause
goto MENU

:REPORT
cls
echo ===== GENERATING SYSTEM REPORT =====
echo.

set "REPORTFILE=%USERPROFILE%\Desktop\system-report.txt"

echo Generating report. Please wait...

echo.
(
echo PC ASSISTANT SYSTEM REPORT
echo ===========================================================================================================================================================
echo.
echo DATE AND TIME:
echo %DATE% %TIME%
echo.
echo COMPUTER NAME:
hostname
echo.
echo WINDOWS VERSION:
ver
echo.
echo SYSTEM INFORMATION:
systeminfo
echo.
echo NETWORK INFORMATION:
ipconfig
echo.
echo RUNNING PROCESSES:
tasklist
) > "%REPORTFILE%" 2>&1

if exist "%REPORTFILE%" (
	echo.
	echo Report saved to:
	echo "%REPORTFILE%"
	echo.
	echo Opening report in Notepad...
	start "" notepad "%REPORTFILE%"
) else (
	echo ERROR: The report could not be created.
)

echo.
pause
goto MENU

:END
echo.
echo Thank you for using PS Assistant!
endlocal
exit /b

 


               