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
procedure TestTest; stdcall; external 'fpc_rtl.dll';

procedure Entry; stdcall; public name '_mainCRTStartup';
var
  s1, s2: String;
  p1, p2: PChar;
begin
    s1 := 'mufo   Lo aalo';
    s2 := 'Hello World  --> ' + s1;
    MessageBox(0,s2,s1,0);

    //TestTest;
    ExitProcess(0);
end;

begin
end.
