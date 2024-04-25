// -----------------------------------------------------------------
// File:   DisplayObserver.hpp
// Author: (c) 2023 Jens Kallup - paule32
// All rights reserved
//
// only for education, and non-profit usage !
// -----------------------------------------------------------------
#ifndef __DISPLAYOBSERVER_HPP__
#define __DISPLAYOBSERVER_HPP__
#pragma once

# include "ObserverClass.hpp"

class TDisplay: public TObserver {
public:
    void update();
};

#endif  // __DISPLAYOBSERVER_HPP__
