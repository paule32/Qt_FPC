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
    TTestTest = procedure; stdcall;
    
procedure Entry; stdcall; public name '_mainCRTStartup';
var
    s1, s2: String;
    p1, p2: PChar;
    hm: HMODULE;
    ap: TTestTest;
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
        ap := GetProcAddress(@hm, 'TestTest');
        MessageBox(0,'fufu','fafainfo',0);
        if @ap = nil then begin
            MessageBox(0,'getprocaddress error','Error',0);
            FreeLibrary(HM);
            ExitProcess(0);
        end else begin
            MessageBox(0,'start','info',0);
            ap;
        end;
    end;
    FreeLibrary(HM);
    
    ExitProcess(0);
end;

begin
end.
