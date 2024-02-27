// -----------------------------------------------------------------
// File:   test2.pas
// Author: (c) 2024 Jens Kallup - paule32
// All rights reserved
//
// only for education, and non-profit usage !
// -----------------------------------------------------------------
{$mode delphi}
library test2;

procedure test; stdcall; export;
begin
  MessageBox(0,'zuzu','foo',0);
end;

exports test;
begin
MessageBox(0,'1123331311313','ppppppp',0);
end.
