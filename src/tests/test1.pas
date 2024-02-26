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
  
procedure test;
var
  q: QObject;
//  b: Array of Byte;
begin
//  SetLength(b,16);
  //q := new QObject;
  q.Free;
end;

begin
  MessageBox(0,'halllo','toitt',0);
  hmod := LoadLibrary( 'test2.dll' );
  FreeLibrary( hmod );
end.
