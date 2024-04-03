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

{$ifdef windll}
procedure _FPC_DLLMainCRTStartup(
    _hinstance : qword;
    _dllreason : dword;
    _dllparam:Pointer); stdcall; public name 'DLLMainCRTStartup';
begin
 // MessageBox(0,'2222222','aaaaaa',0);
end;
{$endif}

end.
