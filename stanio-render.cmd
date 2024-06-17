@echo off
:: Usual options include: --standard-sizes --windows-cursors
:: Use --help for more

setlocal
set BASEDIR=%~dp0
set BASEDIR=%BASEDIR:~0,-1%

"%BASEDIR%\stanio-misc\gradlew" -p "%BASEDIR%\stanio-misc" ^
	-q bibata:run "-PbibataJvmArgs=%RENDER_JOPTS%" ^
	"--args=render ..\..\%RENDER_CONFIG% %*"
