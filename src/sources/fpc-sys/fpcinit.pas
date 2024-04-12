// ---------------------------------------------------------------------------
// File:   fpcinit.pas
// Author: (c) 2024 Jens Kallup - paule32
// All rights reserved
//
// only for education, and non-profit usage !
// ---------------------------------------------------------------------------
unit fpcinit;

interface
{$ifdef windll}
procedure Entry(
    _hinstance : qword;
    _dllreason : dword;
    _dllparam:Pointer); stdcall; export; public name '_DLLMainCRTStartup';
{$endif}

implementation

{$ifdef windll}
procedure Entry(
    _hinstance : qword;
    _dllreason : dword;
    _dllparam:Pointer); stdcall; export;
begin
  MessageBox(0,'2222222','aaaaaa',0);
end;
{$endif}

end.
