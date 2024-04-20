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
    s2 := 'Hello World  --> ' + 'hiho';
    MessageBox(0,s2,s1,0);

    HM := LoadLibrary('fpc_rtl.dll');
    if HM = nil then begin
        MessageBox(0,'dll error','Error',0);
        ExitProcess(4);
    end else begin
        MessageBox(0,'dll load ok','Information',0);
        // todo !!!
    end;

    FreeLibrary(HM);
    ExitProcess(0);
end;

begin
end.
