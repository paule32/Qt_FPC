// -----------------------------------------------------------------
// File:   DisplayDialogs.cc
// Author: (c) 2024 Jens Kallup - paule32
// All rights reserved
//
// only for education, and non-profit usage !
// -----------------------------------------------------------------
# include "Observer.hpp"
# include "DisplayObserver.hpp"
# include "Connection.hpp"
#if 0
extern "C" {
// -----------------------------------------------------------------
// save the callee, and display a message on display device ...
// -----------------------------------------------------------------
ResultStruct*
MessageBox_QString_PChar_Callee(
    const char *prev, // previous callee
    char       *S1,   // message text
    char       *S2)   // message title
{
    // save result ...
    auto *result     = new ResultStruct;
    
    result->prev     = std::string(prev);
    result->args     = 2;

    result->arg[1]   = std::string("QSTRING"); result->ptr[1] = S1;
    result->arg[2]   = std::string("PCHAR"  ); result->ptr[2] = S2;

    // todo
    if (userProtocol) {
        result->username = std::string("paule32");
        result->time_srv = std::time  (nullptr);
    }
    
    resultList.push_back( result );
    
    std::cout << "prev: " << prev << std::endl;
    MessageBoxA(0, LPCTSTR(S1), LPCTSTR(S2), 0);
    return result;
}

// -----------------------------------------------------------------
// \brief
// -----------------------------------------------------------------
ResultStruct*
MessageBox_QString_PChar(
    char *S1,      // message text
    char *S2) {    // message title
    return(
        // call proxy ...
        MessageBox_QString_PChar_Callee(
        __FUNCTION__, S1, S2)
    );
}
};  // extern "C"

void TDisplay::update() {
    std::cout << "TDisplay: update" << std::endl;
}
#endif