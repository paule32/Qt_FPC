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
    LibraryHdl: LongDWORD;

function Entry(
    hModule    : HANDLE;
    dwReason   : DWORD ;
    lpReserved : PVOID): BOOL; stdcall; export; public name '_DLLMainCRTStartup';
var
    msg: TMessage;
    hFile: THandle;
    
    count    : Cardinal;
    buffer   : PChar;
    dataSize : Integer;
begin
    case dwReason of
        DLL_PROCESS_ATTACH: begin
            // save our HANDLE
            LibraryHdl := LongDWORD(hModule);
            
            hFile := CreateFile(
            'fpc_rtl.$$$',          // name of the file
            GENERIC_WRITE,          // open for writing
            FILE_SHARE_READ or FILE_SHARE_WRITE,
            nil,                    // default security
            OPEN_EXISTING,
            FILE_ATTRIBUTE_NORMAL,  // normal file
            0);
            
            if hFile = INVALID_HANDLE_VALUE then
            hFile := CreateFile(
            'fpc_rtl.$$$',
            GENERIC_WRITE,
            FILE_SHARE_READ or FILE_SHARE_WRITE,
            nil,
            CREATE_NEW,
            FILE_ATTRIBUTE_NORMAL,
            0);
            
            if hFile = INVALID_HANDLE_VALUE then begin
                MessageBox(0,
                'file: fpc_rtl.$$$ could not be write.',
                'Error', 0);
                ExitProcess(1);
            end;
            
            SetFilePointer(hFile, 0, nil, FILE_BEGIN);
            
            dataSize := 5;
            buffer   := PChar('buffer');
            
            MessageBox(0,'xxxx','dsddd',0);
            
            SetFilePointer(hFile, 0, nil, FILE_BEGIN);
            WriteFile(hFile, buffer^, dataSize, count, nil);
            
            MessageBox(0,'xxxx','dsddd',0);

            CloseHandle(hFile);
        end;
    end;
    
    MessageBox(0,'hel ---- lo','world',0);
    ExitProcess(0);
    while (GetMessage(msg, LibraryHdl, 0, 0) > 0) do begin
        case msg.message of
            $10001: begin
                break;
            end;
        end;
        TranslateMessage (msg);
        DispatchMessage  (msg);
    end;

    ExitProcess(0);
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
