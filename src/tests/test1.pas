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
procedure PascalMain; external name 'PASCALMAIN';

procedure TestTest; stdcall; external 'fpc_rtl.dll' name 'TestTest';

var
  s1, s2: String;
  p1, p2: PChar;

procedure Entry; stdcall; public name '_mainCRTStartup';
begin
    s1 := 'mufo   Lo aa';
    s2 := 'Hello World  --> ' + s1;
    MessageBox(0,s2,s1,0);

    PascalMain;
    ExitProcess(0);
end;

begin
  s1 := 'mufoLo';
  s2 := 'Hello World  --> ' + s1;
  MessageBox(0,s2,s1,0);

  TestTest;

  //move(p1, p2, sizeof( char ));
end.
