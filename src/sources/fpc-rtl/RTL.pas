// -----------------------------------------------------------------
// File:   RTL.pas
// Author: (c) 2024 Jens Kallup - paule32
// All rights reserved
//
// only for education, and non-profit usage !
// -----------------------------------------------------------------
{$mode objfpc}{$H+}
unit RTL;

interface

type
  TObject = object
  public
    procedure Free;
    
    constructor Create(flag: QWordBool);
    constructor Create;
    
    destructor Destroy;
  end;

implementation

constructor TObject.Create;
begin

end;
constructor TObject.Create(flag: QWordBool);
begin
end;

destructor TObject.Destroy;
begin
end;

procedure TObject.Free;
begin
asm
nop
end;
end;

end.
