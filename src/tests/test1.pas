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
  s1, s2: String;
begin
s1 := 'mufoLo';
s2 := 'Hello World  --> ' + s1;
  MessageBox(0,s2,s1,0);
end.
