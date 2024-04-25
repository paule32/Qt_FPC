// -----------------------------------------------------------------
// File:   start.cc
// Author: (c) 2023 Jens Kallup - paule32
// All rights reserved
//
// only for education, and non-profit usage !
// -----------------------------------------------------------------
# include "Observer.hpp"

// -----------------------------------------------------------------
//
// -----------------------------------------------------------------
std::map< void*, std::string > labels;

extern "C" {
void TestTest(void)
{
    std::cout << "huch huchaya tucha\n" << std::endl;
}

void C_TestTest(char *s)
{
    std::cout << "--> " << s << std::endl;
}

void QString_Create_QString(void *p) { std::cout << "Create: QString" << std::endl; }

char*
QString_Create_PChar  (void *p)
{
    labels[p] = std::string( "PChar" );
    
    std::cout << "Create: PChar: " << reinterpret_cast<char*>(p) << std::endl;
    return reinterpret_cast<char*>(p);
}
void QString_Append_QString(void *p) { std::cout << "Append: QString" << std::endl; }

// -----------------------------------------------------------------
// DLL entry start function ...
// -----------------------------------------------------------------
BOOL WINAPI DllMain(
    HINSTANCE hinstDLL    ,  // handle to DLL module
    DWORD     fdwReason   ,  // reason for calling function
    LPVOID    lpvReserved )  // reserved
    {
    switch (fdwReason) {
        case DLL_PROCESS_ATTACH:
            labels.clear();
        break;
        
        case DLL_PROCESS_DETACH:
            if (lpvReserved != nullptr)
            break;
            labels.clear();
        break;
        
        case DLL_THREAD_ATTACH:
        break;
        
        case DLL_THREAD_DETACH:
        break;
    }
    return true;
}

};
