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
    LibraryHdl: HMODULE;

function PutToFile(const AFileName: PChar; AData: PChar): Boolean;
var
    hFile    : HANDLE  ;
    count    : DWORD;
    dataSize : DWORD;
    buffer   : PChar;
    p1,p2,p3,
    p4       : PChar;
    
    overlap  : POverlapped;
    dummy    : DWORD;
    error    : DWORD;
begin
    result   := false;
    dataSize := strlen( AData );

    // --------------------------------------------
    // first look, if we can find the lock file ...
    // --------------------------------------------
    dummy := PathFileExistsA( AFileName );
    if dummy = 1 then begin
        buffer := malloc(200);
        MessageBox(0,'sssss','xxxxxx',0);
        strcpy(buffer, PChar('File: "'));
        strcat(buffer, PChar(AFileName));
        strcat(buffer, PChar('" already exists.\n'));
        strcat(buffer, PChar('Would you like override it ?'));
        dummy := MessageBox(0,
        buffer,
        'Information',
        MB_YESNO);
        if dummy = IDYES then begin
            DeleteFileA( AFileName );
            hFile := CreateFile(
            AFileName,
            GENERIC_WRITE,
            FILE_SHARE_READ or FILE_SHARE_WRITE,
            nil,
            CREATE_NEW,
            FILE_ATTRIBUTE_NORMAL,
            0);
        end else begin
            hFile := CreateFile(
            AFileName,
            GENERIC_WRITE,
            FILE_SHARE_READ or FILE_SHARE_WRITE,
            nil,
            OPEN_EXISTING,
            FILE_ATTRIBUTE_NORMAL,
            0);
        end;
    end else begin
        hFile := CreateFile(
        AFileName,
        GENERIC_WRITE,
        FILE_SHARE_READ or FILE_SHARE_WRITE,
        nil,
        CREATE_NEW,
        FILE_ATTRIBUTE_NORMAL,
        0);
    end;
    if THandle(hFile) = INVALID_HANDLE_VALUE then begin
        buffer := malloc(200);
        strcpy(buffer, PChar('file: "'));
        strcat(buffer, PChar(AFileName));
        strcat(buffer, PChar('" could not be write.'));
        
        MessageBox(0,
        buffer,
        PChar('Error'),
        MB_ICONWARNING);
        ExitProcess(GetLastError);
    end;
    
    MessageBox(0,
    'CreateFile() success',
    'Information',
    MB_ICONINFORMATION);

    // --------------------------------------------------
    // set file pointer to the end - all needed data will
    // be write/read backwards ...
    // --------------------------------------------------
    dummy := SetFilePointer(THandle(hFile), 0, nil, FILE_END);
    error := GetLastError;
        
    if ((dummy =  INVALID_SET_FILE_POINTER)
    and (error <> NO_ERROR)) then begin
        MessageBox(0,
        'SetFilePointer() failed.',
        'Information',
        MB_ICONWARNING);
        ExitProcess(error);
    end;

    MessageBox(0,
    'SetFilePointer() success.',
    'Information',
    MB_ICONINFORMATION);
    
    dummy := WriteFile(
        THandle(hFile),
        LibraryHdl,
        sizeof( int64 ),
        dword(nil^),
        nil);
    error := GetLastError;
    
    if error <> NO_ERROR then begin
        MessageBox(0,
        'WriteFile() failed.',
        'Error',
        MB_ICONWARNING);
        ExitProcess(error);
    end;
    
    MessageBox(0,
    'WriteFile() success.',
    'Information',
    MB_ICONINFORMATION);
    
    if CloseHandle(THandle(hFile)) = 0 then begin
        MessageBox(0,
        'CloseHandle() failed.',
        'Error',
        MB_ICONWARNING);
        ExitProcess(GetLastError);
    end;
    
    MessageBox(0,
    'CloseHandle() success.',
    'Information',
    MB_ICONINFORMATION);

    result := true;
end;

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
            LibraryHdl := GetModuleHandle(nil);
            PutToFile('fpc_rtl.txt', 'Ein Test');
        end;
    end;
    
    MessageBox(0,'hel ---- lo','world',0);
    ExitProcess(0);
    while (GetMessage(msg, LongWord( LibraryHdl ), 0, 0) > 0) do
    begin
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
