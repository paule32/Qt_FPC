// -----------------------------------------------------------------
// File:   ObserverClass.hpp
// Author: (c) 2023 Jens Kallup - paule32
// All rights reserved
//
// only for education, and non-profit usage !
// -----------------------------------------------------------------
#ifndef __OBSERVERCLASS_HPP__
#define __OBSERVERCLASS_HPP__
#pragma once

class TObserver {
public:
    virtual void update() = 0;
};

#endif  // __OBSERVERCLASS_HPP__
