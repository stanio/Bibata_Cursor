@echo off
setlocal

set RENDER_ARGS=^
    -t Bibata-Modern-Classic -t Bibata-Modern-Classic-Thin ^
    -t Bibata-Modern-Ice -t Bibata-Modern-Ice-Thin ^
    -t Bibata-Original-Classic -t Bibata-Original-Classic-Thin ^
    -t Bibata-Original-Ice -t Bibata-Original-Ice-Thin ^
    --windows-cursors -r 32,48,64,96,128

:: The default opacity=0.5 appears too dark (less translucent).
::set SHADOW_ARG=--pointer-shadow=3,21,9
set SHADOW_ARG=--pointer-shadow=3,21,9,0.25

set RENDER_CONFIG=render-windows.json

set RENDER_SCRIPT="%~dp0stanio-render"

echo === Regular
set RENDER_JOPTS=-Dbibata.maxAnimSize=96
call %RENDER_SCRIPT% %RENDER_ARGS% -s R || exit /b

echo:
echo === Regular with Shadow
call %RENDER_SCRIPT% %RENDER_ARGS% -s R %SHADOW_ARG% || exit /b

echo:
echo === Large and Extra-Large
set RENDER_JOPTS=-Dbibata.maxAnimSize=64
call %RENDER_SCRIPT% %RENDER_ARGS% -s L,XL || exit /b

echo:
echo === Large with Shadow
:: No Extra-Large with Shadow
%RENDER_SCRIPT% %RENDER_ARGS% -s L %SHADOW_ARG%
