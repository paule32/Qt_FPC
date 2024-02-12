// ----------------------------------------------------------
// This file is part of RTL.
//
// (c) Copyright 2021 Jens Kallup - paule32
// only for non-profit usage !!!
// ----------------------------------------------------------
{$mode delphi}
unit sysinit;

interface

type
  TObject = class
  public
    constructor Create;
    destructor Destroy;
  end;

//procedure LazExitProcess (ExitCode: LongInt); cdecl; external 'laz_rtl.dll' name 'LazExitProcess';

implementation

constructor TObject.Create;
begin
end;
destructor TObject.Destroy;
begin
end;

procedure PascalMain; external name 'PASCALMAIN';

procedure Entry; [public, alias: '_mainCRTStartup'];
begin
  PascalMain;
//  LazExitProcess(0);
end;

end.
