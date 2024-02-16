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

set fpcsys=-Fu..\..\units\fpc-rtl -Fu..\..\units\fpc-sys -Fu..\..\units\fpc-win -Fu..\..\units\fpc-qt

del .\units /F /S /Q

mkdir .\units
mkdir .\units\fpc-qt
mkdir .\units\fpc-rtl
mkdir .\units\fpc-sys
mkdir .\units\fpc-win

del .\tests\units /F /S /Q
mkdir  .\tests\units

nasm.exe -fwin64 -o.\units\fpc-sys\fpcinit.o .\sources\fpc-sys\fpcinit.asm

cd .\sources\fpc-sys
%fpcx64% %fpcdst% -O2 -Os -vl -Anasmwin64 -al -FE..\..\units\fpc-sys -Us system.pas
%fpcx64% %fpcdst% -O2 -Os -vl -Anasmwin64 -al -FE..\..\units\fpc-sys     objpas.pp
%fpcx64% %fpcdst% -O2 -Os -vl -Anasmwin64 -al -FE..\..\units\fpc-sys    sysinit.pas
%fpcx64% %fpcdst% -O2 -Os -vl -Anasmwin64 -al -FE..\..\units\fpc-sys   fpintres.pp
cd ..\..

cd .\sources\fpc-rtl
%fpcx64% %fpcdst% -O2 -Os -vl -Anasmwin64 -al -FE..\..\units\fpc-rtl %fpcsys% RTL_DataCollection.pas
cd ..\..

cd .\sources\fpc-win
%fpcx64% %fpcdst% -O2 -Os -vl -Anasmwin64 -al -FE..\..\units\fpc-win %fpcsys% RTL_Windows.pas
cd ..\..

cd .\sources\fpc-rtl
%fpcx64% %fpcdst% -O2 -Os -vl -Anasmwin64 -al -FE..\..\units\fpc-rtl %fpcsys% RTL_Utils.pas
cd ..\..

cd .\sources\fpc-qt
%fpcx64% %fpcdst% -O2 -vl -Anasmwin64 -al -FE..\..\units\fpc-qt Qt_Object.pas
cd ..\..

cd .\sources\fpc-qt
%fpcx64% %fpcdst% -O2 -vl -Anasmwin64 -al -FE..\..\units\fpc-qt Qt_String.pas
cd ..\..

cd .\tests
%fpcx64% %fpcdst% -O2 -vl -Anasmwin64 -al -Fu..\units\fpc-qt -FE.\units test1.pas
cd ..

copy .\units\fpc-sys\libimpsystem.a .\tests\units\libimpsystem.a

copy .\units\fpc-sys\fpcinit.o     .\tests\units\fpcinit.o
copy .\units\fpc-sys\sysinit.o     .\tests\units\sysinit.o

copy .\units\fpc-sys\system.s      .\tests\units\system.s

copy .\units\fpc-win\RTL_Windows.s .\tests\units\RTL_Windows.s
copy .\units\fpc-rtl\RTL_Utils.s   .\tests\units\RTL_Utils.s

copy .\units\fpc-qt\Qt_Object.s    .\tests\units\Qt_Object.s
copy .\units\fpc-qt\Qt_String.s    .\tests\units\Qt_String.s

cd .\tests
%fpcx64% %fpcdst% -O2 -Os -vl -Anasmwin64 -al -FE.\units -XMmainCRTstartup ^
	-Fu..\units\fpc-sys   ^
	-Fu..\units\fpc-win   ^
	-Fu..\units\fpc-rtl   ^
	-Fu..\units\fpc-qt    ^
	test1.o

cd ./units
grep -v "SECTION .fpc" test1.s > test2.s
grep -v "__fpc_ident"  test2.s > test1.s
rm test2.s

sed -i '/\; Begin asmlist al_dwarf_frame.*/,/\; End asmlist al_dwarf_frame.*/d' system.s
sed -i '/\; Begin asmlist al_indirectglobals.*/,/\; End asmlist al_indirectglobals.*/d' system.s
sed -i '/\; Begin asmlist al_rtti.*/,/\; End asmlist al_rtti.*/d' system.s

