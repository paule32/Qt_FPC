:: -----------------------------------------------------------------
:: File:   build.bat
:: Author: (c) 2024 Jens Kallup - paule32
:: All rights reserved
::
:: only for education, and non-profit usage !
::
:: Rhis batch file is optimized for a 64-Bit compilation, only.
:: I did not test other tools for 32-Bit or operating systems other
:: than Microsoft Windows 10/11 64-Bit Professional.
::
:: For compile this project you must have a minimum of:
:: - a copy of FPC 3.2.0 64-Bit Microsoft Windows 10/11 64-Bit
:: - a copy of NASM for Windows 10/11 (netwide assembler)
:: - a copy of MSYS2 64-Bit with installed gcc.exe MinGW-64 Bit
:: - a copy of msys2 tools like awk, sed, ...
::
:: You have to start the build.ps1 script, firstly. PowerShell will
:: call this script with all the setting parameters.
:: So, dont touch a running system - I give no warantees of damages
:: or other fees.
:: !!! YOU USE IT AT YOUR OWN RISK !!!
:: -----------------------------------------------------------------
::@echo off
setlocal enabledelayedexpansion

:: -----------------------------------------------------------------
:: developer project directory => location of the fpc-qt project ...
:: -----------------------------------------------------------------
set prjdir=E:\Projekte\fpc-qt\src

:: -----------------------------------------------------------------
:: fpcdir1/2 => location of fpc.exe compiler tools ...
:: -----------------------------------------------------------------
set fpcdir1=E:\FPC\3.2.0\bin\i386-win32
set fpcdir2=E:\fpc\3.2.2\bin\i386-win32

set gccdir1=E:\msys64\mingw32\bin
set gccdir2=E:\msys64\mingw64\bin

set asmdir=E:\nasm

set fpcdir=%fpcdir1%
set gccdir=%gccdir2%
set gdbdir=%gccdir2%

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
set asmx32=%asmdir%\nasm.exe -f win32 -w-orphan-labels
set asmx64=%asmdir%\nasm.exe -f win64 -w-orphan-labels

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
set ld64=%fpcdir%\ld64.exe -b pei-x86-64 --subsystem windows

:: -----------------------------------------------------------------
:: as32.exe is a copy of fpc 3.2 tool as.exe (32-Bit)
:: as64.exe is a copy of fpc 3.2 tool as.exe (64-Bit)
::
:: the files was manualy copied from a 32-Bit, and 64-Bit Relase
:: -----------------------------------------------------------------
set as32=%fpcdir%\as32.exe
set as64=%fpcdir%\as64.exe

:: -----------------------------------------------------------------
:: gcc32.exe is a copy of gcc tool gcc.exe (32-Bit)
:: gcc64.exe is a copy of gcc tool gcc.exe (64-Bit)
::
:: the files was manualy copied from a 32-Bit, and 64-Bit Relase
:: -----------------------------------------------------------------
set gcc32=%gccdir1%\gcc.exe
set gcc64=%gccdir2%\gcc.exe

set gdb32=%gccdir1%\gdb.exe
set gdb64=%gccdir2%\gdb.exe

:: -----------------------------------------------------------------
:: strip32.exe is a copy of fpc 3.2 tool strip.exe (32-Bit)
:: strip64.exe is a copy of fpc 3.2 tool strip.exe (64-Bit)
::
:: the files was manualy copied from a 32-Bit, and 64-Bit Relase
:: -----------------------------------------------------------------
set strip32=%fpcdir%\strip32.exe
set strip64=%fpcdir%\strip64.exe

set dlltool=%fpcdir%\dlltool.exe

set punits=%prjdir%\units
set sunits=%prjdir%\sources

set srcsys=-FE%punits%\fpc-sys %sunits%\fpc-sys
set srcrtl=-FE%punits%\fpc-rtl %sunits%\fpc-rtl

set sysrtl=%punits%\fpc-rtl

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
%fpcx64% -dwindll %srcrtl%\rtl_utils.pas

echo =[ build dll file...      ]=
%fpcx64% -dwindll ^
-Fu%prjdir%\sources\fpc-qt ^
-FE%prjdir%\units\fpc-rtl %prjdir%\tests\fpc_rtl.pas
if errorlevel 1 goto buildError

echo Assembling dll files ...
copy %punits%\fpc-sys\fpcinit.s %sysrtl%\fpcinit.s

:: todo => sed
for %%A in (system fpcinit rtl_utils fpc_rtl) do (
    %asmx64% -o %sysrtl%\%%A.o %sysrtl%\%%A.s
)
echo Linking fpc_rtl.dll ...

%gcc64% -nostdlib -shared -o %prjdir%\tests\fpc_rtl.dll ^
%sysrtl%\system.o    ^
%sysrtl%\fpcinit.o   ^
%sysrtl%\fpc_rtl.o   ^
%sysrtl%\rtl_utils.o ^
-L %sysrtl% -l impsystem

%ld64% --shared --dll --entry _DLLMainCRTStartup -o ^
%prjdir%\tests\fpc_rtl.dll2 ^
%prjdir%\units\fpc-rtl\link.res

::set PYTHONHOME=
::%gdb32% %prjdir%\tests\fpc_rtl.dll

echo =[ build exe file...      ]=
::
%fpcx64% -dwinexe -Us %srcsys%\system.pas
%fpcx64% -dwinexe     %srcsys%\fpintres.pp
::
for %%A in (fpcinit sysinit) do (
    %fpcx64% -dwinexe %srcsys%\%%A.pas
)
%fpcx64% -dwinexe %srcrtl%\rtl_utils.pas
%fpcx64% -dwinexe -FE%prjdir%\tests\units %prjdir%\tests\test1.pas

echo Assembling exe files ...

copy %punits%\fpc-sys\fpcinit.s %sysrtl%\fpcinit.s

:: todo => sed
for %%A in (system fpcinit rtl_utils fpc_rtl) do (
    %asmx64% -o %sysrtl%\%%A.o %sysrtl%\%%A.s
)
%asmx64% -o %prjdir%\tests\units\system.o %prjdir%\tests\units\system.s
%asmx64% -o %prjdir%\tests\units\test1.o  %prjdir%\tests\units\test1.s

echo Linking test1.exe

%gcc64% -nostdlib -o ^
%prjdir%\tests\test1.exe ^
%prjdir%\tests\units\test1.o ^
%sysrtl%\system.o    ^
%sysrtl%\fpcinit.o   ^
%sysrtl%\rtl_utils.o ^
-L %prjdir%\tests\units -l impsystem -l imptest1

%ld64% --entry _mainCRTStartup -o ^
%prjdir%\tests\test2.exe ^
%prjdir%\tests\units\link.res

goto allok
::if errorlevel 1 goto linkError
::goto allok
::echo =[ create map ]=
::grep "FPC_move" map.txt | awk '{print $1}'
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
