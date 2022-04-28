@echo off
set getlib=pthread-win32
echo getting: %getlib%
set libdir=%1
if x%libdir%==x set libdir=..\..\source\libs-external
if exist %libdir%\pthread-win32\pthread.h goto alrd

if exist pthread-win32 rd pthread-win32 /S /Q

git clone https://github.com/GerHobbelt/pthread-win32/
:: Hard code to Point Release 3.0.3.1 Dec 17, 2021
cd pthread-win32
git reset --hard 512a38decec4d2007d4b336f5f24f7e4afa23bd0
:: Fix a typo resulting in missing header file
git apply ..\..\ptw32.patch
cd ..

xcopy pthread-win32 %libdir%\pthread-win32\ /s /y

rd pthread-win32 /S /Q

echo ok: %getlib% obtained
goto enda
:alrd
echo ok: %getlib% already here
:enda