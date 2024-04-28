// -----------------------------------------------------------------
// File:   SuperClass.hpp
// Author: (c) 2024 Jens Kallup - paule32
// All rights reserved
//
// only for education, and non-profit usage !
// -----------------------------------------------------------------
#ifndef __SUPERCLASS_HPP__
#define __SUPERCLASS_HPP__
#pragma once

# include "inc/Observer.hpp"

START_BOOSTRELEASE_NS
extern std::string demangle(const char*);

class Derived {
public:
    std::string class_name;
    std::string class_parent;
    
    Derived() {
        class_parent = std::string("");
        class_name   = std::string("Derived");
    }

    Derived(std::string p) {
        class_parent = std::string("");
        class_name   = std::string("Derived");
    }

    std::string ClassName() {
        std::cout << class_name << std::endl;
        return class_name;
    }
};

template <class Derived >
class SuperClass {
private:
    Derived * parent = nullptr;
public:
    std::string class_name;
    std::string class_parent;

    SuperClass() {
        class_parent = std::string(typeid(Derived).name());
        class_name   = std::string(typeid(SuperClass).name());
    }
    
    SuperClass(int value) {
        class_parent = std::string(typeid(Derived).name());
        class_name   = std::string(typeid(SuperClass).name());
    }

    SuperClass(std::string p) {
        class_parent = std::string(typeid(Derived).name());
        class_name   = std::string(typeid(SuperClass).name());
    }

    std::string ClassName() {
        return class_name;
    }
};

END_BOOSTRELEASE_NS

#endif  // __SUPERCLASS_HPP__
