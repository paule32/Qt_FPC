// -----------------------------------------------------------------
// File:   test1.pas
// Author: (c) 2023 Jens Kallup - paule32
// All rights reserved
//
// only for education, and non-profit usage !
// -----------------------------------------------------------------
{$mode delphi}
program test1;

// ---------------------------------------------------------------------------
// core Pascal entry point stuff:
// ---------------------------------------------------------------------------
//function LoadLibrary( lpLibFileName: LPCSTR ): HMODULE; stdcall; external 'kernel32.dll' name 'LoadLibraryA';
//function FreeLibrary( hLibModule: HMODULE ): BOOL;      stdcall; external 'kernel32.dll' name 'FreeLibrary';

//function GetProcAddress(modulname: HMODULE; lpProcName: LPCSTR): FARPROC; stdcall; external 'kernel32.dll' name 'GetProcAddress';

type
    TTestTest = procedure(); stdcall;
    
procedure Entry; stdcall; public name '_mainCRTStartup';
var
    s1, s2: String;
    p1, p2: PChar;
    hm: HMODULE;
    ap: TTestTest;
    p : Pointer;
begin
    s1 := 'mufo   Lo aalo';
    s2 := 'Hello World  --> ' + s1;
    MessageBox(0,s2,s1,0);

    HM := LoadLibrary('fpc_rtl.dll');
    if @HM = nil then begin
        MessageBox(0,'dll error','Error',0);
        ExitProcess(0);
    end else begin
        MessageBox(0,'dll load ok','Information',0);
        p := GetProcAddress(hm, 'P$FPC_RTL_$$_TESTTEST');
        ap := @P;
        if @p = nil then begin
            MessageBox(0,'getprocaddress error','Error',0);
            FreeLibrary(HM);
            ExitProcess(0);
        end else begin
            MessageBox(0,'start22','info',0);
            ap;
            MessageBox(0,'start2 1111 222','info',0);
        end;
    end;
    FreeLibrary(HM);
    
    ExitProcess(0);
end;

begin
end.
