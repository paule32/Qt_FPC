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

cd %prjdir1%

echo =[ clean up directories    ]=
del   %prjdir1%\units       /F /S /Q
del   %prjdir1%\tests\units /F /S /Q

del   %prjdir1%\tmp  /F /S /Q
rmdir %prjdir1%\tmp   F /S /Q

rmdir %prjdir1%\units       /S /Q
rmdir %prjdir1%\tests\units /S /Q

mkdir %prjdir1%\units
mkdir %prjdir1%\tmp

cd %prjdir1%\units
for %%A in (fpc-qt fpc-rtl fpc-sys fpc-win) do ( mkdir .\%%A )
cd %prjdir1%

mkdir %prjdir1%\tests\units

echo =[ begin compile stage     ]=
%asmx64% -o%prjdir1%\units\fpc-sys\fpcinit.o %prjdir1%\sources\fpc-sys\fpcinit.asm
%asmx64% -o%prjdir1%\units\fpc-sys\fpcdll.o  %prjdir1%\sources\fpc-sys\fpcdll.asm

%fpcx64% %fpcdst% %fpcsys2% %fpcsys1% %fpcasm% -dwindll     -FE%prjdir1%\units\fpc-sys %prjdir1%\sources\fpc-sys\fpintres.pp
%fpcx64% %fpcdst% %fpcsys2% %fpcsys1% %fpcasm% -dwindll     -FE%prjdir1%\units\fpc-sys %prjdir1%\sources\fpc-sys\sysinit.pas
%fpcx64% %fpcdst% %fpcsys2% %fpcsys1% %fpcasm% -dwindll -Us -FE%prjdir1%\units\fpc-sys %prjdir1%\sources\fpc-sys\system.pas

cd %prjdir1%\units\fpc-sys
for %%A in (system) do (
    sed -i '/\;.*\n$/d' %%A.s
    sed -i '/^%LINE.*\n$/d' system.s
    sed -i '/\; Begin asmlist al_dwarf_frame.*/,/\; End asmlist al_dwarf_frame.*/d' %%A.s
    sed -i '/\; Begin asmlist al_rtti.*/,/\; End asmlist al_rtti.*/d' %%A.s
    sed -i '/\; Begin asmlist al_globals.*/,/\; End asmlist al_globals.*/d' %%A.s
    sed -i '/\; Begin asmlist al_indirectglobals.*/,/\; End asmlist al_indirectglobals.*/d' %%A.s
    sed -i '/File.*/d' %%A.s
)
%asmx64% -o %prjdir1%\units\fpc-sys\system.o  %prjdir1%\units\fpc-sys\system.s
%asmx64% -o %prjdir1%\units\fpc-sys\sysinit.o %prjdir1%\units\fpc-sys\sysinit.s

%fpcx64% %fpcdst% %fpcsys2% %fpcsys1% -dwinexe -FE%prjdir1%\units\fpc-rtl ^
    %prjdir1%\sources\fpc-rtl\RTL_Utils.pas

%asmx64% -o %prjdir1%\units\fpc-rtl\TQueue_extern.o %prjdir1%\sources\fpc-rtl\TQueue_extern.asm
%asmx64% -o %prjdir1%\units\fpc-rtl\RTL_Utils.o %prjdir1%\units\fpc-rtl\RTL_Utils.s

echo =[ build dll file...       ]=
%fpcx64% %fpcdst% %fpcsys1% -dwindll -XMDLLMainCRTStartup -FE%prjdir1%\tests\units %prjdir1%\tests\fpc_rtl.pas
copy %prjdir1%\units\fpc-rtl\*.o %prjdir1%\tmp\
copy %prjdir1%\units\fpc-sys\*.o %prjdir1%\tmp\
copy %prjdir1%\units\fpc-sys\*.a %prjdir1%\tmp\
copy %prjdir1%\units\fpc-win\*.o %prjdir1%\tmp\

%gcc64% -shared -nostdlib -o %prjdir2%/tests/units/fpc_rtl.dll %prjdir2%/tmp/*.o -L%prjdir2%/tmp -limpsystem
%strip% %prjdir2%/tests/units/fpc_rtl.dll
upx   %prjdir2%/tests/fpc_rtl.dll

::
echo =[ build exe file...       ]=
%fpcx64% %fpcdst% %fpcsys2% %fpcsys1% %fpcasm% -dwinexe -Us -FE%prjdir1%\units\fpc-sys %prjdir1%\sources\fpc-sys\system.pas

cd %prjdir1%\units\fpc-sys
for %%A in (system) do (
    sed -i '/\;.*\n$/d' %%A.s
    sed -i '/^%LINE.*\n$/d' system.s
    sed -i '/\; Begin asmlist al_dwarf_frame.*/,/\; End asmlist al_dwarf_frame.*/d' %%A.s
    sed -i '/\; Begin asmlist al_rtti.*/,/\; End asmlist al_rtti.*/d' %%A.s
    sed -i '/\; Begin asmlist al_globals.*/,/\; End asmlist al_globals.*/d' %%A.s
    sed -i '/\; Begin asmlist al_indirectglobals.*/,/\; End asmlist al_indirectglobals.*/d' %%A.s
    sed -i '/File.*/d' %%A.s
)

%asmx64% -o %prjdir1%\units\fpc-sys\system.o  %prjdir1%\units\fpc-sys\system.s
%fpcx64% %fpcdst% %fpcsys1% -dwinexe -FE%prjdir1%\tests\units %prjdir1%\tests\test1.pas
%strip% %prjdir2%/tests/units/test1.exe

::
exit
echo =[ create map              ]=
grep "FPC_move" map.txt | awk '{print $1}'

echo =[ done                    ]=
