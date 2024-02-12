{$mode delphi}
unit Qt.qObject;

interface

type
  QObject = class
  public
    constructor Create(p: QObject);
    destructor Destroy;
  end;
  
implementation

constructor QObject.Create(p: QObject);
begin
end;
destructor QObject.Destroy;
begin
end;

end.
