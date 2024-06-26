// -----------------------------------------------------------------
// File:   Connection.hpp
// Author: (c) 2024 Jens Kallup - paule32
// All rights reserved
//
// only for education, and non-profit usage !
// -----------------------------------------------------------------
#ifndef __CONNECTION_HPP__
#define __CONNECTION_HPP__
#pragma once

# include "inc/Observer.hpp"
# include "inc/ObserverClass.hpp"

class TConnection {
private:
//    std::vector< TObserver *> observers;
public:
//    void registerDisplay(TObserver *observer);
//    void removeDisplay(TObserver *observer);
    void notifyObservers();
    void setValue();

    struct ResultStruct* connect(uint32_t timeout=10000);
    
    std::function<void(void)> onAfterConnect;
    std::function<void(void)> onBeforeConnect;
};

#endif  // __CONNECTION_HPP__