sed -i '/\; Begin asmlist al_dwarf_frame.*/,/\; End asmlist al_dwarf_frame.*/d' RTL_Windows.s
sed -i '/\; Begin asmlist al_indirectglobals.*/,/\; End asmlist al_indirectglobals.*/d' RTL_Windows.s
sed -i '/\; Begin asmlist al_rtti.*/,/\; End asmlist al_rtti.*/d' RTL_Windows.s

sed -i '/\; Begin asmlist al_dwarf_frame.*/,/\; End asmlist al_dwarf_frame.*/d' RTL_Utils.s
sed -i '/\; Begin asmlist al_indirectglobals.*/,/\; End asmlist al_indirectglobals.*/d' RTL_Utils.s
sed -i '/\; Begin asmlist al_rtti.*/,/\; End asmlist al_rtti.*/d' RTL_Utils.s

sed -i '/\; Begin asmlist al_dwarf_frame.*/,/\; End asmlist al_dwarf_frame.*/d' Qt_Object.s
sed -i '/\; Begin asmlist al_indirectglobals.*/,/\; End asmlist al_indirectglobals.*/d' Qt_Object.s
sed -i '/\; Begin asmlist al_globals.*/,/\; End asmlist al_globals.*/d' Qt_Object.s
sed -i '/\; Begin asmlist al_rtti.*/,/\; End asmlist al_rtti.*/d' Qt_Object.s
sed -i '/\; Begin asmlist al_const.*/,/\; End asmlist al_const.*/d' Qt_Object.s

sed -i '/\; Begin asmlist al_dwarf_frame.*/,/\; End asmlist al_dwarf_frame.*/d' Qt_String.s
sed -i '/\; Begin asmlist al_indirectglobals.*/,/\; End asmlist al_indirectglobals.*/d' Qt_String.s
sed -i '/\; Begin asmlist al_globals.*/,/\; End asmlist al_globals.*/d' Qt_String.s
sed -i '/\; Begin asmlist al_rtti.*/,/\; End asmlist al_rtti.*/d' Qt_String.s
sed -i '/\; Begin asmlist al_const.*/,/\; End asmlist al_const.*/d' Qt_String.s


sed -i '/\; Begin asmlist al_dwarf_frame.*/,/\; End asmlist al_dwarf_frame.*/d' test1.s
sed -i '/\; Begin asmlist al_indirectglobals.*/,/\; End asmlist al_indirectglobals.*/d' test1.s
sed -i '/\; Begin asmlist al_rtti.*/,/\; End asmlist al_rtti.*/d' test1.s
sed -i '/\; Begin asmlist al_globals.*/,/\; End asmlist al_globals.*/d' test1.s
sed -i '/File.*/d' test1.s

grep ".*lea.*\[RTTI_.*\$P\$.*\$\$_def.*\]" test1.s | awk '{print $2}' | sed -e "s/^.*\[//" -e "s/.$//" -e "1d" > tmp_file
sort tmp_file | uniq > tmp_sort
del  tmp_file /F /Q
echo SECTION .data >> test1.s
for /F "tokens=*" %%a in (tmp_sort) do (
    echo %%a: dq 0 >> test1.s
)

nasm -f win64 -o system.o      system.s

nasm -f win64 -o RTL_Windows.o RTL_Windows.s
nasm -f win64 -o RTL_Utils.o   RTL_Utils.s

nasm -f win64 -o Qt_Object.o   Qt_Object.s
nasm -f win64 -o Qt_String.o   Qt_String.s
nasm -f win64 -o test1.o       test1.s

cd ..
copy ..\units\fpc-win\libimpRTL_Windows.a .\units\libimpRTL_Windows.a

x86_64-win64-ld.exe -b pei-x86-64 -nostdlib -s --entry=_mainCRTstartup -L.\units -o test1.exe test1.ld
%fpcstr%  test1.exe
