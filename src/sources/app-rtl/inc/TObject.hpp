// -----------------------------------------------------------------
// File:   TObject.hpp
// Author: (c) 2024 Jens Kallup - paule32
// All rights reserved
//
// only for education, and non-profit usage !
// -----------------------------------------------------------------
#ifndef __TOBJECT_HPP__
#define __TOBJECT_HPP__
#pragma once

# include "inc/SuperClass.hpp"

START_BOOSTRELEASE_NS
template <typename Derived>
class TObject: public SuperClass< Derived > {
private:
    Derived *parent;
public:
    std::string class_name;
    std::string class_parent;
    
    TObject() {
        class_parent  = demangle(typeid(Derived).name());
        class_name    = demangle(typeid(TObject).name());
    }
    
    TObject(int value) {
        class_parent  = demangle(typeid(Derived).name());
        class_name    = demangle(typeid(TObject).name());
    }
    
    TObject(std::string p) {
        class_parent  = demangle(typeid(Derived).name());
        class_name    = demangle(typeid(TObject).name());
    }
    
    std::string ClassName() const {
        return class_name;
    }
};
END_BOOSTRELEASE_NS

#endif  // __TOBJECT_HPP__
