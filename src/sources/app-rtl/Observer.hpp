// -----------------------------------------------------------------
// File:   Observer.hpp
// Author: (c) 2023 Jens Kallup - paule32
// All rights reserved
//
// only for education, and non-profit usage !
// -----------------------------------------------------------------
#pragma once

# include <windows.h>

# include <stdio.h>
# include <stdlib.h>
# include <strings.h>

# include <iostream>
# include <string>
# include <map>
# include <vector>

#define result(x) return x

// -----------------------------------------------------------------
// \brief this structure holds the return values for a given member.
// -----------------------------------------------------------------
struct ResultStruct {
    std::uint32_t                     args;
    std::string                       prev;
    std::map< uint32_t, std::string > arg ;
    std::map< uint32_t, void*       > ptr ;
    
};

extern std::map< std::string, ResultStruct* > resultList;
