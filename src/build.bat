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
:: parameters for fpc.exe ...
:: -----------------------------------------------------------------
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
set fpcx32=%fpcdir%\fpc32.exe %fpcdst% %fpcsys2% %fpcsys1% %fpcasm%
set fpcx64=%fpcdir%\fpc64.exe %fpcdst% %fpcsys2% %fpcsys1% %fpcasm%

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

set srcsys=-FE%prjdir%\units\fpc-sys %prjdir%\sources\fpc-sys
set srcrtl=-FE%prjdir%\units\fpc-rtl %prjdir%\sources\fpc-rtl

cd %prjdir%

echo =[ clean up directories   ]=
del   %prjdir%\units        /F /S /Q
del   %prjdir%\tests\units  /F /S /Q
del   %prjdir%\tests\fpc_rtl.dll  /F /S /Q
del   %prjdir%\tests\test1,exe    /F /S /Q

rmdir %prjdir%\units /S /Q
rmdir %prjdir%\units /S /Q

mkdir %prjdir%\units
mkdir %prjdir%\tests\units

cd %prjdir%\units
for %%A in (fpc-qt fpc-rtl fpc-sys fpc-win) do ( mkdir .\%%A )
cd %prjdir%

echo =[ begin compile stage    ]=
%fpcx64% -dwindll -Us %srcsys%\system.pas
%fpcx64% -dwindll     %srcsys%\fpintres.pp
::
for %%A in (fpcinit sysinit) do (
    %fpcx64% -dwindll %srcsys%\%%A.pas
)
%fpcx64% %fpcasm% -dwindll %srcrtl%\RTL_Utils.pas

echo =[ build dll file...      ]=
%fpcx64% %fpcdst% %fpcsys2% %fpcsys1% -dwindll ^
-Fu%prjdir%\sources\fpc-qt ^
-FE%prjdir%\units\fpc-rtl %prjdir%\tests\fpc_rtl.pas
if errorlevel 1 goto buildError
goto zuzu
cd %prjdir%\tests\units
SET THEFILE=system
echo Patch %THEFILE%
for %%A in ( system fpc_rtl ) do (
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
awk "NR > 3 { print }" < %prjdir%\tests\units\system.s > system.s1

echo BITS 64     >  %prjdir%\tests\units\system.s2
echo default rel >> %prjdir%\tests\units\system.s2
echo CPU x64     >> %prjdir%\tests\units\system.s2

echo EXTERN  VMT_$SYSTEM_$$_QSTRING >> %prjdir%\tests\units\system.s2

type %prjdir%\tests\units\system.s1 >> %prjdir%\tests\units\system.s2
type %prjdir%\tests\units\system.s2 >  %prjdir%\tests\units\system.s

:zuzu
echo Assembling dll files ...

%asmx64% -o ^
%prjdir%\units\fpc-sys\system.o  -w-orphan-labels ^
%prjdir%\units\fpc-sys\system.s

for %%A in (fpcinit fpc_rtl) do (
    %asmx64% -f win64 -o ^
    %prjdir%\units\fpc-rtl\%%A.o -w-orphan-labels ^
    %prjdir%\units\fpc-rtl\%%A.s
)
echo fpc_rtl.dll ...
%ld64% -b pei-x86-64  -shared -s --dll --entry _DLLMainCRTStartup -o ^
%prjdir%\tests\fpc_rtl.dll ^
%prjdir%\units\fpc-rtl\link.res


echo =[ build exe file...      ]=
%fpcx64% -dwinexe -Us %srcsys%\system.pas
for %%A in (fpintres fpcinit sysinit) do (
    %fpcx64% -dwinexe %srcsys%\%%A.pas
)
%fpcx64% -dwinexe %srcrtl%\RTL_Utils.pas
::
%fpcx64% -dwinexe -FE%prjdir%\tests\units %prjdir%\tests\test1.pas

echo Assembling exe files ...
%asmx64% -o ^
%prjdir%\tests\units\test1.o -w-orphan-labels ^
%prjdir%\tests\units\test1.s

echo Linking test1.exe
copy %prjdir%\units\fpc-sys\system.o %prjdir%\tests\units\system.o
%ld64% -b pei-x86-64 -s  --entry _mainCRTStartup -o ^
%prjdir%\tests\test1.exe ^
%prjdir%\tests\units\link.res
if errorlevel 1 goto linkError
goto allok
echo =[ create map ]=
grep "FPC_move" map.txt | awk '{print $1}'
:buildError
echo =[ build error ]=
goto eof
:linkError
echo =[ link error ]=
goto eof
:allok
echo =[ done ]=
goto eof
:eof
