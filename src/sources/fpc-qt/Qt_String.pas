// -----------------------------------------------------------------
// File:   Qt_String.pas
// Author: (c) 2024 Jens Kallup - paule32
// All rights reserved
//
// only for education, and non-profit usage !
// -----------------------------------------------------------------
{$mode objfpc}{$H+}
unit Qt_String;

interface
uses Qt_Object;

type
  PQString = ^QString;
  QString  = object(QObject)
  protected
    FStringObject: PQString;
    FString: String;
  public
    constructor Create(other: PQString); overload;
    constructor Create(str: String); overload;
    constructor Create; overload;
    
    constructor Init;
    
    destructor Destroy;
    
    function append(str: String): PQString; overload;
    function append(other: PQString): PQString; overload;
    
    function arg(a: PQString; fieldWidth: Integer = 0; base: Integer = 10; fillChar: Char = ' '): PQString;
  end;

implementation

constructor QString.Init;
begin
end;

constructor QString.Create;
begin
  FStringObject := nil;
  FStringObject^.FString := '';
end;
constructor QString.Create(str: String);
begin
  FStringObject := nil;
  FStringObject^.FString := str;
end;
constructor QString.Create(other: PQString);
begin
  if other <> nil then
  begin
    FStringObject := other;
    FStringObject^.FString := other^.FString;
  end;
end;

destructor QString.Destroy;
begin
  FStringObject^.Free;
end;

function QString.append(str: String): PQString;
begin
  if FStringObject = nil then
  FStringObject^ := self;
  
  FStringObject^.FString := FStringObject^.FString + str;
  result := FStringObject;
end;

function QString.append(other: PQString): PQString;
begin
  if other = nil then
  other^ := self;
  
  FStringObject := other;
  FStringObject^.FString := other^.FString;
  
  result := FStringObject;
end;

function QString.arg(a: PQString; fieldWidth: Integer = 0; base: Integer = 10; fillChar: Char = ' '): PQString;
begin
  result := FStringObject;
end;

end.
