// -----------------------------------------------------------------
// File:   Observer.cc
// Author: (c) 2024 Jens Kallup - paule32
// All rights reserved
//
// only for education, and non-profit usage !
// -----------------------------------------------------------------
# include "Connection.hpp"
# include "ObserverClass.hpp"

#if 0
std::vector< ResultStruct* > resultList;
bool userProtocol = false;

// -----------------------------------------------------------------
// \brief
// -----------------------------------------------------------------
ResultStruct*
TConnection::registerDisplay(
    TObserver *observer) {
        
    // save result ...
    auto *result   = new ResultStruct;

    result->prev   = __FUNCTION__;
    result->args   = 1;
    
    result->arg[1] = "TObserver";
    result->ptr[1] = observer;
    
    if (userProtocol) {
        result->username = std::string("paule32");
        result->time_srv = std::time  ( nullptr );
    }
    
    resultList.add( result );
    observers .add(observer);
    
    return result;
}

// -----------------------------------------------------------------
// \brief
// -----------------------------------------------------------------
ResultStruct*
TConnection::removeDisplay(
    TObserver *observer) {
    // todo
    
    // save result ...
    auto *result   = new ResultStruct;

    result->prev   = __FUNCTION__;
    result->args   = 1;
    
    result->arg[1] = "TObserver";
    result->ptr[1] = observer;
    
    if (userProtocol) {
        result->username = std::string("paule32");
        result->time_srv = std::time  ( nullptr );
    }
    
    resultList.add( result );
    return result;
}

// -----------------------------------------------------------------
// \brief
// -----------------------------------------------------------------
ResultStruct*
TConnection::notifyObservers()
{
    // save result ...
    auto *result   = new ResultStruct;

    result->prev   = __FUNCTION__;
    result->args   = 1;
    
    result->arg[1] = "uint32_t";
    result->ptr[1] = &timeout;
    
    if (userProtocol) {
        result->username = std::string("paule32");
        result->time_srv = std::time  ( nullptr );
    }
    
    resultList.push_back( result );
    
    for (TObserver *observer: observers) {
        observer->update();
    }
    
    resultList.add( result );
    return result;
}

// -----------------------------------------------------------------
// \brief
// -----------------------------------------------------------------
ResultStruct*
TConnection::setValue()
{
    // save result ...
    auto *result   = new ResultStruct;

    result->prev   = __FUNCTION__;
    result->args   = 0;
    
    result->arg[1] = "void";
    
    if (userProtocol) {
        result->username = std::string("paule32");
        result->time_srv = std::time  ( nullptr );
    }
    resultList.add( result );
    
    // set new values
    notifyObservers();
    return result;
}

// -----------------------------------------------------------------
// \brief
// -----------------------------------------------------------------
ResultStruct*
TConnection::connect(
    uint32_t timeout) {

    // save result ...
    auto *result   = new ResultStruct;

    result->prev   = __FUNCTION__;
    result->args   = 1;
    
    result->arg[1] = "uint32_t";
    result->ptr[1] = &timeout;
    
    if (userProtocol) {
        result->username = std::string("paule32");
        result->time_srv = std::time  ( nullptr );
    }
    
    resultList.add( result );
    return result;
}

#endif
