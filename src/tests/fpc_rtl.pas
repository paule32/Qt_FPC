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

{ $ I f pc_types.pas}

type NTSTATUS  = LONG;

var
    LdrpInLdrInit: BOOL = 0;
    LibraryHdl: HINSTANCE;

{$if declared(STATUS_SUCCESS)}
{$info ssffsdsf}
{$endif}

function NT_SUCCESS(status: NTSTATUS): BOOL; inline;
begin
    result := 0;
    if status >= 0 then begin
        result := 1;
        exit;
    end
end;

function BaseSetLastNTError( status: NTSTATUS ): DWORD;
var
    dwErrCode: DWORD;
begin
    dwErrCode := RtlNtStatusToDosError(status);
    SetLastError(dwErrCode);
    result := dwErrCode;
end;

function RtlEnterCriticalSection(): NTSTATUS;
begin
end;

function LdrLockLoaderLock(
    flags      : ULONG;
    disposition: PULONG;
    cookie     : PULONG_PTR): NTSTATUS;
(*var
    status: NTSTATUS = STATUS_SUCCESS;
    inInit: BOOL     = LdrpInLdrInit;*)
begin
(*
    // zero out the outputs
    if disposition then disposition := LDR_LOCK_LOADER_LOCK_DISPOSITION_INVALID;
    if cookie      then cookie      := 0;
    
    // validate the flags
    if flags and (
    LDR_LOCK_LOADER_LOCK_FLAG_RAISE_ON_ERRORS or
    LDR_LOCK_LOADER_LOCK_FLAG_TRY_ONLY) then begin
        // flags are invalid, check how to fail
        if flags and LDR_LOCK_LOADER_LOCK_FLAG_RAISE_ON_ERRORS then
        RtlRaiseStatus(STATUS_INVALID_PARAMETER_1);
        
        // a normal failure
        result := STATUS_INVALID_PARAMETER_1;
        exit;
    end;
    
    // make sure we got a cookie
    if not cookie then begin
        // no cookie check how to fail
        if flags and LDR_LOCK_LOADER_LOCK_FLAG_RAISE_ON_ERRORS then
        RtlRaiseStatus(STATUS_INVALID_PARAMETER_1);
        
        // a normal failure
        result := STATUS_INVALID_PARAMETER_1;
        exit;
    end;
    
    // if the flag is set, make sure we have a valid pointer to use
    if  (flags
    and  LDR_LOCK_LOADER_LOCK_FLAG_TRY_ONLY)
    and (disposition) then begin
        // no pointer to return the data to
        if (flags and LDR_LOCK_LOADER_LOCK_FLAG_RAISE_ON_ERRORS) then
        RtlRaiseStatus(STATUS_INVALID_PARAMETER_2);
        
        // fail
        result := STATUS_INVALID_PARAMETER_2;
    end;
    
    // return now if we are in the init phase
    if inInit then begin
        result := STATUS_SUCCESS;
        exit;
    end;
    
    // check what locking semantic to use
    if flags and LDR_LOCK_LOADER_LOCK_FLAG_RAISE_ON_ERRORS then begin
        // check if we should enter or simply try
        if flags and LDR_LOCK_LOADER_LOCK_FLAG_TRY_ONLY then begin
            // do a try
            if not RtlTryEnterCriticalSection(LdrpLoaderLock) then begin
                disposition := LDR_LOCK_LOADER_LOCK_DISPOSITION_LOCK_NOT_ACQUIRED;
            end else begin
                disposition := LDR_LOCK_LOADER_LOCK_DISPOSITION_LOCK_ACQUIRED;
                cookie      := LdrpMakeCookie;
            end;
        end else begin
            // do a enter
            RtlEnterCriticalSection(LdrpLoaderLock);
        
            // save if result was requested
            if disposition then
            disposition := LDR_LOCK_LOADER_LOCK_DISPOSITION_LOCK_ACQUIRED;
            cookie      := LdrpMakeCookie;
        end;
    end else begin
    end;*)
end;

function LdrDisableThreadCalloutsForDll( baseAddress: PVOID ): NTSTATUS;
var
    status: NTSTATUS;
    lockHeld: BOOL;
    cookie: ULONG_PTR;
begin
(*
    // don't do it during shutdown
    if LdrpShutdownInProgress then begin
        result := STATUS_SUCCESS;
        exit;
    end;
    
    // check if we should grab the lock
    lockHeld := FALSE;
    if not LdrpInLdrInit then begin
        // grab the lock
        status := LdrLockLoaderLock(0, nil, cookie);
        if not NT_SUCCESS(status) then begin
            result := status;
            exit;
        end;
        lockHeld := TRUE;
    end;
    
    // make sure the DLL is valid and get it's entry
    status = STATUS_DLL_NOT_FOUND;
    if not LdrpCheckForLoadedDllHandle(baseAddress, LdrEntry) then begin
        // get if it has a TLS slot
        if not LdrEntry.TlsIndex then begin
            LdrEntry.Flags := [LDRP_DONT_CALL_FOR_THREADS];
            status := STATUS_SUCCESS;
        end;
    end;
    
    // check if the lock was held
    if lockHeld then begin
        // return it
        LdrUnlockLoaderLock(LDR_UNLOCK_LOADER_LOCK_FLAG_RAISE_ON_ERRORS, cookie);
    end;
    
    // return the status
    result := status;
    *)
end;

function DisableThreadLibraryCalls( hLibModule: HMODULE ): BOOL;
var
    status: NTSTATUS;
begin
    (*// disable thread library calls
    status := LdrDisableThreadCalloutsForDll(hLibModule);
    
    // if it wasn't success - see last error and return failure
    if not NT_SUCCESS(status) then begin
        BaseSetLastNTError(status);
        result := FALSE;
        exit;
    end;
    
    // return success*)
    result := TRUE;
end;

function Entry(
    hModule    : HANDLE;
    dwReason   : DWORD ;
    lpReserved : PVOID): Boolean; stdcall; export; public name '_DLLMainCRTStartup';
begin
    case dwReason of
        DLL_PROCESS_ATTACH: begin
            // save our HANDLE
            LibraryHdl := hModule;
        end;
    end;
    
    MessageBox(0,'hel  lo','world',0);
    result := TRUE;
    //ExitProcess(0);
end;

procedure TestTest; stdcall; export;
begin
    //MessageBox(0,'hello','world',0);
end;

// -----------------------------------------------------------------
// export public function's/procedure's ...
// -----------------------------------------------------------------
exports
    move, TestTest;

begin
    MessageBox(0,'hello','world',0);
end.
