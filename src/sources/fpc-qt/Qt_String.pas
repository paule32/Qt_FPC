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
    QString  = class(QObject)
    protected
        FStringObject: QString;
        FString: String;
    public
        constructor Create(other: QString); overload;
        constructor Create(str: String); overload;
        constructor Create; overload;

        destructor Destroy; virtual;

        function append(str: String): QString; overload;
        function append(other: QString): QString; overload;

        function arg(a: QString; fieldWidth: Integer = 0; base: Integer = 10; fillChar: Char = ' '): QString;
    end;
{$endif}

{$ifdef windows_source}
constructor QString.Create;
begin
    FStringObject := nil;
    //FStringObject.FString := '';
end;
constructor QString.Create(str: String);
begin
    FStringObject := nil;
    //FStringObject.FString := str;
end;
constructor QString.Create(other: QString);
begin
    if other <> nil then
    begin
        FStringObject := other;
        //FStringObject.FString := other.FString;
    end;
end;
destructor QString.Destroy;
begin
//    FStringObject.Free;
end;

function QString.append(str: String): QString;
begin
    if FStringObject = nil then
    FStringObject := self;

//    FStringObject.FString := FStringObject.FString + str;
    result := FStringObject;
end;

function QString.append(other: QString): QString;
begin
    if other = nil then
    other := self;

    FStringObject := other;
//    FStringObject.FString := other.FString;

    result := FStringObject;
end;

function QString.arg(a: QString; fieldWidth: Integer = 0; base: Integer = 10; fillChar: Char = ' '): QString;
begin
    result := FStringObject;
end;
{$endif}
