// -----------------------------------------------------------------
// File:   test1.pas
// Author: (c) 2023 Jens Kallup - paule32
// All rights reserved
//
// only for education, and non-profit usage !
// -----------------------------------------------------------------
{$mode delphi}
program test1;

type
    TTestTest = procedure;

procedure Entry; stdcall; public name '_mainCRTStartup';
var
    s1, s2: PChar;
    hm: HMODULE;
    ap: procedure;
begin
    s1 := 'mufo   Lo aalo';
    s2 := 'Hello World  --> ';
    MessageBox(0,s2,s1,0);

    HM := LoadLibrary('fpc_rtl.dll');
    if HM = nil then begin
        MessageBox(0,'dll error','Error',0);
        ExitProcess(4);
    end else begin
        MessageBox(0,'dll load ok','Information',0);
        ap := GetProcAddress(hm, 'TestTest' ); //'P$FPC_RTL_$$_TESTTEST');
        MessageBox(0,'start2 1111 222','info',0);
    end;
    FreeLibrary(HM);
    
    ExitProcess(0);
end;

begin
end.
