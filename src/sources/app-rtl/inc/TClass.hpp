// -----------------------------------------------------------------
// File:   TClass.hpp
// Author: (c) 2024 Jens Kallup - paule32
// All rights reserved
//
// only for education, and non-profit usage !
// -----------------------------------------------------------------
#ifndef __TCLASS_HPP__
#define __TCLASS_HPP__
#pragma once

# include "inc/Observer.hpp"
# include "inc/SuperClass.hpp"
# include "TObject.hpp"

START_BOOSTRELEASE_NS
template <class Derived = TObject< int> >
class TClass: public SuperClass< Derived > {
private:
    Derived *parent;
public:
    std::string class_name;
    std::string class_parent;
    
    TClass() {
        class_parent = std::string(demangle(typeid(Derived).name()));
        class_name   = std::string(demangle(typeid(TClass ).name()));
    }
    
    TClass(int value) {
        class_parent = std::string(demangle(typeid(Derived).name()));
        class_name   = std::string(demangle(typeid(TClass ).name()));
    }
    TClass(std::string p) {
        class_parent = std::string(demangle(typeid(Derived).name()));
        class_name   = std::string(demangle(typeid(TClass ).name()));
    }
    
    std::string ClassName() const {
        return class_name;
    }
};
END_BOOSTRELEASE_NS

#endif  // __TCLASS_HPP__
