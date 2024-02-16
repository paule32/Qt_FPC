// -----------------------------------------------------------------
// File:   objpas.pas
// Author: (c) 2024 Jens Kallup - paule32
// All rights reserved
//
// only for education, and non-profit usage !
// -----------------------------------------------------------------
{$mode delphi}
unit objpas;

interface

type
  TObject = class
  public
    constructor Create;
    destructor Destroy;
  end;

implementation

constructor TObject.Create;
begin

end;

destructor TObject.Destroy;
begin
end;

end.
