:: -----------------------------------------------------------------
:: File:   build.bat
:: Author: (c) 2024 Jens Kallup - paule32
:: All rights reserved
::
:: only for education, and non-profit usage !
:: -----------------------------------------------------------------
::@echo off
setlocal enabledelayedexpansion

set fpcdir=C:\lazarus\x86_64\fpc\3.2.2\bin\x86_64-win64
set fpcx64=%fpcdir%\fpc.exe
set fpcstr=%fpcdir%\strip.exe

set fpcdst=-Twin64 -Mdelphi -dwindows -dwin64 -v0 -Fi..\fpc-win -Fi..\fpc-rtl
set fpcasm=-Anasmwin64 -al

set fpcsys1=-Fu..\..\units\fpc-rtl -Fu..\..\units\fpc-sys -Fu..\..\units\fpc-win -Fu..\..\units\fpc-qt
set fpcsys2=-Fu..\units\fpc-rtl -Fu..\units\fpc-sys -Fu..\units\fpc-win -Fu..\units\fpc-qt

echo =[ clean up directories    ]=
del   .\units       /F /S /Q
del   .\tests\units /F /S /Q

rmdir .\units       /S /Q
rmdir .\tests\units /S /Q

mkdir .\units > nul:
cd .\units
for %%A in (fpc-qt fpc-rtl fpc-sys fpc-win) do ( mkdir .\%%A )
cd ..
mkdir .\tests\units

echo =[ begin compile stage     ]=
nasm.exe -fwin64 -o.\units\fpc-sys\fpcinit.o .\sources\fpc-sys\fpcinit.asm
nasm.exe -fwin64 -o.\units\fpc-sys\fpcdll.o  .\sources\fpc-sys\fpcdll.asm
nasm.exe -fwin64 -o.\units\fpc-win\RTL_crt.o .\sources\fpc-win\RTL_crt.asm

copy .\units\fpc-win\RTL_crt.o .\tests\units\RTL_crt.o

cd .\sources\fpc-sys
%fpcx64% %fpcdst% -O2 -Os -vl -Anasmwin64 -al -FE..\..\units\fpc-sys -dwinexe -Us system.pas
%fpcx64% %fpcdst% -O2 -Os -vl -Anasmwin64 -al -FE..\..\units\fpc-sys -dwinexe   sysinit.pas
%fpcx64% %fpcdst% -O2 -Os -vl -Anasmwin64 -al -FE..\..\units\fpc-sys -dwinexe  fpintres.pp
cd ..\..

cd .\sources\fpc-rtl
%fpcx64% %fpcdst% -O2 -Os -vl -Anasmwin64 -al %fpcsys1% -dwinexe -FE..\..\units\fpc-rtl RTL_Utils.pas
cd ..\..

cd .\tests\units

::
nasm -f win64 -o system.o     ..\..\units\fpc-sys\system.s
nasm -f win64 -o RTL_Utils.o  ..\..\units\fpc-rtl\RTL_Utils.s

cd ..
%fpcx64% %fpcdst% -O2 -Os -vl -Anasmwin64 -al %fpcsys2% -dwinexe -Fu.\units -FE.\units test1.pas
cd units

::
nasm -f win64 -o system.o     ..\..\units\fpc-sys\system.s
nasm -f win64 -o RTL_Utils.o  ..\..\units\fpc-rtl\RTL_Utils.s

cd ..

echo =[ create map              ]=
grep "FPC_move" map.txt | awk '{print $1}'

echo =[ done                    ]=
