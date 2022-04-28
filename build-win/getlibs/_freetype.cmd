@echo off
set getlib=freetype
echo getting: %getlib%
set libdir=%1
if x%libdir%==x set libdir=..\..\source\libs-external
if exist %libdir%\freetype\include\freetype\freetype.h goto alrd

if exist freetype2 rd freetype2 /S /Q
git clone https://github.com/freetype/freetype freetype2
cd freetype2
::  Hardcode Jul 1, 2019 VER-2-10-1
git reset --hard 8cf046c38d4c6ada76ba070562beff0d5041f795
cd ..
move freetype2\include %libdir%\freetype >nul
move freetype2\src %libdir%\freetype >nul
rd freetype2 /S /Q

echo ok: %getlib% obtained
goto enda
:alrd
echo ok: %getlib% already here
:enda
