// -----------------------------------------------------------------
// File:   Observer.hpp
// Author: (c) 2024 Jens Kallup - paule32
// All rights reserved
//
// only for education, and non-profit usage !
// -----------------------------------------------------------------
#ifndef __OBSERVER_HPP__
#define __OBSERVER_HPP__
#pragma once

# include <windows.h>

# include <stdio.h>
# include <stdlib.h>
# include <strings.h>

# include <iostream>
# include <cstdio>
# include <typeinfo>
# include <string>
# include <variant>
# include <map>
# include <vector>
# include <functional>
# include <ctime>

# include <cxxabi.h> // header for __cxa_demangle

# define       BOOSTRELEASE_NS BOOSTnonProductive
# define START_BOOSTRELEASE_NS namespace BOOSTRELEASE_NS {
# define   END_BOOSTRELEASE_NS }

// -----------------------------------------------------------------
// \brief this structure holds the return values for a given member.
// -----------------------------------------------------------------
#if 0
struct ResultStruct {
    std::uint32_t                     args;
    std::string                       prev;
    std::string                   username;
    std::time_t                   time_srv;

    std::map< uint32_t, std::string > arg ;
    std::map< uint32_t, void*       > ptr ;
};

extern std::vector< ResultStruct* > resultList;
extern bool userProtocol;

// -----------------------------------------------------------------
// \brief
// -----------------------------------------------------------------
class ObserverResultClass {
private:
public:
    ObserverResultClass();
    ~ObserverResultClass();
    
    ResultStruct* add( ResultStruct* );
    ResultStruct* del( ResultStruct* );
};
#endif

#endif  // __OBSERVER_HPP__
