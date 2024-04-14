// -----------------------------------------------------------------
// File:   fpc_rtl.pas
// Author: (c) 2024 Jens Kallup - paule32
// All rights reserved
//
// only for education, and non-profit usage !
// -----------------------------------------------------------------
{$mode delphi}
library fpc_rtl;

function Entry(
    _hinstance : qword;
    _dllreason : dword;
    _dllparam:Pointer): Boolean; stdcall; export; public name '_DLLMainCRTStartup';
begin
    MessageBox(0,'hello','world',0);
    result := true;
    //ExitProcess(0);
end;

procedure TestTest; stdcall; export;
begin
  MessageBox(0,'1abababab','blubp',0);
end;

// -----------------------------------------------------------------
// export public function's/procedure's ...
// -----------------------------------------------------------------
exports
    move, TestTest;

begin
    MessageBox(0,'hello','world',0);
end.
