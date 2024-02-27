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
  adll: HMODULE;
  aproc: procedure; stdcall;

begin
  adll := LoadLibrary( 'test2.dll' );
  if (not (adll = nil)) then
  begin
    MessageBox(0,'xxxxxxxxx','111 222 333',0);
    @aproc := GetProcAddress(adll, 'test');
    MessageBox(0,'xxxxxxxxx','222',0);
    aproc;
  end;
  FreeLibrary( adll );
end.
