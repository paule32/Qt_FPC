// -----------------------------------------------------------------
// File:   SuperClass.cc
// Author: (c) 2024 Jens Kallup - paule32
// All rights reserved
//
// only for education, and non-profit usage !
// -----------------------------------------------------------------
# include "inc/SuperClass.hpp"

START_BOOSTRELEASE_NS
// -----------------------------------------------------------------
// \brief convert C++ type name to readable name ...
// -----------------------------------------------------------------
std::string demangle(const char* mangledName) {
#ifdef __GNUC__
    int status = 0;
    char *demangled = abi::__cxa_demangle(mangledName, NULL, NULL, &status);
    if (status == 0 && demangled != NULL) {
        std::string result(demangled);
        free(demangled);
        return result;
    }   else {
        return std::string(mangledName);
    }
#else
#error demangle only for GNU C++
#endif
}

END_BOOSTRELEASE_NS
