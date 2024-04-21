// ---------------------------------------------------------------------------
// File:   sysutils.pas
// Author: Jens Kallup - paule32
//
// This file is part of RTL.
//
// (c) Copyright 2024 Jens Kallup - paule32
// only for non-profit usage !!!
// ---------------------------------------------------------------------------
{$ifdef windows_header}
{$ifndef __FPC_SYSUTILS__PAS_}
{$define __FPC_SYSUTILS__PAS_}

function FileCreate( const FileName: PChar        ; flag: Boolean = false): Handle; overload;
function FileCreate( const FileName: RawByteString; flag: Boolean = false): Handle; overload;

function FileDelete( const FileName: PChar         ): Boolean; overload;
function FileDelete( const FileName: RawByteString ): Boolean; overload;

{$endif __FPC_SYSUTILS__PAS_}
{$endif}

{$ifdef windows_source}
function FileCreate( const FileName: PChar; flag: Boolean ): Handle; overload;
var
    hd    : Handle;
    dummy : DWORD;
    buffer: PChar;
begin
    ShowInfo('pacher');
    
    dummy := PathFileExistsA( FileName );
    if ((dummy = 1) and (flag = true)) then begin
        dummy := DeleteFileA( FileName );
        if dummy = 0 then begin
            ShowMessage('file not delete');
        end;
        hd := CreateFile(
        FileName,
        GENERIC_WRITE,
        FILE_SHARE_READ or FILE_SHARE_WRITE,
        nil,
        CREATE_NEW,
        FILE_ATTRIBUTE_NORMAL,
        nil);
    end else begin
        hd := CreateFile(
        FileName,
        GENERIC_WRITE,
        FILE_SHARE_READ or FILE_SHARE_WRITE,
        nil,
        CREATE_NEW,
        FILE_ATTRIBUTE_NORMAL,
        nil);
    end;
    
    if THandle(hd) = INVALID_HANDLE_VALUE then begin
        GetMem( buffer, 255);
        
        strcpy( buffer, 'File: "');
        strcat( buffer, FileName );
        strcat( buffer, '" could not be open.' );

        ShowError( buffer );
        FreeMem  ( buffer );
        
        exit;
    end;
    result := hd;
end;

function FileCreate( const FileName: RawByteString; flag: Boolean ): Handle; overload;
begin
    result := FileCreate( PChar( FileName ) );
end;

function FileDelete( const FileName: PChar): Boolean; overload;
begin
    if DeleteFileA( PChar( FileName ) ) = 1 then
    result := true else
    result := false;
end;

function FileDelete( const FileName: RawByteString ): Boolean; overload;
begin
    result := FileDelete( PChar( FileName ) );
end;

{$endif}
