// ---------------------------------------------------------------------------
// File:   GNU_Library.pas
// Author: Jens Kallup - paule32
//
// This file is part of RTL.
//
// (c) Copyright 2024 Jens Kallup - paule32
// only for non-profit usage !!!
// ---------------------------------------------------------------------------
{$ifdef windows_header}

function malloc (    s: DWORD                  ): PVOID ; cdecl; external 'ucrtbase.dll'   name 'malloc';
function strcat (var d: LPCSTR; const s: LPCSTR): LPCSTR; cdecl; external 'ucrtbase.dll'   name 'strcat';
function strcpy (var d: LPCSTR; const s: LPCSTR): LPCSTR; cdecl; external 'ucrtbase.dll'   name 'strcpy';
function strlen (               const s: LPCSTR): DWORD ; cdecl; external DLL_STR_kernel32 name 'lstrlenA';

{$endif}

{$ifdef windows_source}
{$endif}