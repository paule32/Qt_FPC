// -----------------------------------------------------------------
// File:   start.cc
// Author: (c) 2023 Jens Kallup - paule32
// All rights reserved
//
// only for education, and non-profit usage !
// -----------------------------------------------------------------
# include <windows.h>

# include <stdio.h>
# include <stdlib.h>
# include <strings.h>

# include <iostream>
# include <string>
# include <map>

#define result(x) return x

// -----------------------------------------------------------------
//
// -----------------------------------------------------------------
struct ResultStruct {
    std::uint32_t                     args;
    std::string                       prev;
    std::map< uint32_t, std::string > arg ;
    std::map< uint32_t, void*       > ptr ;
    
};  std::map< std::string, ResultStruct* > resultList;

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
// save the callee, and display a message on display device ...
// -----------------------------------------------------------------
ResultStruct*
MessageBox_QString_PChar_Callee(
    char *prev,    // previous callee
    char *S1,      // message text
    char *S2)      // message title
{
    auto *result   = new ResultStruct;
    
    result->prev   = std::string(prev);
    result->args   = 2;
    
    result->arg[1] = std::string("PCHAR"); result->ptr[1] = S1;
    result->arg[2] = std::string("PCHAR"); result->ptr[2] = S2;

    resultList[__FUNCTION__] = result;
    
    std::cout << "prev: " << prev << std::endl;
    MessageBoxA(0, LPCTSTR(S1), LPCTSTR(S2), 0);
    return result;
}
ResultStruct*
MessageBox_QString_PChar(
    char *S1,      // message text
    char *S2) {    // message title
    return MessageBox_QString_PChar_Callee(
        "MessageBox_QString_PChar",
        S1,
        S2);
}

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
