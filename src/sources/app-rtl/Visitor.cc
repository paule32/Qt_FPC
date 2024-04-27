// -----------------------------------------------------------------
// File:   Visitor.cc
// Author: (c) 2024 Jens Kallup - paule32
// All rights reserved
//
// only for education, and non-profit usage !
// -----------------------------------------------------------------
# include "Visitor.hpp"

template <typename Derived >
class TFoo: public SuperClass< Derived > {
private:
    Derived *parent;
public:
    std::string class_name;
    std::string class_parent;
    TFoo() {
        class_parent = std::string(typeid(Derived).name());
        class_name   = std::string("TClass");
        std::cout << "TFOO" << std::endl;
    }
    TFoo(std::string p) {
        class_parent  = std::string(typeid(Derived).name());
        class_name    = "TFoo";
        std::cout << "TFOO" << std::endl;
    }
    std::string ClassName()  {
        std::cout << class_name << std::endl;
        return class_name;
    }
};

extern "C" void testFoo( ) {
    TFoo< TClass > foo;
    std::cout << foo.ClassName() << std::endl;
}

void useObjects(
    std::vector<
        EventObserver*>
    &v)
{
    //for (const auto &item: v) {
//        std::visit( Visitor{}, item );
//    }
}
