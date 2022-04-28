@echo off
set getlib=cairo
echo getting: %getlib%
set libdir=%1
if x%libdir%==x set libdir=..\..\source\libs-external
if exist %libdir%\cairo\src\cairo.h goto alrd

if exist cairo rd cairo /S /Q
if exist pixman rd pixman /S /Q
git clone https://github.com/freedesktop/cairo
cd cairo
:: Hardcode to Dec 20, 2019 version
git reset --hard 2982adec7698ef6cc55b6eb27f28200a95013cdc
cd ..
git clone https://github.com/freedesktop/pixman pixman
cd pixman
:: Hardcode to Apr 10, 2019 tags/pixman-0.38.4 version
git reset --hard e8df10eea9609609568bf4cbc05796594c1b978d
cd ..

md %libdir%\cairo\src
md %libdir%\cairo\pixman

move cairo\src\cairo-*.c %libdir%\cairo\src >nul
move cairo\src\cairo-*.h %libdir%\cairo\src >nul
move cairo\src\cairo.c %libdir%\cairo\src >nul
move cairo\src\cairo.h %libdir%\cairo\src >nul
move cairo\src\win32\cairo*.c %libdir%\cairo\src >nul
move cairo\src\win32\cairo*.h %libdir%\cairo\src >nul

move pixman\pixman\pixman*.c %libdir%\cairo\pixman >nul
move pixman\pixman\pixman*.h %libdir%\cairo\pixman >nul

rd cairo /S /Q
rd pixman /S /Q

echo ok: %getlib% obtained
goto enda
:alrd
echo ok: %getlib% already here
:enda
