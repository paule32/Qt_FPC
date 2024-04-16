// ---------------------------------------------------------------------------
// File:   FPC_Types.pas
// Author: Jens Kallup - paule32
//
// This file is part of RTL.
//
// (c) Copyright 2024 Jens Kallup - paule32
// only for non-profit usage !!!
// ---------------------------------------------------------------------------
{$ifdef windows_header}
// ---------------------------------------------------------------------------
// 64-bit data types
// ---------------------------------------------------------------------------
type ShortBYTE  =                 -128..127;
type ShortWORD  =               -32768..32767;
type ShortDWORD =          -2147483648..2147483647;
type ShortQWORD = -9223372036854775808..9223372036854775807;

type LongBYTE   =  0..255;
type LongDWORD  =  0..4294967295;
type LongQWORD  =  0..18446744073709551615;

type LONG       = LongInt;

type Integer  = QWord;
type Cardinal = QWord;

type SizeInt = LongInt;

type DWORD  = LongDWORD;
type UINT   = LongDWORD;
type SIZE_T = LongDWORD;

type CodePointer  = Pointer;

type PChar        = ^Char;
type PShortString = ^ShortString;

type ULONG     = LongDWORD;
type ULONG_PTR = ^ULONG;

{$endif}
