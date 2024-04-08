:: -----------------------------------------------------------------
:: File:   build.bat
:: Author: (c) 2024 Jens Kallup - paule32
:: All rights reserved
::
:: only for education, and non-profit usage !
:: -----------------------------------------------------------------
::@echo off
setlocal enabledelayedexpansion

set prjdir1=E:\Projekte\fpc-qt\src
set prjdir2=E:/Projekte/fpc-qt/src

set asmdir=E:\nasm
set asmx32=%asmdir%\nasm -f win32
set asmx64=%asmdir%\nasm -f win64

set fpcdir1=E:\FPC\3.2.0\bin\i386-win32
set fpcdir2=E:\fpc\3.2.2\bin\i386-win32

set gcc32=E:\msys64\mingw32\bin\gcc
set gcc64=E:\msys64\mingw64\bin\gcc

set strip=E:/msys64/mingw64/bin/strip

set fpcdir=%fpcdir1%
set fpcx32=%fpcdir%\fpc32.exe
set fpcx64=%fpcdir%\fpc64.exe

set fpcstr=%fpcdir1%\strip.exe

set fpcdst=-Twin64 -Mdelphi -dwindows -dwin64 -v0 ^
    -Fi%prjdir1%\sources\fpc-win ^
    -Fi%prjdir1%\sources\fpc-rtl ^
    -Fi%prjdir1%\sources\fpc-gnu ^
    -Fi%prjdir1%\sources\fpc-qt

set fpcasm=-Anasmwin64 -al

set fpcsys1=^
    -Fu%prjdir1%\sources\fpc-sys ^
    -Fu%prjdir1%\sources\fpc-qt  ^
    -Fu%prjdir1%\units\fpc-rtl ^
    -Fu%prjdir1%\units\fpc-sys ^
    -Fu%prjdir1%\units\fpc-win ^
    -Fu%prjdir1%\units\fpc-qt

set fpcsys2=^
    -n ^
    -O3 -Op3 -Os ^
    -Si -Sc  -Sg ^
    -Xd -Xe  -XD -CX -XXs ^
    -sh -Ur  ^
    -WA -WD -WN %fpcasm% -vl

set fpcsys3=^
    -n ^
    -O3 -Op3 -Os ^
    -Si -Sc  -Sg ^
    -Xd -Xe  -XD -CX -XXs ^
    -sh -Ur

cd %prjdir1%

echo =[ clean up directories    ]=
del   %prjdir1%\units       /F /S /Q
del   %prjdir1%\tests\units /F /S /Q

rmdir %prjdir1%\units       /S /Q
rmdir %prjdir1%\tests\units /S /Q

mkdir %prjdir1%\units

cd %prjdir1%\units
for %%A in (fpc-qt fpc-rtl fpc-sys fpc-win) do ( mkdir .\%%A )
cd %prjdir1%

mkdir %prjdir1%\tests\units

echo =[ begin compile stage     ]=
%asmx64% -o%prjdir1%\units\fpc-sys\fpcinit.o %prjdir1%\sources\fpc-sys\fpcinit.asm
%asmx64% -o%prjdir1%\units\fpc-sys\fpcdll.o  %prjdir1%\sources\fpc-sys\fpcdll.asm

%fpcx64% %fpcdst% %fpcsys2% %fpcsys1% %fpcasm% -dwindll     -FE%prjdir1%\units\fpc-sys %prjdir1%\sources\fpc-sys\fpintres.pp
%fpcx64% %fpcdst% %fpcsys2% %fpcsys1% %fpcasm% -dwindll -Us -FE%prjdir1%\units\fpc-sys %prjdir1%\sources\fpc-sys\system.pas
%fpcx64% %fpcdst% %fpcsys2% %fpcsys1% %fpcasm% -dwindll     -FE%prjdir1%\units\fpc-sys %prjdir1%\sources\fpc-sys\sysinit.pas

%fpcx64% %fpcdst% %fpcsys2% %fpcsys1% -dwindll -FE%prjdir1%\units\fpc-rtl %prjdir1%\sources\fpc-rtl\RTL_Utils.pas
::%fpcx64% %fpcdst% %fpcsys2% %fpcsys1% -dwindll -FE%prjdir1%\units\fpc-qt  %prjdir1%\sources\fpc-qt\Qt_String.pas

echo =[ build dll file...       ]=
%fpcx64% %fpcdst% %fpcsys2% %fpcsys1% -dwindll ^
-Fu%prjdir1%\sources\fpc-qt ^
-FE%prjdir1%\tests\units %prjdir1%\tests\fpc_rtl.pas

