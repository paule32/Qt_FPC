// ---------------------------------------------------------------------------
// File:   RTL_Windows.pas
// Author: (c) 2024 Jens Kallup - paule32
// All rights reserved
//
// only for education, and non-profit usage !
// ---------------------------------------------------------------------------
{$ifdef windows_header}

// ---------------------------------------------------------------------------
// win32api constants, and variables ...
// ---------------------------------------------------------------------------
type BOOL      = Integer;       // true or false

type PVOID     = Pointer;

type HANDLE    = PVOID;
type FARPROC   = PVOID;

type THANDLE   =  LongWord;     // onject handle
type PHandle   = ^THANDLE;

type LCID      = LongDWord;     // a local identifier
type LANGID    = LongDWord;     // a language identifier

type WPARAM    = LongDWord;     // 32-bit message parameter
type LPARAM    = LongDWord;     // 32-bit message parameter

type LRESULT   = LongDWord;     // 32-bit unsigned return value
type HRESULT   = ShortDWord;    // 32-bit signed   return value

type HINSTANCE = HANDLE;        // a handle to an instance
type HLOCAL    = HANDLE;        // a handle to a local memory block
type HMODULE   = HINSTANCE;     // a handle to a module (.dll)

type HWND      = LongDWord;     // a handle to a window
type ATOM      = LongDWord;     // local/global atom index for a string

type HGLOBAL   = THandle;       // a globally memory allocated handle

type LPCSTR    = String;
type LPCWSTR   = String;

{$ifdef UNICODE}
type LPCTSTR   = LPCWSTR;
{$else}
type LPCTSTR   = LPCSTR;
{$endif}

// ---------------------------------------------------------------------------
// win32api dynamic link libraries:
// ---------------------------------------------------------------------------
const DLL_STR_kernel32 = 'kernel32.dll';
const DLL_STR_user32   = 'user32.dll';

// ---------------------------------------------------------------------------
// win32api - MessageBox:
// ---------------------------------------------------------------------------
const MB_OK                   = $00000000;
const MB_OKCANCEL             = $00000001;
const MB_ABORTRETRYIGNORE     = $00000002;
const MB_YESNOCANCEL          = $00000003;
const MB_YESNO                = $00000004;
const MB_RETRYCANCEL          = $00000005;
const MB_CANCELTRYCONTINUE    = $00000006;
const MB_HELP                 = $00004000;
//
const MB_ICONEXCLAMATION      = $00000030;
const MB_ICONWARNING          = $00000030;
const MB_ICONINFORMATION      = $00000040;
const MB_ICONASTERISK         = $00000040;
const MB_ICONQUESTION         = $00000020;
//
const MB_ICONSTOP             = $00000010;
const NB_ICONERROR            = $00000010;
const MB_ICONHAND             = $00000010;

const MB_DEFBUTTON1           = $00000000;
const MB_DEFBUTTON2           = $00000100;
const MB_DEFBUTTON3           = $00000200;
const MB_DEFBUTTON4           = $00000300;

const MB_APPLMODAL            = $00000000;
const MB_SYSTEMMODAL          = $00001000;
const MB_TASKMODAL            = $00002000;

const MB_DEFAULT_DESKTOP_ONLY = $00020000;
const MB_RIGHT                = $00080000;
const MB_RTLREADING           = $00100000;
const MB_SETFOREGROUND        = $00010000;
const MB_TOPMOST              = $00040000;
const MB_SERVICE_NOTIFICATION = $00200000;

// ---------------------------------------------------------------------------
// win32api MessageBox return results:
// ---------------------------------------------------------------------------
const IDOK       =  $1;
const IDCANCEL   =  $2;
const IDABORT    =  $3;
const IDRETRY    =  $4;
const IDIGNORE   =  $5;
const IDYES      =  $6;
const IDNO       =  $7;
const IDTRYAGAIN = $10;
const IDCONTINUE = $11;

// ---------------------------------------------------------------------------
// win32api VirtualAlloc:
// ---------------------------------------------------------------------------
const MEM_COALESCE_PLACEHOLDERS = $00000001;
const MEM_PRESERVE_PLACEHOLDER  = $00000002;

const MEM_COMMIT      = $00001000;
const MEM_RESERVE     = $00002000;
const MEM_DECOMMIT    = $00004000;
const MEM_RELEASE     = $00008000;
const MEM_RESET       = $00080000;
const MEM_RESET_UNDO  = $10000000;

const MEM_LARGE_PAGES = $20000000;
const MEM_PHYSICAL    = $00400000;
const MEM_TOP_DOWN    = $00100000;
const MEM_WRITE_WATCH = $00200000;

const PAGE_EXECUTE           = $10;
const PAGE_EXECUTE_READ      = $20;
const PAGE_EXECUTE_READWRITE = $40;
const PAGE_EXECUTE_WRITECOPY = $80;

const PAGE_NOACCESS  = $01;
const PAGE_READONLY  = $02;
const PAGE_READWRITE = $04;
const PAGE_WRITECOPY = $08;

const PAGE_TARGETS_INVALID   = $40000000;
const PAGE_TARGETS_NO_UPDATE = $40000000;

