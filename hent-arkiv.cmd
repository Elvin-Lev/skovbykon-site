@echo off
title Hent billeder fra Internet Archive
cd /d "%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0hent-arkiv.ps1"
echo.
echo Tryk en tast for at lukke.
pause >nul
