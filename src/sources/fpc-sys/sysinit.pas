// ----------------------------------------------------------
// This file is part of RTL.
//
// (c) Copyright 2021 Jens Kallup - paule32
// only for non-profit usage !!!
// ----------------------------------------------------------
{$mode delphi}
unit sysinit;

interface

implementation

procedure PascalMain; external name 'PASCALMAIN';

{$ifdef winexe}
procedure Entry; [public, alias: '_mainCRTStartup'];
begin
  PascalMain;
end;
{$endif}

end.