const PAGE_GUARD        = $100;
const PAGE_NOCACHE      = $200;
const PAGE_WRITECOMBINE = $400;

// ---------------------------------------------------------------------------
// win32api LocalAlloc, LocalReAlloc, and LocalFree:
// ---------------------------------------------------------------------------
const LMEM_MOVEABLE = $0002;
const LMEM_ZEROINIT = $0040;

const LHND = LMEM_MOVEABLE or LMEM_ZEROINIT;

// ---------------------------------------------------------------------------
// win32api heap constants:
// ---------------------------------------------------------------------------
const HEAP_CREATE_ENABLE_EXECUTE = $00040000;
const HEAP_GENERATE_EXCEPTIONS   = $00000004;
const HEAP_NO_SERIALIZE          = $00000001;

// ---------------------------------------------------------------------------
// win32api module kernel32.dll:
// ---------------------------------------------------------------------------
// \brief  retrieve the current ANSI code-page identifier for the system.
// \param  This function has no parameters.
// \return DWORD - If the function succeeds, the return value is the current ANSI
//         code page for the system, or a default identifier if no code page is
//         current.
// \see    GetOEMCP
function GetACP: DWORD; cdecl; external DLL_STR_kernel32 name 'GetACP';

// \brief  retrieve the current OEM code-page identifier for the system.
//         OEM => original equipment manufacturer
// \param  This function has no parameters
// \return DWORD - If the function succeeds, the return value is the current OEM
//         code page for the system, or a default identifier code if no code page.
// \see    GetACP
function GetOEMCP: DWORD; cdecl; external DLL_STR_kernel32 name 'GetOEMCP';

// \brief  inline function that hold the current system code page
// \param  This function has no parameters.
// \return DWORD - the current system code page.
// \see    GetACP
// \see    GetOEMCP
function TSystemCodePage: DWORD;

// ---------------------------------------------------------------------------
// win32api module kernel32.dll:
// ---------------------------------------------------------------------------
procedure ExitProcess    ( ExitCode: LongInt ); cdecl; external DLL_STR_kernel32 name 'ExitProcess';

// ---------------------------------------------------------------------------
// win32api module kernel32.dll: dynamic library loader
// ---------------------------------------------------------------------------
function  FreeLibrary    ( hLibModule: HMODULE ): BOOL; cdecl; external DLL_STR_kernel32 name 'FreeLibrary';
function  GetProcAddress ( hModule: HMODULE; lpProcName: LPCSTR): FARPROC; stdcall; external DLL_STR_kernel32 name 'GetProcAddress';
function  LoadLibrary    ( lpLibFileName: LPCSTR ): HMODULE; stdcall; external DLL_STR_kernel32 name 'LoadLibraryA';

// ---------------------------------------------------------------------------
// win32api module kernel32.dll: Heap
// ---------------------------------------------------------------------------
function  HeapCreate     ( flOptions: DWORD; dwInitialSize, dwMaximumSize: SIZE_T ): HANDLE; cdecl; external DLL_STR_kernel32 name 'HeapCreate';
function  LocalAlloc     ( uFlags: UINT; uBytes: SIZE_T): UINT; cdecl; external DLL_STR_kernel32 name 'LocalAlloc';
function  LocalFree      ( hMem: HLOCAL): HLOCAL; cdecl; external DLL_STR_kernel32 name 'LocalFree';

// ---------------------------------------------------------------------------
// win32api module kernel32.dll: virtual memory
// ---------------------------------------------------------------------------
procedure FillChar       ( var Dest; Count: Integer; Value: Char );

function  VirtualAlloc   ( lpAddress: PVOID; dwSize: SIZE_T; flAllocationType: DWORD; flProtect: DWORD): Pointer; stdcall; external DLL_STR_kernel32 name 'VirtualAlloc';
function  VirtualFree    ( lpAddress: PVOID; dwSize: SIZE_T; dwFreeType: DWORD): BOOL; stdcall; external DLL_STR_kernel32 name 'VirtualAlloc';

// ---------------------------------------------------------------------------
// win32api module user32.dll:
// ---------------------------------------------------------------------------
function MessageBox( _hwnd: HWND; lpText, lpCaption: LPCTSTR; uType: UINT): DWORD; stdcall external DLL_STR_user32 name 'MessageBoxA';

{$endif}

{$ifdef windows_source}
// ---------------------------------------------------------------------------
// core Pascal entry point stuff:
// ---------------------------------------------------------------------------
procedure PascalMain; external name 'PASCALMAIN';
{$ifdef winexe}
procedure Entry; [public, alias: '_mainCRTstartup'];
begin
    PascalMain;
    ExitProcess(0);
end;
{$endif}
{$ifdef windll}
procedure Entry; [public, alias: '_DLLMainCRTStartup'];
begin
    PascalMain;
end;
{$endif}

procedure FillChar(var Dest; Count: Integer; Value: Char);
var
    I: Integer;
    P: PChar;
begin
    P := PChar(@Dest);
    for I := 0 to Count - 1 do
    begin
        P^ := Value;
        Inc(P);
    end;
end;

function TSystemCodePage: DWORD;
begin
    result := GetACP;
end;

{$endif}
