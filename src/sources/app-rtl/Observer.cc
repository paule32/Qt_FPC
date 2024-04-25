// -----------------------------------------------------------------
// File:   Observer.cc
// Author: (c) 2023 Jens Kallup - paule32
// All rights reserved
//
// only for education, and non-profit usage !
// -----------------------------------------------------------------
# include "Connection.hpp"
# include "ObserverClass.hpp"

std::vector< ResultStruct* > resultList;

void
TConnection::registerDisplay(
    TObserver *observer) {
    observers.push_back(observer);
}
    
void
TConnection::removeDisplay(
    TObserver *observer) {
    // todo
}
    
void
TConnection::notifyObservers() {
    for (TObserver *observer: observers) {
        observer->update();
    }
}
    
void
TConnection::setValue() {
    // set new values
    notifyObservers();
}

// -----------------------------------------------------------------
// \brief
// -----------------------------------------------------------------
ResultStruct*
TConnection::connect(
    uint32_t timeout) {
    std::cout << "sss" << std::endl;
    // save result ...

    auto *result   = new ResultStruct;

    result->prev   = __FUNCTION__;
    result->args   = 1;
    
    result->arg[1] = "uint32_t";
    result->ptr[1] = &timeout;
    
    result->username = std::string("paule32");
    result->time_srv = std::time  ( nullptr );
    
    resultList.push_back( result );
    return result;
}
