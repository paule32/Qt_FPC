// -----------------------------------------------------------------
// File:   Visitor.hpp
// Author: (c) 2024 Jens Kallup - paule32
// All rights reserved
//
// only for education, and non-profit usage !
// -----------------------------------------------------------------
#ifndef __VISITOR_HPP__
#define __VISITOR_HPP__
#pragma once

# include "inc/Observer.hpp"
# include "inc/TObject.hpp"
# include "inc/SuperClass.hpp"

START_BOOSTRELEASE_NS
// -----------------------------------------------------------------
// \brief
// -----------------------------------------------------------------
struct ArgumentStruct {
    std::string  arg_str;   // argument name
    void*        arg_pos;   // argument memory position
};

// -----------------------------------------------------------------
// \brief
// -----------------------------------------------------------------
template <class Derived >
class EventObserver: public SuperClass< Derived > {
private:
    std::string                   func_name_beg;
    std::string                   func_desc_beg, func_desc_end;
    std::time_t                   func_time_beg, func_time_end;
    std::vector< ArgumentStruct > func_args_beg;
public:
    // ---------------------------------------------------------
    // \brief
    // ---------------------------------------------------------
    EventObserver() {
        func_name_beg = __FUNCTION__;
        func_time_beg = std::time(nullptr);
        
        func_desc_beg.clear();
        func_desc_beg = std::string("EventObserver() enter");
    }
    ~EventObserver() {
        func_args_beg.clear();
    }
    // ---------------------------------------------------------
    // \brief
    // ---------------------------------------------------------
    EventObserver& Enter() {
        func_name_beg = __FUNCTION__;
        func_time_beg = std::time(nullptr);
        
        func_desc_beg.clear();
        func_desc_beg = std::string("EventObserver(std::string,std::time_t) enter");
        
        return *this;
    }
    // ---------------------------------------------------------
    // \brief
    // ---------------------------------------------------------
    EventObserver& Enter(
        std::string                   fun_str,   // function name
        std::time_t                   fun_dat,   // time of call
        std::vector< ArgumentStruct > fun_arg) { // argument list
        std::cout << "EventObserver::Enter()" << std::endl;
        
        func_desc_beg.clear();
        func_desc_beg.append(std::string(
        "EventObserver(std::string,std::"
        "time_t,std::vector<ArgumentObserver>) enter"));
        
        func_name_beg = fun_str;
        func_time_beg = fun_dat;
        func_args_beg = fun_arg;
        
        return *this;
    }
    // ---------------------------------------------------------
    // \brief
    // ---------------------------------------------------------
    EventObserver& Leave() {
        std::cout << "EventObserver::Leave()" << std::endl;
        func_args_beg.clear();
        func_desc_end = std::string("EventObserver() Leave");
        func_time_end = std::time( nullptr );
        
        return *this;
    }
    EventObserver& operator << (const std::vector< ArgumentStruct > &value) {
        func_args_beg = value;
        return *this;
    }
    EventObserver& operator >> (const std::vector< ArgumentStruct > &value) {
        // todo
        return *this;
    }
    EventObserver& operator << (const ArgumentStruct &value) {
        if (func_args_beg.size() > 0) {
            func_args_beg.push_back( value );
        }
        return *this;
    }
    EventObserver& operator >> (const ArgumentStruct &value) {
        func_args_beg.pop_back();
        return *this;
    }
    EventObserver& operator << (const std::string &value) {
        func_name_beg = value;
        return *this;
    }
    EventObserver& operator >> (const std::string &value) {
        // todo
        return *this;
    }
    EventObserver& operator << (const std::time_t &value) {
        func_time_beg = value;
        return *this;
    }
    EventObserver& operator >> (const std::time_t &value) {
        func_time_end = value;
        return *this;
    }
};

template <class Derived >
class UserObserver: public SuperClass< Derived > {
private:
    std::time_t user_enter;
    std::time_t user_leave;
public:
    void Enter() {
    }
    void Enter(
        std::string             user_name,
        std::vector< uint16_t > user_priv)
        const {
        std::cout << "UserObserver::Enter()" << std::endl;
    }
    void Enter(
        std::string             user_name,
        std::time_t             user_time,
        std::vector< uint16_t > user_priv)
        const {
        std::cout << "UserObserver::Enter()" << std::endl;
    }
    void Leave() const {
        std::cout << "UserObserver::Leave()" << std::endl;
    }
};

template <class Derived >
struct Visitor {
    void operator()(EventObserver< Derived > &obj) {
        std::cout << "it is an Event -> ";
        obj.Enter();
        obj.Leave();
    }
    void operator()(UserObserver< Derived > &obj) {
        std::cout << "it is an User -> ";
        obj.Enter();
        obj.Leave();
    }
};

extern std::variant<EventObserver< int >*, UserObserver< int >* > SystemObserver;

END_BOOSTRELEASE_NS

#endif  // __VISITOR_HPP__
