@echo off
set getlib=libsodium
echo getting: %getlib%
set libdir=%1
if x%libdir%==x set libdir=..\..\source\libs-external
if exist %libdir%\libsodium\src\libsodium\include\sodium.h goto alrd

if exist libsodium rd libsodium /S /Q

git clone https://github.com/jedisct1/libsodium
:: Hard code to 1.0.18-RELEASE May 30, 2019
cd libsodium
git reset --hard 940ef42797baa0278df6b7fd9e67c7590f87744b
cd ..

move libsodium\src %libdir%\libsodium >nul

rd libsodium /S /Q

echo ok: %getlib% obtained
goto enda
:alrd
echo ok: %getlib% already here
:enda