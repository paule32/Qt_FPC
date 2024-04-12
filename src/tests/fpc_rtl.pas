// -----------------------------------------------------------------
// File:   fpc_rtl.pas
// Author: (c) 2024 Jens Kallup - paule32
// All rights reserved
//
// only for education, and non-profit usage !
// -----------------------------------------------------------------
{$mode delphi}
library fpc_rtl;

procedure TestTest; stdcall; export; public name 'TestTest';
begin
  MessageBox(0,'hello','world',0);
end;

// -----------------------------------------------------------------
// export public function's/procedure's ...
// -----------------------------------------------------------------
exports
  move, TestTest;

begin
end.
