:: -----------------------------------------------------------------
:: File:   build.bat
:: Author: (c) 2024 Jens Kallup - paule32
:: All rights reserved
::
:: only for education, and non-profit usage !
:: -----------------------------------------------------------------
@echo off
setlocal enabledelayedexpansion

set fpcdir=C:\lazarus\x86_64\fpc\3.2.2\bin\x86_64-win64
set fpcx64=%fpcdir%\fpc.exe
set fpcstr=%fpcdir%\strip.exe

set fpcdst=-Twin64 -Mdelphi -dwindows -dwin64 -v0 -dwindll
set fpcasm=-Anasmwin64 -al

set fpcsys1=-Fu..\..\units\fpc-rtl -Fu..\..\units\fpc-sys -Fu..\..\units\fpc-win -Fu..\..\units\fpc-qt
set fpcsys2=-Fu..\units\fpc-rtl -Fu..\units\fpc-sys -Fu..\units\fpc-win -Fu..\units\fpc-qt

echo =[ clean up directories    ]=
del   .\units       /F /S /Q > nul:
del   .\tests\units /F /S /Q > nul:

rmdir .\units       /S /Q > nul:
rmdir .\tests\units /S /Q > nul:

mkdir .\units > nul:
cd .\units
for %%A in (fpc-qt fpc-rtl fpc-sys fpc-win) do ( mkdir .\%%A > nul: )
cd ..
mkdir .\tests\units > nul:

echo =[ begin compile stage     ]=
nasm.exe -fwin64 -o.\units\fpc-sys\fpcinit.o .\sources\fpc-sys\fpcinit.asm
nasm.exe -fwin64 -o.\units\fpc-sys\fpcdll.o  .\sources\fpc-sys\fpcdll.asm

cd .\sources\fpc-sys
%fpcx64% %fpcdst% -O2 -Os -vl -Anasmwin64 -al -FE..\..\units\fpc-sys -Us system.pas > nul
%fpcx64% %fpcdst% -O2 -Os -vl -Anasmwin64 -al -FE..\..\units\fpc-sys    sysinit.pas > nul
%fpcx64% %fpcdst% -O2 -Os -vl -Anasmwin64 -al -FE..\..\units\fpc-sys   fpintres.pp  > nul
cd ..\..

cd .\sources\fpc-rtl
%fpcx64% %fpcdst% -O2 -Os -vl -Anasmwin64 -al %fpcsys1% -FE..\..\units\fpc-rtl RTL.pas > nul
%fpcx64% %fpcdst% -O2 -Os -vl -Anasmwin64 -al %fpcsys1% -FE..\..\units\fpc-rtl RTL_Memory.pas > nul
%fpcx64% %fpcdst% -O2 -Os -vl -Anasmwin64 -al %fpcsys1% -FE..\..\units\fpc-rtl RTL_DataCollection.pas > nul
%fpcx64% %fpcdst% -O2 -Os -vl -Anasmwin64 -al %fpcsys1% -FE..\..\units\fpc-rtl RTL_Utils.pas > nul
cd ..\..

cd .\sources\fpc-win
%fpcx64% %fpcdst% -O2 -Os -vl -Anasmwin64 -al %fpcsys1% -FE..\..\units\fpc-win RTL_Windows.pas > nul
cd ..\..

cd .\sources\fpc-qt
%fpcx64% %fpcdst% -O2 -Os -vl -Anasmwin64 -al %fpcsys1% -FE..\..\units\fpc-qt Qt_Object.pas > nul
%fpcx64% %fpcdst% -O2 -Os -vl -Anasmwin64 -al %fpcsys1% -FE..\..\units\fpc-qt Qt_String.pas > nul
cd ..\..

cd .\tests
%fpcx64% %fpcdst% -O2 -Os -vl -Anasmwin64 -al %fpcsys2% -FE.\units test1.pas > nul
cd ..

for %%A in (
    libimpsystem.a fpcdll.o fpcinit.o sysinit.o system.s
) do ( copy .\units\fpc-sys\%%A .\tests\units\%%A > nul)

for %%A in (RTL RTL_Memory RTL_Utils) do ( copy .\units\fpc-rtl\%%A.s .\tests\units\%%A.s > nul)
for %%A in (RTL_Windows)         do ( copy .\units\fpc-win\%%A.s .\tests\units\%%A.s > nul)
for %%A in (Qt_Object Qt_String) do ( copy .\units\fpc-qt\%%A.s  .\tests\units\%%A.s > nul)

cd .\tests
%fpcx64% %fpcdst% -O2 -Os -vl -Anasmwin64 -al %fpcsys2% -Fu.\units -FE.\units -XMmainCRTstartup test1.pas > nul
%fpcx64% %fpcdst% -O2 -Os -vl -Anasmwin64 -al %fpcsys2% -Fu.\units -FE.\units -XMmainCRTstartup test2.pas > nul

echo =[ shrink data information ]=
cd .\units
grep -v "SECTION .fpc" test1.s  > test1_.s
grep -v "__fpc_ident"  test1_.s > test1.s
rm test1_.s
grep -v "SECTION .fpc" test2.s  > test2_.s
grep -v "__fpc_ident"  test2_.s > test2.s
rm test2_.s

for %%A in (system RTL RTL_Memory RTL_Windows RTL_Utils Qt_Object Qt_String test1 test2) do (
    sed -i '/\; Begin asmlist al_dwarf_frame.*/,/\; End asmlist al_dwarf_frame.*/d'         %%A.s > nul
    sed -i '/\; Begin asmlist al_indirectglobals.*/,/\; End asmlist al_indirectglobals.*/d' %%A.s > nul
    sed -i '/\; Begin asmlist al_globals.*/,/\; End asmlist al_globals.*/d'                 %%A.s > nul
    sed -i '/\; Begin asmlist al_rtti.*/,/\; End asmlist al_rtti.*/d'                       %%A.s > nul
    sed -i '/\; Begin asmlist al_const.*/,/\; End asmlist al_const.*/d'                     %%A.s > nul
    sed -i '/File.*/d' %%A.s 2> nul
    grep ".*lea.*\[INIT\_" %%A.s | awk '{print $2}' | sed -e "s/^.*\[//" -e "s/\]$//" -e "1d" > tmp_file
    sort tmp_file | uniq > tmp_sort
    del  tmp_file /F /Q > nul
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

for %%A in (system RTL RTL_Memory RTL_Windows RTL_Utils Qt_Object Qt_String test1 test2) do (
    nasm -f win64 -o %%A.o %%A.s > nul
)

cd ..
copy ..\units\fpc-win\libimpRTL_Windows.a .\units\libimpRTL_Windows.a > nul

x86_64-win64-ld.exe    -b pei-x86-64 -nostdlib -s -o test1.exe -T test.exe.ld > nul
x86_64-win64-ld.exe -M -b pei-x86-64 -nostdlib -s -o test2.dll -T test.dll.ld > map.txt

echo =[ create map              ]=
grep "FPC_move" map.txt | awk '{print $1}'

echo =[ done                    ]=
