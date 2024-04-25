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

type
    QString = class(QObject)
    private
        FString: PChar;
    public
        constructor Create(other: QString); overload;
        constructor Create(str  : PChar  ); overload;
        constructor Create                ; overload;
        
        destructor Destroy; virtual;
        
        function append(other: QString): QString; overload;
        function append(str  : PChar  ): QString; overload;

        //function arg(a: QString; fieldWidth: Integer = 0; base: Integer = 10; fillChar: Char = ' '): QString;
        
        function getText: PChar;
        
        procedure setText( AString: PChar   );
        procedure setText( AString: QString );
    end;

{$ifdef winexe}
//function QString_Create(s: QString): QString; stdcall; external rtl_dll name 'QString_CreateQString'; overload;
//function QString_Create            : QString; stdcall; external rtl_dll name 'QString_Create';        overload;
{$endif winexe}

{$endif windows_header}
{$ifdef windows_source}

// ---------------------------------------------------------------------------
// dummy deklaration for the FPC Compiler - patched later, so dummy ...
// ---------------------------------------------------------------------------
constructor QString.Create                ; begin end;
constructor QString.Create(str  : PChar  ); begin end;
constructor QString.Create(other: QString); begin end;
 destructor QString.Destroy; begin end;

function QString.append(other: QString): QString; begin end;
function QString.append(str  : PChar  ): QString; begin end;

function QString.getText: PChar;
begin
    result := FString;
end;

procedure QString.setText( AString: PChar );
begin
    FString := AString;
end;

procedure QString.setText( AString: QString );
begin
    setText( AString.FString );
end;

{$endif}
