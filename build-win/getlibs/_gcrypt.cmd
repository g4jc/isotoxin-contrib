@echo off
set getlib=gcrypt
echo getting: %getlib%
set libdir=%1
if x%libdir%==x set libdir=..\..\source\libs-external
if exist %libdir%\gcrypt\include\gcrypt.h goto alrd

set LIBGCRYPTVER=1.10.1
set LIBGCRYPTURL=https://github.com/ShiftMediaProject/libgcrypt/releases/download/libgcrypt-%LIBGCRYPTVER%/libgcrypt_libgcrypt-%LIBGCRYPTVER%_msvc15.zip
set LIBGCRYPTARCHIVE=libgcrypt_libgcrypt-%LIBGCRYPTVER%_msvc15.zip

if exist gcrypt rd gcrypt /S /Q
..\wget %LIBGCRYPTURL%
..\7z e %LIBGCRYPTARCHIVE% include\gcrypt.h include\gpg-error.h
del %LIBGCRYPTARCHIVE%
md %libdir%\gcrypt\include
move gcrypt.h %libdir%\gcrypt\include >nul
move gpg-error.h %libdir%\gcrypt\include >nul

:: We place a copy of libgcrypt into libotr so that it can be found by MSVC
md %libdir%\libotr\src
xcopy %libdir%\gcrypt\include %libdir%\libotr\src /s /e

rd gcrypt /S /Q

echo ok: %getlib% obtained
goto enda
:alrd
echo ok: %getlib% already here
:enda