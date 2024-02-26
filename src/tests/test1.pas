// -----------------------------------------------------------------
// File:   test1.pas
// Author: (c) 2023 Jens Kallup - paule32
// All rights reserved
//
// only for education, and non-profit usage !
// -----------------------------------------------------------------
{$mode delphi}
program test1;

var
  hmod: HMODULE;

procedure zum; stdcall; external 'test2.dll' name 'test';
procedure test;
//var
//  q: QObject;
//  b: Array of Byte;
begin
//  SetLength(b,16);
  //q := new QObject;
//  q.Free;
MessageBox(0,'halllo','toitt',0);
zum;
end;

begin
  test;
  //hmod := LoadLibrary( 'test2.dll' );
  //if hmod <> nil then MessageBox(0,'xxxxxxxxx','222',0);
  //FreeLibrary( hmod );
end.
