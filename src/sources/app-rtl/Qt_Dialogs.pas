// -----------------------------------------------------------------
// File:   Qt_Dialogs.pas
// Author: (c) 2023 Jens Kallup - paule32
// All rights reserved
//
// only for education, and non-profit usage !
// -----------------------------------------------------------------
{$ifdef windows_header}

function MessageBox(AText: QString; ATitle: QString): DWORD;
function MessageBox(AText: QString; ATitle: PChar  ): DWORD;

{$endif windows_header}
{$ifdef windows_source}
function MessageBox(AText: QString; ATitle: QString): DWORD;
begin
    //MessageBox(0, AText.getText, ATitle.getText, 0);
    result := 1;
end;
function MessageBox(AText: QString; ATitle: PChar  ): DWORD;
begin
    result := 1;
end;

{$endif windows_source}
