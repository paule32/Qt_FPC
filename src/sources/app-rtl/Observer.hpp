// -----------------------------------------------------------------
// File:   Observer.hpp
// Author: (c) 2023 Jens Kallup - paule32
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
# include <string>
# include <map>
# include <vector>
# include <functional>
# include <ctime>

# include "Connection.hpp"

class TConnection;
class TObserver;

// -----------------------------------------------------------------
// \brief this structure holds the return values for a given member.
// -----------------------------------------------------------------
struct ResultStruct {
    std::uint32_t                     args;
    std::string                       prev;
    std::string                   username;
    std::time_t                   time_srv;

    std::map< uint32_t, std::string > arg ;
    std::map< uint32_t, void*       > ptr ;
};

extern std::vector< ResultStruct* > resultList;

#endif  // __OBSERVER_HPP__
