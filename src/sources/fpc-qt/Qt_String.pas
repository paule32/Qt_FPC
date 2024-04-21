// ---------------------------------------------------------------------------
// File:   Q_String.pas
// Author: Jens Kallup - paule32
//
// This file is part of RTL.
//
// (c) Copyright 2024 Jens Kallup - paule32
// only for non-profit usage !!!
// ---------------------------------------------------------------------------
{$ifdef windows_header}

{$ifdef windll}
type
    QString  = class(QObject)
    protected
        //FStringObject: QString;
        //FString: String;
    public
        //constructor Create(other: QString); overload;
        //constructor Create(str: AnsiString); overload;
        constructor Create; overload;

        destructor Destroy; virtual;

        //function append(str: String): QString; overload;
        //function append(other: QString): QString; overload;

        //function arg(a: QString; fieldWidth: Integer = 0; base: Integer = 10; fillChar: Char = ' '): QString;
    end;
{$endif windll}

{$ifdef winexe}
//function QString_Create(s: QString): QString; stdcall; external rtl_dll name 'QString_CreateQString'; overload;
//function QString_Create            : QString; stdcall; external rtl_dll name 'QString_Create';        overload;
{$endif winexe}

{$endif windows_header}

{$ifdef windows_source}

{$ifdef windll}
// ---------------------------------------------------------------------------
// dummy deklaration for the FPC Compiler - patched later, so dummy ...
// ---------------------------------------------------------------------------
constructor QString.Create ; begin end;
 destructor QString.Destroy; begin end;

{$endif windll}

{$endif}
