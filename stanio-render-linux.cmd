@echo off
setlocal

set RENDER_ARGS=^
    --linux-cursors ^
    -s /1.25:x4/5 -r 30,40,60,80,100,120
::       -r 24,32,48,64,80,96
::  -s R -r 24,30,33,36,42,48,60,72,84,96,120,144
::       -r 16,20,22,24,28,32,40,48,56,64,80,96

:: The default opacity=0.5 appears too dark (less translucent).
::set SHADOW_ARG=--pointer-shadow=3,21,9
set SHADOW_ARG=--pointer-shadow=6,18,6,0.3

set RENDER_CONFIG=render-linux.json
set RENDER_JOPTS=-Dbibata.maxAnimSize=100 -Dxcur.cropToContent=true

set RENDER_SCRIPT="%~dp0stanio-render"

echo === Plain (no Shadow)
call %RENDER_SCRIPT% %RENDER_ARGS% %* || exit /b

echo:
echo === Thin outline
call %RENDER_SCRIPT% %RENDER_ARGS% --thin-stroke %* || exit /b

echo:
echo === w/ Shadow
call %RENDER_SCRIPT% %RENDER_ARGS% %SHADOW_ARG% %*

echo:
echo === Thin outline w/ Shadow
call %RENDER_SCRIPT% %RENDER_ARGS% --thin-stroke %SHADOW_ARG% %*

:: Create symlinks and theme files
set RELDIR=%~dp0
call set RELDIR=%%RELDIR:%CD%\=%%
set BUILD_SCRIPT="%RELDIR%stanio-misc\gradlew" -p "%RELDIR%stanio-misc" -q

echo:
call %BUILD_SCRIPT% x11Symlinks --args=../../themes/linux
echo:
call %BUILD_SCRIPT% cleanLinuxThemeFiles linuxThemeFiles
xcopy "%RELDIR%stanio-misc\bibata\build\linux-themes\*" ^
	"%RELDIR%themes\linux" /s /i /y