cd %prjdir1%\tests\units
SET THEFILE=system
echo Assembling %THEFILE%
E:\nasm\nasm.exe -f win64 -o ^
E:\Projekte\fpc-qt\src\tests\units\system.o    -w-orphan-labels ^
E:\Projekte\fpc-qt\src\tests\units\system.s
SET THEFILE=qt_string
echo Assembling %THEFILE%
E:\nasm\nasm.exe -f win64 -o ^
E:\Projekte\fpc-qt\src\tests\units\Qt_String.o -w-orphan-labels ^
E:\Projekte\fpc-qt\src\tests\units\Qt_String.s
SET THEFILE=fpc_rtl
echo Assembling %THEFILE%
E:\nasm\nasm.exe -f win64 -o ^
E:\Projekte\fpc-qt\src\tests\units\fpc_rtl.o   -w-orphan-labels ^
E:\Projekte\fpc-qt\src\tests\units\fpc_rtl.s
SET THEFILE=E:\Projekte\fpc-qt\src\tests\units\fpc_rtl.dll
echo Linking %THEFILE%
E:\FPC\3.2.0\bin\i386-win32\ld.exe      -b pei-x86-64  -s --dll --entry _DLLMainCRTStartup -o ^
E:\Projekte\fpc-qt\src\tests\units\fpc_rtl.dll ^
E:\Projekte\fpc-qt\src\tests\units\link.res
E:\FPC\3.2.0\bin\i386-win32\dlltool.exe -S     ^
E:\FPC\3.2.0\bin\i386-win32\as.exe      -D     ^
E:\Projekte\fpc-qt\src\tests\units\fpc_rtl.dll -e exp.$$$  -d ^
E:\Projekte\fpc-qt\src\tests\units\fpc_rtl.def
E:\FPC\3.2.0\bin\i386-win32\ld.exe      -b pei-x86-64  -s --dll  --entry _DLLMainCRTStartup -o ^
E:\Projekte\fpc-qt\src\tests\units\fpc_rtl.dll ^
E:\Projekte\fpc-qt\src\tests\units\link.res exp.$$$
::
copy E:\Projekte\fpc-qt\src\tests\units\fpc_rtl.dll E:\Projekte\fpc-qt\src\tests\fpc_rtl.dll
::
echo =[ build exe file...       ]=
%fpcx64% %fpcdst% %fpcsys2% %fpcsys1% -dwinexe     -FE%prjdir1%\tests\units %prjdir1%\sources\fpc-sys\fpintres.pp
%fpcx64% %fpcdst% %fpcsys2% %fpcsys1% -dwinexe -Us -FE%prjdir1%\tests\units %prjdir1%\sources\fpc-sys\system.pas
%fpcx64% %fpcdst% %fpcsys2% %fpcsys1% -dwinexe     -FE%prjdir1%\tests\units %prjdir1%\sources\fpc-sys\sysinit.pas

%fpcx64% %fpcdst% %fpcsys2% %fpcsys1% -dwinexe     -FE%prjdir1%\tests\units %prjdir1%\sources\fpc-rtl\RTL_Utils.pas

SET THEFILE=sysinit
echo Assembling %THEFILE%
E:\nasm\nasm.exe -f win64 -o ^
E:\Projekte\fpc-qt\src\tests\units\sysinit.o -w-orphan-labels ^
E:\Projekte\fpc-qt\src\tests\units\sysinit.s

%fpcx64% %fpcdst% %fpcsys1% %fpcsys2% -dwinexe -FE%prjdir1%\tests\units %prjdir1%\tests\test1.pas

echo Assembling %THEFILE%
E:\nasm\nasm.exe -f win64 -o E:\Projekte\fpc-qt\src\tests\units\test1.o -w-orphan-labels  E:\Projekte\fpc-qt\src\tests\units\test1.s
SET THEFILE=E:\Projekte\fpc-qt\src\tests\units\test1.exe
echo Linking %THEFILE%
SET THEFILE=E:\Projekte\fpc-qt\src\tests\units\test1.exe
echo Linking %THEFILE%
E:\FPC\3.2.0\bin\i386-win32\ld.exe -b pei-x86-64 -s  --entry=_mainCRTStartup -o ^
E:\Projekte\fpc-qt\src\tests\units\test1.exe ^
E:\Projekte\fpc-qt\src\tests\units\link.res
::
copy E:\Projekte\fpc-qt\src\tests\units\test1.exe E:\Projekte\fpc-qt\src\tests\test1.exe
::
exit
echo =[ create map              ]=
grep "FPC_move" map.txt | awk '{print $1}'

echo =[ done                    ]=
