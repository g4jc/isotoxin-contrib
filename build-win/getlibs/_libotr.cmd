@echo off
set getlib=libotr
echo getting: %getlib%
set libdir=%1
if x%libdir%==x set libdir=..\..\source\libs-external
if exist %libdir%\libotr\src\proto.c goto alrd

if exist libotr rd libotr /S /Q

git clone https://github.com/off-the-record/libotr

md %libdir%\libotr\src
md %libdir%\libotr\toolkit
move libotr\src\*.h %libdir%\libotr\src >nul
move libotr\src\*.c %libdir%\libotr\src >nul
move libotr\toolkit\*.h %libdir%\libotr\toolkit >nul
move libotr\toolkit\*.c %libdir%\libotr\toolkit >nul

rd libotr /S /Q

echo ok: %getlib% obtained
goto enda
:alrd
echo ok: %getlib% already here
:enda