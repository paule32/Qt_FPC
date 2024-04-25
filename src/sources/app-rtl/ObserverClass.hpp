// -----------------------------------------------------------------
// File:   ObserverClass.hpp
// Author: (c) 2023 Jens Kallup - paule32
// All rights reserved
//
// only for education, and non-profit usage !
// -----------------------------------------------------------------
#pragma once

# include "Observer.hpp"

class TObserver {
public:
    virtual void update() = 0;
};
