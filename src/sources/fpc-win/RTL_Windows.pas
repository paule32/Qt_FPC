// -----------------------------------------------------------------
// File:   RTL_Windows.pas
// Author: (c) 2024 Jens Kallup - paule32
// All rights reserved
//
// only for education, and non-profit usage !
// -----------------------------------------------------------------
{$ifdef windows_header}

// ---------------------------------------------------------------------------
// win32api constants, and variables ...
// ---------------------------------------------------------------------------
type THANDLE =  LongWord;     // onject handle
type PHandle = ^THANDLE;

type LCID    = LongDWord;     // a local identifier
type LANGID  = LongDWord;     // a language identifier

type WPARAM  = LongDWord;     // 32-bit message parameter
type LPARAM  = LongDWord;     // 32-bit message parameter

type LRESULT = LongDWord;     // 32-bit unsigned return value
type HRESULT = ShortDWord;    // 32-bit signed   return value

type HWND    = LongDWord;     // a handle to a window
type ATOM    = LongDWord;     // local/global atom index for a string

type HGLOBAL = THandle;       // a globally memory allocated handle

type DWORD   = LongDWORD;
type UINT    = LongDWORD;
type SIZE_T  = LongDWORD;

type PVOID   = Pointer;
type HANDLE  = PVOID;

type LPCSTR  = String;
type LPCWSTR = String;

{$ifdef UNICODE}
type LPCTSTR = LPCWSTR;
{$else}
type LPCTSTR = LPCSTR;
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
function TSystemCodePage: DWORD; inline;

function  HeapCreate( flOptions: DWORD; dwInitialSize, dwMaximumSize: SIZE_T ): HANDLE; external DLL_STR_kernel32 name 'HeapCreate';
function  LocalAlloc( uFlags: UINT; uBytes: SIZE_T): UINT; cdecl; external DLL_STR_kernel32 name 'LocalAlloc';
procedure ExitProcess( ExitCode: LongInt ); cdecl; external DLL_STR_kernel32 name 'ExitProcess';

// ---------------------------------------------------------------------------
// win32api module user32.dll:
// ---------------------------------------------------------------------------
function MessageBox( _hwnd: HWND; lpText, lpCaption: LPCTSTR; uType: UINT): DWORD; cdecl external DLL_STR_user32 name 'MessageBoxA';

{$endif}

{$ifdef windows_source}
// ---------------------------------------------------------------------------
// core Pascal entry point stuff:
// ---------------------------------------------------------------------------
procedure PascalMain; external name 'PASCALMAIN';
procedure Entry; [public, alias: '_mainCRTstartup'];
begin
    PascalMain;
    ExitProcess(0);
end;

function TSystemCodePage: DWORD; inline;
begin
    result := GetACP;
end;
{$endif}
