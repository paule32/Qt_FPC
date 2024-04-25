// -----------------------------------------------------------------
// File:   DisplayDialogs.cc
// Author: (c) 2023 Jens Kallup - paule32
// All rights reserved
//
// only for education, and non-profit usage !
// -----------------------------------------------------------------
# include "Observer.hpp"
extern "C" {
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
    
    result->arg[1] = std::string("QSTRING"); result->ptr[1] = S1;
    result->arg[2] = std::string("PCHAR"  ); result->ptr[2] = S2;

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

};  // extern "C"
