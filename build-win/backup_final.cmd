echo Creating \bin\release...
set reldir=%1
if x%reldir%==x set reldir=..\..\bin
if exist %reldir%\release\isotoxin.exe goto alrd

md %reldir%\release
move %reldir%\isotoxin.exe %reldir%\release
move %reldir%\plghost.exe %reldir%\release
move %reldir%\proto.lan.dll %reldir%\release
move %reldir%\proto.tox.dll %reldir%\release
move %reldir%\proto.xmp.dll %reldir%\release
move %reldir%\proto.xxx.dll %reldir%\release
move %reldir%\shared.dll %reldir%\release

echo Success!: Your build is completed and available in %reldir%\release
echo Don't forget to run 4-build-assets.cmd to package the resources for your release.
goto enda
:alrd
echo Sorry!: Your build was already completed. You'll need to clean before building again.
:enda
