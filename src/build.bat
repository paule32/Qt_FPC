:: -----------------------------------------------------------------
:: File:   build.bat
:: Author: (c) 2023 Jens Kallup - paule32
:: All rights reserved
::
:: only for education, and non-profit usage !
:: -----------------------------------------------------------------
@echo on
setlocal enabledelayedexpansion

set fpcdir=C:\lazarus\x86_64\fpc\3.2.2\bin\x86_64-win64
set fpcx64=%fpcdir%\fpc.exe
set fpcstr=%fpcdir%\strip.exe

set fpcdst=-Twin64 -Mdelphi -dwindows -dwin64
set fpcasm=-Anasmwin64 -al

set fpcflags=%fpcdst% -b- -Sg -Sm -O2 -Os -vl ^
	-Fu.\units           ^
	-Fu.\units\rtl       ^
	-Fu.\sources\fpc-sys ^
	-Fu.\sources\fpc-rtl ^
	-Fu.\sources\fpc-qt

set fpcsys1=-Fu..\..\units\fpc-rtl -Fu..\..\units\fpc-sys -Fu..\..\units\fpc-win -Fu..\..\units\fpc-qt
set fpcsys2=-Fu..\units\fpc-rtl -Fu..\units\fpc-sys -Fu..\units\fpc-win -Fu..\units\fpc-qt

del .\units       /F /S /Q > nul
del .\tests\units /F /S /Q > nul

mkdir .\units
for %%A in (fpc-qt fpc-rtl fpc-sys fpc-win) do ( mkdir .\units\%%A > nul )
mkdir  .\tests\units > nul

nasm.exe -fwin64 -o.\units\fpc-sys\fpcinit.o .\sources\fpc-sys\fpcinit.asm

cd .\sources\fpc-sys
%fpcx64% %fpcdst% -O2 -Os -vl -Anasmwin64 -al -FE..\..\units\fpc-sys -Us system.pas
%fpcx64% %fpcdst% -O2 -Os -vl -Anasmwin64 -al -FE..\..\units\fpc-sys    sysinit.pas
%fpcx64% %fpcdst% -O2 -Os -vl -Anasmwin64 -al -FE..\..\units\fpc-sys   fpintres.pp
cd ..\..

cd .\sources\fpc-rtl
%fpcx64% %fpcdst% -O2 -Os -vl -Anasmwin64 -al %fpcsys1% -FE..\..\units\fpc-rtl RTL.pas
%fpcx64% %fpcdst% -O2 -Os -vl -Anasmwin64 -al %fpcsys1% -FE..\..\units\fpc-rtl RTL_DataCollection.pas
%fpcx64% %fpcdst% -O2 -Os -vl -Anasmwin64 -al %fpcsys1% -FE..\..\units\fpc-rtl RTL_Utils.pas
cd ..\..

cd .\sources\fpc-win
%fpcx64% %fpcdst% -O2 -Os -vl -Anasmwin64 -al %fpcsys1% -FE..\..\units\fpc-win RTL_Windows.pas
cd ..\..

cd .\sources\fpc-qt
%fpcx64% %fpcdst% -O2 -Os -vl -Anasmwin64 -al %fpcsys1% -FE..\..\units\fpc-qt Qt_Object.pas
%fpcx64% %fpcdst% -O2 -Os -vl -Anasmwin64 -al %fpcsys1% -FE..\..\units\fpc-qt Qt_String.pas
cd ..\..

cd .\tests
%fpcx64% %fpcdst% -O2 -Os -vl -Anasmwin64 -al %fpcsys2% -FE.\units test1.pas
cd ..

for %%A in (libimpsystem.a fpcinit.o sysinit.o system.s) do ( copy .\units\fpc-sys\%%A .\tests\units\%%A )

for %%A in (RTL RTL_Utils)       do ( copy .\units\fpc-rtl\%%A.s .\tests\units\%%A.s )
for %%A in (RTL_Windows)         do ( copy .\units\fpc-win\%%A.s .\tests\units\%%A.s )
for %%A in (Qt_Object Qt_String) do ( copy .\units\fpc-qt\%%A.s  .\tests\units\%%A.s )

cd .\tests
%fpcx64% %fpcdst% -O2 -Os -vl -Anasmwin64 -al -Fu.\units -FE.\units -XMmainCRTstartup ^
	-Fu..\units\fpc-sys   ^
	-Fu..\units\fpc-win   ^
	-Fu..\units\fpc-rtl   ^
	-Fu..\units\fpc-qt    ^
	test1.pas

cd ./units
grep -v "SECTION .fpc" test1.s > test2.s
grep -v "__fpc_ident"  test2.s > test1.s
rm test2.s

for %%A in (system RTL RTL_Windows RTL_Utils Qt_Object Qt_String test1) do (
    sed -i '/\; Begin asmlist al_dwarf_frame.*/,/\; End asmlist al_dwarf_frame.*/d'         %%A.s
    sed -i '/\; Begin asmlist al_indirectglobals.*/,/\; End asmlist al_indirectglobals.*/d' %%A.s
    sed -i '/\; Begin asmlist al_globals.*/,/\; End asmlist al_globals.*/d'                 %%A.s
    sed -i '/\; Begin asmlist al_rtti.*/,/\; End asmlist al_rtti.*/d'                       %%A.s
    sed -i '/\; Begin asmlist al_const.*/,/\; End asmlist al_const.*/d'                     %%A.s
    sed -i '/File.*/d' %%A.s
    grep ".*lea.*\[INIT\_" %%A.s | awk '{print $2}' | sed -e "s/^.*\[//" -e "s/\]$//" -e "1d" > tmp_file
    sort tmp_file | uniq > tmp_sort
    del  tmp_file /F /Q
    echo SECTION .data >> %%A.s
    for /F "tokens=*" %%b in (tmp_sort) do (
        echo %%b: dq 0 >> %%A.s
    )
)

grep ".*lea.*\[RTTI_.*\$P\$.*\$\$_def.*\]" test1.s | awk '{print $2}' | sed -e "s/^.*\[//" -e "s/.$//" -e "1d" > tmp_file
sort tmp_file | uniq > tmp_sort
del  tmp_file /F /Q
echo SECTION .data >> test1.s
for /F "tokens=*" %%a in (tmp_sort) do (
    echo %%a: dq 0 >> test1.s
)

for %%A in (system RTL RTL_Windows RTL_Utils Qt_Object Qt_String test1) do (
    nasm -f win64 -o %%A.o %%A.s
)

cd ..
copy ..\units\fpc-win\libimpRTL_Windows.a .\units\libimpRTL_Windows.a

x86_64-win64-ld.exe -b pei-x86-64 -nostdlib -s --entry=_mainCRTstartup -L.\units -o test1.exe test1.ld
%fpcstr%  test1.exe
