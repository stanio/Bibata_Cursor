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
    --windows-cursors ^
    -r 32,48,64,96,128

:: The default opacity=0.5 appears too dark (less translucent).
::set SHADOW_ARG=--pointer-shadow=3,21,9
set SHADOW_ARG=--pointer-shadow=6,18,6,0.3

set RENDER_CONFIG=render-windows.json
set RENDER_JOPTS=-Dbibata.maxAnimSize=96

set RENDER_SCRIPT="%~dp0stanio-render"

echo === Normal and Large
call %RENDER_SCRIPT% %RENDER_ARGS% -s N,L %* || exit /b

echo:
echo === Normal and Large with Shadow
call %RENDER_SCRIPT% %RENDER_ARGS% -s N,L %SHADOW_ARG% %* || exit /b

echo:
echo === Extra-Large
set RENDER_JOPTS=-Dbibata.maxAnimSize=64
call %RENDER_SCRIPT% %RENDER_ARGS% -s XL %*
:: No Extra-Large with Shadow

:: Create setup scripts
set RELDIR=%~dp0
set RELDIR=!RELDIR:%CD%\=!
set BUILD_SCRIPT="%RELDIR%stanio-misc\gradlew" -p "%RELDIR%stanio-misc" -q

echo:
call %BUILD_SCRIPT% cleanWindowsInstallScripts ^
	windowsInstallScripts -PthemeColors=Classic,Ice
xcopy "%RELDIR%stanio-misc\bibata\build\windows-scripts\*" ^
	"%RELDIR%themes\windows\Bibata" /s /i /y
