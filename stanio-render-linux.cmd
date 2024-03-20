@echo off
setlocal EnableDelayedExpansion

set RENDER_ARGS=^
    -t Bibata-Modern-Classic ^
    -t Bibata-Modern-Classic-Thin ^
    -t Bibata-Modern-Ice ^
    -t Bibata-Modern-Ice-Thin ^
    -t Bibata-Original-Classic ^
    -t Bibata-Original-Classic-Thin ^
    -t Bibata-Original-Ice ^
    -t Bibata-Original-Ice-Thin ^
    --linux-cursors ^
    -s R -r 36,48,72,96,120,144
::       -r 24,32,48,64,80,96
::  -s R -r 24,30,33,36,42,48,60,72,84,96,120,144
::       -r 16,20,22,24,28,32,40,48,56,64,80,96

:: The default opacity=0.5 appears too dark (less translucent).
::set SHADOW_ARG=--pointer-shadow=3,21,9
set SHADOW_ARG=--pointer-shadow=6,18,6,0.3

set RENDER_CONFIG=render-linux.json
set RENDER_JOPTS=-Dbibata.maxAnimSize=120

set RENDER_SCRIPT="%~dp0stanio-render"

echo === Plain (no Shadow)
call %RENDER_SCRIPT% %RENDER_ARGS% %* || exit /b

echo:
echo === w/ Shadow
call %RENDER_SCRIPT% %RENDER_ARGS% %SHADOW_ARG% %*

:: Create symlinks and theme files
set RELDIR=%~dp0
set RELDIR=!RELDIR:%CD%\=!
set BUILD_SCRIPT="%RELDIR%stanio-misc\gradlew" -p "%RELDIR%stanio-misc" -q

echo:
call %BUILD_SCRIPT% x11Symlinks --args=../../themes/linux
echo:
call %BUILD_SCRIPT% cleanLinuxThemeFiles ^
	linuxThemeFiles -PthemeColors=Classic,Ice
xcopy "%RELDIR%stanio-misc\bibata\build\linux-themes\*" ^
	"%RELDIR%themes\linux" /s /i /y
