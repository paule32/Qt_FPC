set fpcdir=C:\lazarus\x86_64\fpc\3.2.2\bin\x86_64-win64
set fpcx64=%fpcdir%\fpc.exe
set fpcstr=%fpcdir%\strip.exe

set fpcdst=-Twin64 -Mdelphi -dwindows -dwin64
set fpcasm=-Anasmwin64 -al

set fpcflags=%fpcdst% -b- -Sg -Sm -O2 -Os -vl ^
	-Fu./units           ^
	-Fu./units/rtl       ^
	-Fu./sources/fpc-sys ^
	-Fu./sources/fpc-rtl ^
	-Fu./sources/fpc-qt

rm -rf ./units

mkdir .\units
mkdir .\units\fpc-qt
mkdir .\units\fpc-rtl
mkdir .\units\fpc-sys

nasm.exe -fwin64 -o.\units\fpc-sys\fpcinit.o .\sources\fpc-sys\fpcinit.asm

cd ./sources/fpc-sys
%fpcx64% %fpcdst% -b- -Sg -Sm -O2 -Os -vl -Anasmwin64 -al -FE../../units/fpc-sys -Us system.pas
cd ../..

cd ./sources/fpc-rtl
%fpcx64% %fpcdst% -b- -Sg -Sm -O2 -Os -vl -Anasmwin64 -al -FE../../units/fpc-rtl rtl.utils.pas
cd ../..

cd ./sources/fpc-qt
%fpcx64% %fpcdst% -b- -Sg -Sm -O2 -Os -vl -Anasmwin64 -al -FE../../units/fpc-qt Qt.qObject.pas
cd ../..

copy .\units\fpc-sys\fpcinit.o   .\tests\units\fpcinit.o
copy .\units\fpc-qt\Qt.qObject.o .\tests\units\Qt.qObject.o
cd ./tests
%fpcx64% %fpcdst% -b- -Sg -Sm -O2 -Os -vl -Anasmwin64 -al -FE./units -XMmainCRTstartup ^
	-Fu../units/fpc-sys   ^
	-Fu../units/fpc-rtl   ^
	-Fu../units/fpc-qt    ^
	-Fu../sources/fpc-sys ^
	-Fu../sources/fpc-rtl ^
	-Fu../sources/fpc-qt  ^
	test1.pas

cd ./units
grep -v "SECTION .fpc" test1.s > test2.s
grep -v "__fpc_ident"  test2.s > test1.s
rm test2.s

sed -i '/\; Begin asmlist al_dwarf_frame.*/,/\; End asmlist al_dwarf_frame.*/d' system.s
sed -i '/\; Begin asmlist al_indirectglobals.*/,/\; End asmlist al_indirectglobals.*/d' system.s
sed -i '/\; Begin asmlist al_rtti.*/,/\; End asmlist al_rtti.*/d' system.s

sed -i '/\; Begin asmlist al_dwarf_frame.*/,/\; End asmlist al_dwarf_frame.*/d' test1.s
sed -i '/\; Begin asmlist al_rtti.*/,/\; End asmlist al_rtti.*/d' test1.s
sed -i '/File.*/d' test1.s

nasm -f win64 -o system.o system.s
nasm -f win64 -o test1.o  test1.s

cd ..
x86_64-win64-ld.exe -b pei-x86-64 -nostdlib -s --entry=_mainCRTstartup -o test1.exe test1.ld

::copy .\tests\units\test1.exe .\tests\test1.exe
%fpcstr%   test1.exe