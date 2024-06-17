@echo off
setlocal
set VERSION=2.0.7-stanio-1

set RENDER_ARGS=--windows-cursors ^
    --source svg/modern --name Modern ^
    --source svg/original --name Original ^
    --source svg/modern-right --name Left-Handed-Modern ^
    --source svg/original-right --name Left-Handed-Original ^
    --color Classic,Ice ^
    --build-dir themes/windows/Bibata-Cursors-v%VERSION% ^
    --all-variants --thin-stroke ^
    -s N,L -r 32,40,48,60,64,72,80,96,128

:: The default opacity=0.5 appears too dark (less translucent).
::set SHADOW_ARG=--pointer-shadow=3,21,9
set SHADOW_ARG=--pointer-shadow=6,18,6,0.25

set _RENDER_JOPTS=%RENDER_JOPTS%
set RENDER_JOPTS=%_RENDER_JOPTS% -Dbibata.maxAnimSize=96 -Dbibata.minAnimSize=32

set RENDER_SCRIPT="%~dp0stanio-render"

call %RENDER_SCRIPT% %RENDER_ARGS% %SHADOW_ARG% %* || exit /b

:: Create setup scripts
set RELDIR=%~dp0
call set RELDIR=%%RELDIR:%CD%\=%%
set BUILD_SCRIPT="%RELDIR%stanio-misc\gradlew" -p "%RELDIR%stanio-misc" -q

echo:
call %BUILD_SCRIPT% cleanWindowsInstallScripts windowsInstallScripts ^
	-PcursorsVersion=%VERSION% -PwindowsSizes=,Large -PthemeColors=Classic,Ice || exit /b
xcopy "%RELDIR%stanio-misc\bibata\build\windows-scripts\*" ^
	"%RELDIR%themes\windows\Bibata-Cursors-v%VERSION%" /s /i /y
