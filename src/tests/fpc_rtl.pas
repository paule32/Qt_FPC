// -----------------------------------------------------------------
// File:   fpc_rtl.pas
// Author: (c) 2024 Jens Kallup - paule32
// All rights reserved
//
// only for education, and non-profit usage !
// -----------------------------------------------------------------
{$mode delphi}
library fpc_rtl;

{$ifdef windll}
procedure _FPC_DLLMainCRTStartup(
    _hinstance : qword;
    _dllreason : dword;
    _dllparam:Pointer); stdcall; public name '_DLLMainCRTStartup';
begin
 // MessageBox(0,'2222222','aaaaaa',0);
end;
{$endif}

// -----------------------------------------------------------------
// export public function's/procedure's ...
// -----------------------------------------------------------------
exports
  move;

begin
end.
