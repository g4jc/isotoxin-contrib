@echo off
set getlib=toxcore
echo getting: %getlib%
set libdir=%1
if x%libdir%==x set libdir=..\..\source\libs-external
if exist %libdir%\toxcore\toxcore\tox.h goto alrd

if exist toxcore rd toxcore /S /Q
git clone https://github.com/TokTok/c-toxcore toxcore
:: Hard code to Release 0.2.18 Apr 18, 2022
cd toxcore 
git reset --hard 3a5da3588f693ba17768a9a4cbd67d54d53114ac
cd ..

if exist %libdir%\toxcore rd %libdir%\toxcore /S /Q
move /Y toxcore\other %libdir%\toxcore >nul
move /Y toxcore\toxav %libdir%\toxcore >nul
move /Y toxcore\toxcore %libdir%\toxcore >nul
move /Y toxcore\toxencryptsave %libdir%\toxcore >nul

:: TODO: Split up remaining dependencies into external getlibs
if exist toxcore-vs rd toxcore-vs /S /Q
git clone https://github.com/isotoxin/toxcore-vs

if exist %libdir%\opus rd %libdir%\opus /S /Q
move /Y toxcore-vs\opus %libdir% >nul

if exist %libdir%\libvpx rd %libdir%\libvpx /S /Q
move /Y toxcore-vs\libvpx %libdir% >nul

rd toxcore-vs /S /Q

rd toxcore /S /Q

echo ok: %getlib% obtained
goto enda
:alrd
echo ok: %getlib% already here
:enda
