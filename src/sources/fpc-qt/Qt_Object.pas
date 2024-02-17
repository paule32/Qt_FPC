// -----------------------------------------------------------------
// File:   Qt_Object.pas
// Author: (c) 2023 Jens Kallup - paule32
// All rights reserved
//
// only for education, and non-profit usage !
// -----------------------------------------------------------------
{$mode objfpc}{$H+}
unit Qt_Object;

interface
uses RTL;
type
    PQObject = ^QObject;
    QObject  = object(rtl.TObject)
    protected
        { keeps access in derived classes }
        FParent: PQObject;
    public
        constructor Create(p: PQObject); overload;
        constructor Create; overload;

        destructor Destroy;
    property
        Parent: PQObject read FParent;
    end;

    function Q_NULLPTR: Pointer; inline;
implementation

function Q_NULLPTR: Pointer; inline;
begin
    result := Pointer(0);
end;

constructor QObject.Create(p: PQObject);
begin
    inherited Create;

    if p <> nil then
    FParent := p;
end;
constructor QObject.Create;
begin
    inherited Create;
end;

destructor QObject.Destroy;
begin
end;

end.
