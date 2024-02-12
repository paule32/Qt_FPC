// -----------------------------------------------------------------
// File:   Qt_Object.pas
// Author: (c) 2023 Jens Kallup - paule32
// All rights reserved
//
// only for education, and non-profit usage !
// -----------------------------------------------------------------
{$mode delphi}
unit Qt_Object;

interface
function Q_NULLPTR: Pointer; inline;

type
  QObject = class
  strict protected
    { keeps access in derived classes }
    FParent: QObject;
  public
    constructor Create(p: QObject = nil); virtual;
    destructor Destroy;

    property Parent: QObject read FParent default nil;
  end;
  
implementation

function Q_NULLPTR: Pointer; inline;
begin
  result := Pointer(0);
end;

constructor QObject.Create(p: QObject = nil);
begin
  inherited Create;
  
  if p <> Q_NULLPTR then
  FParent := p;
end;
destructor QObject.Destroy;
begin
end;

end.
