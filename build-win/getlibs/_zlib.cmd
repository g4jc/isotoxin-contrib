@echo off
set getlib=zlib
echo getting: %getlib%
set libdir=%1
if x%libdir%==x set libdir=..\..\source\libs-external
if exist %libdir%\zlib\src\zlib.h goto alrd

if exist zlib rd zlib /S /Q
git clone https://github.com/madler/zlib
cd zlib
::  Hard code to old zlib 1.2.11 to grab assembly code required for x64
git reset --hard cacf7f1d4e3d44d871b605da3b647f07d718623f
cd ..

:: Create folders
md %libdir%\zlib\src
md %libdir%\zlib\src\contrib

:: Move assembly data to our libs-external
move zlib\contrib\masmx64 %libdir%\zlib\src\contrib >nul
move zlib\contrib\masmx86 %libdir%\zlib\src\contrib >nul


cd zlib
::  Pop back to trunk for a copy of the latest code
git reset --hard
cd ..

:: Move latest code to our libs-external
move zlib\*.c %libdir%\zlib\src >nul
move zlib\*.h %libdir%\zlib\src >nul
move zlib\contrib\minizip %libdir%\zlib\src\contrib >nul

rd zlib /S /Q

echo ok: %getlib% obtained
goto enda
:alrd
echo ok: %getlib% already here
:enda
