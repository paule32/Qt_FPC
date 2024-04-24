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

procedure TestTest; cdecl; external 'app_rtl.dll' name 'TestTest';

function PutToFile(const AFileName: PChar; AData: PChar): Boolean;
var
    hFile    : Handle;
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

    ShowInfo('sssss');

    // --------------------------------------------
    // first look, if we can find the lock file ...
    // --------------------------------------------
    dummy := PathFileExistsA( AFileName );
    if dummy = 1 then begin
        hfile := FileCreate( AFileName );
    end else begin
        hFile := FileCreate( AFileName, true );
    end;
    if THandle(hFile) = INVALID_HANDLE_VALUE then begin
        buffer := malloc(200);
        
        strcpy( buffer, PChar('file: "'));
        strcat( buffer, PChar(AFileName));
        strcat( buffer, PChar('" could not be write.'));
        
        ShowError( buffer );
        ExitProcess(GetLastError);
    end;

    ShowInfo('CreateFile() success');

    FileSeek(hfile, 0, FILE_END);
        
    ShowInfo('SetFilePointer() success.');
    
    WriteFile(THandle(hfile), GetModuleHandle(nil) );
    error := GetLastError;
    FreeMem(buffer);
    
    if error <> NO_ERROR then begin
        ShowError('WriteFile() failed.');
        ExitProcess(error);
    end;
    
    ShowInfo('WriteFile() success.');
    
    if CloseHandle(THandle(hFile)) = 0 then begin
        ShowError('CloseHandle() failed.');
        ExitProcess(GetLastError);
    end;

    ShowInfo('CloseHandle() success.');
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
    
    s1: QString;
    s2: QString;
    s3: QString;
var
    LibraryHdl: HMODULE;
begin
    s1 := QString.Create;
    s2 := QString.Create;
    s3 := QString.Create;
    buffer := 'juhu';
    s1.append(buffer);
    
    TestTest;
    
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

// -----------------------------------------------------------------
// export public function's/procedure's ...
// -----------------------------------------------------------------
exports
    move, TestTest;

begin
    ShowInfo('hello');
end.
