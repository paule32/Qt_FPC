// -----------------------------------------------------------------
// File:   fpc_rtl.pas
// Author: (c) 2024 Jens Kallup - paule32
// All rights reserved
//
// only for education, and non-profit usage !
// -----------------------------------------------------------------
{$mode delphi}
library fpc_rtl;

{$define windows_header}
{$define uses_ntstatus}
{$define uses_bool}
{$define uses_status_success}

type NTSTATUS  = LONG;

var
    LibraryHdl: HINSTANCE;

function Entry(
    hModule    : HANDLE;
    dwReason   : DWORD ;
    lpReserved : PVOID): BOOL; stdcall; export; public name '_DLLMainCRTStartup';
var
    msg: TMessage;
begin
    case dwReason of
        DLL_PROCESS_ATTACH: begin
            // save our HANDLE
            LibraryHdl := hModule;
        end;
    end;
    
    MessageBox(0,'hel ---- lo','world',0);
    ExitProcess(0);
    while (GetMessage(msg, 0, 0, 0) > 0) do begin
        TranslateMessage (msg);
        DispatchMessage  (msg);
    end;

    result := 1;
end;

procedure TestTest; stdcall; export;
begin
    MessageBox(0,'hello','world',0);
end;

// -----------------------------------------------------------------
// export public function's/procedure's ...
// -----------------------------------------------------------------
exports
    move, TestTest;

begin
    MessageBox(0,'hello','world',0);
end.
