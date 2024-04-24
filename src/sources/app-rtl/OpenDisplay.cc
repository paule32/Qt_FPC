// -----------------------------------------------------------------
// File:   OpenDisplay.cc
// Author: (c) 2024 Jens Kallup - paule32
// All rights reserved
//
// only for education, and non-profit usage !
// -----------------------------------------------------------------
# include <windows.h>

# include <iostream>

char* OpenDisplay(void)
{
    printf("hallo\n");
    return "zuzu";
}

bool CloseDisplay(char *session)
{
    return true;
}

#ifdef windll
BOOL WINAPI DllMain(
    HINSTANCE hinstDLL,    // handle to DLL module
    DWORD fdwReason,       // reason for calling function
    LPVOID lpvReserved) {  // reserved
    
    MessageBox(0, "halllllo", "moooww", 0);
    return true;
}
#endif  // windll
