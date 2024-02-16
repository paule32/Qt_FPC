// -----------------------------------------------------------------
// File:   test1.pas
// Author: (c) 2023 Jens Kallup - paule32
// All rights reserved
//
// only for education, and non-profit usage !
// -----------------------------------------------------------------
{$mode objfpc}
program test1;

uses
  Qt_Object;

procedure test;
var
  q: QObject;
  b: Array of Byte;
begin
  SetLength(b,16);
  q := QObject.Create;
  q.Free;
end;

begin
  test;
end.
