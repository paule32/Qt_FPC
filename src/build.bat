:: -----------------------------------------------------------------
:: File:   build.bat
:: Author: (c) 2024 Jens Kallup - paule32
:: All rights reserved
::
:: only for education, and non-profit usage !
:: -----------------------------------------------------------------
::@echo off
setlocal enabledelayedexpansion

:: -----------------------------------------------------------------
:: fpcdir1/2 => location of fpc.exe compiler tools ...
:: -----------------------------------------------------------------
set fpcdir1=E:\FPC\3.2.0\bin\i386-win32
set fpcdir2=E:\fpc\3.2.2\bin\i386-win32

set fpcdir=%fpcdir1%

:: -----------------------------------------------------------------
:: prjdir => location of the fpc-qt project ...
:: -----------------------------------------------------------------
set prjdir=E:\Projekte\fpc-qt\src

:: -----------------------------------------------------------------
:: location of nasm.exe (the netwide assembler)
:: -----------------------------------------------------------------
set asmdir=E:\nasm
set asmx32=%asmdir%\nasm.exe -f win32
set asmx64=%asmdir%\nasm.exe -f win64

:: -----------------------------------------------------------------
:: fpc32.exe is a copy of fpc 3.2 fpc.exe (32-Bit)
:: fpc64.exe is a copy of fpc 3.2 fpc.exe (64-Bit)
::
:: the files was manualy copied from a 32-Bit, and 64-Bit Relase
:: -----------------------------------------------------------------
set fpcx32=%fpcdir%\fpc32.exe
set fpcx64=%fpcdir%\fpc64.exe

:: -----------------------------------------------------------------
:: ld32.exe is a copy of fpc 3.2 tool ld.exe (32-Bit)
:: ld64.exe is a copy of fpc 3.2 tool ld.exe (64-Bit)
::
:: the files was manualy copied from a 32-Bit, and 64-Bit Relase
:: -----------------------------------------------------------------
set ld32=%fpcdir%\ld32.exe
set ld64=%fpcdir%\ld64.exe

:: -----------------------------------------------------------------
:: strip32.exe is a copy of fpc 3.2 tool as.exe (32-Bit)
:: strip64.exe is a copy of fpc 3.2 tool as.exe (64-Bit)
::
:: the files was manualy copied from a 32-Bit, and 64-Bit Relase
:: -----------------------------------------------------------------
set as32=%fpcdir%\as32.exe
set as64=%fpcdir%\as64.exe

:: -----------------------------------------------------------------
:: strip32.exe is a copy of fpc 3.2 tool strip.exe (32-Bit)
:: strip64.exe is a copy of fpc 3.2 tool strip.exe (64-Bit)
::
:: the files was manualy copied from a 32-Bit, and 64-Bit Relase
:: -----------------------------------------------------------------
set strip32=%fpcdir%\strip32.exe
set strip64=%fpcdir%\strip64.exe

set dlltool=%fpcdir%\dlltool.exe

set fpcdst=-Twin64 -Mdelphi -dwindows -dwin64 -v0 ^
    -Fi%prjdir%\sources\fpc-win ^
    -Fi%prjdir%\sources\fpc-rtl ^
    -Fi%prjdir%\sources\fpc-gnu ^
    -Fi%prjdir%\sources\fpc-qt

set fpcasm=-Anasmwin64 -al

set fpcsys1=^
    -Fu%prjdir%\sources\fpc-sys ^
    -Fu%prjdir%\sources\fpc-qt  ^
    -Fu%prjdir%\units\fpc-rtl ^
    -Fu%prjdir%\units\fpc-sys ^
    -Fu%prjdir%\units\fpc-win ^
    -Fu%prjdir%\units\fpc-qt

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

cd %prjdir%

echo =[ clean up directories    ]=
del   %prjdir%\units       /F /S /Q
del   %prjdir%\tests\units /F /S /Q

rmdir %prjdir%\units       /S /Q
rmdir %prjdir%\tests\units /S /Q

mkdir %prjdir%\units

cd %prjdir%\units
for %%A in (fpc-qt fpc-rtl fpc-sys fpc-win) do ( mkdir .\%%A )
cd %prjdir%

mkdir %prjdir%\tests\units

