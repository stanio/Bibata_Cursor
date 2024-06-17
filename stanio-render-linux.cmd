@echo off
setlocal
set VERSION=2.0.7-stanio-1

set RENDER_ARGS=--linux-cursors ^
    --source svg/modern --name Bibata-Modern ^
    --source svg/original --name Bibata-Original ^
    --source svg/modern-right --name Bibata-Left-Handed-Modern ^
    --source svg/original-right --name Bibata-Left-Handed-Original ^
    --color Classic,Ice ^
    --build-dir themes/linux ^
    --all-variants --thin-stroke ^
    -s /1.25:x4/5 -r 30,40,50,60,70,80,90,100,120
::                -r 24,32,40,48,56,64,72,80,96

:: The default opacity=0.5 appears too dark (less translucent).
::set SHADOW_ARG=--pointer-shadow=3,21,9
set SHADOW_ARG=--pointer-shadow=6,18,6,0.25

set RENDER_JOPTS=%RENDER_JOPTS% -Dbibata.maxAnimSize=100 -Dxcur.cropToContent=true

set RENDER_SCRIPT="%~dp0stanio-render"

call %RENDER_SCRIPT% %RENDER_ARGS% %SHADOW_ARG% %* || exit /b

:: Create symlinks and theme files
set RELDIR=%~dp0
call set RELDIR=%%RELDIR:%CD%\=%%
set BUILD_SCRIPT="%RELDIR%stanio-misc\gradlew" -p "%RELDIR%stanio-misc" -q

echo:
call %BUILD_SCRIPT% x11Symlinks --args=../../themes/linux || exit /b
echo:
call %BUILD_SCRIPT% cleanLinuxThemeFiles linuxThemeFiles ^
	-PcursorsVersion=%VERSION% -PthemeColors=Classic,Ice || exit /b
xcopy "%RELDIR%stanio-misc\bibata\build\linux-themes\*" ^
	"%RELDIR%themes\linux" /s /i /y