echo =[ begin compile stage     ]=
%asmx64% -o%prjdir%\units\fpc-sys\fpcinit.o %prjdir%\sources\fpc-sys\fpcinit.asm

%fpcx64% %fpcdst% %fpcsys2% %fpcsys1% %fpcasm% -dwindll     -FE%prjdir%\units\fpc-sys %prjdir%\sources\fpc-sys\fpintres.pp
%fpcx64% %fpcdst% %fpcsys2% %fpcsys1% %fpcasm% -dwindll -Us -FE%prjdir%\units\fpc-sys %prjdir%\sources\fpc-sys\system.pas
%fpcx64% %fpcdst% %fpcsys2% %fpcsys1% %fpcasm% -dwindll     -FE%prjdir%\units\fpc-sys %prjdir%\sources\fpc-sys\sysinit.pas

%fpcx64% %fpcdst% %fpcsys2% %fpcsys1% -dwindll -FE%prjdir%\units\fpc-rtl %prjdir%\sources\fpc-rtl\RTL_Utils.pas

echo =[ build dll file...       ]=
%fpcx64% %fpcdst% %fpcsys2% %fpcsys1% -dwindll ^
-Fu%prjdir%\sources\fpc-qt ^
-FE%prjdir%\tests\units %prjdir%\tests\fpc_rtl.pas

cd %prjdir%\tests\units
SET THEFILE=system
echo Assembling %THEFILE%
%asmx64% -f win64 -o ^
%prjdir%\tests\units\system.o    -w-orphan-labels %prjdir%\tests\units\system.s
SET THEFILE=fpc_rtl
echo Assembling %THEFILE%
%asmx64% -f win64 -o ^
%prjdir%\tests\units\fpc_rtl.o   -w-orphan-labels %prjdir%\tests\units\fpc_rtl.s
SET THEFILE=%prjdir%\tests\units\fpc_rtl.dll
echo Linking %THEFILE%
%ld64% -b pei-x86-64  -s --dll --entry _DLLMainCRTStartup -o ^
%prjdir%\tests\units\fpc_rtl.dll ^
%prjdir%\tests\units\link.res
::
copy %prjdir%\tests\units\fpc_rtl.dll %prjdir%\tests\fpc_rtl.dll
::
echo =[ build exe file...       ]=
%fpcx64% %fpcdst% %fpcsys2% %fpcsys1% -dwinexe     -FE%prjdir%\tests\units %prjdir%\sources\fpc-sys\fpintres.pp
%fpcx64% %fpcdst% %fpcsys2% %fpcsys1% -dwinexe -Us -FE%prjdir%\tests\units %prjdir%\sources\fpc-sys\system.pas
%fpcx64% %fpcdst% %fpcsys2% %fpcsys1% -dwinexe     -FE%prjdir%\tests\units %prjdir%\sources\fpc-sys\sysinit.pas

%fpcx64% %fpcdst% %fpcsys2% %fpcsys1% -dwinexe     -FE%prjdir%\tests\units %prjdir%\sources\fpc-rtl\RTL_Utils.pas

SET THEFILE=sysinit
echo Assembling %THEFILE%
%asmx64% -f win64 -o ^
%prjdir%\tests\units\sysinit.o -w-orphan-labels ^
%prjdir%\tests\units\sysinit.s

%fpcx64% %fpcdst% %fpcsys1% %fpcsys2% -dwinexe -FE%prjdir%\tests\units %prjdir%\tests\test1.pas

echo Assembling %THEFILE%
%asmx64% -f win64 -o %prjdir%\tests\units\test1.o -w-orphan-labels  %prjdir%\tests\units\test1.s
SET THEFILE=%prjdir%\tests\units\test1.exe
echo Linking %THEFILE%
SET THEFILE=%prjdir%\tests\units\test1.exe
echo Linking %THEFILE%
%ld64% -b pei-x86-64 -s  --entry=_mainCRTStartup -o ^
%prjdir%\tests\units\test1.exe ^
%prjdir%\tests\units\link.res
::
copy %prjdir%\tests\units\test1.exe %prjdir%\tests\test1.exe
::
exit
echo =[ create map              ]=
grep "FPC_move" map.txt | awk '{print $1}'

echo =[ done                    ]=
