// -----------------------------------------------------------------
// File:   Visitor.cc
// Author: (c) 2024 Jens Kallup - paule32
// All rights reserved
//
// only for education, and non-profit usage !
// -----------------------------------------------------------------
# include "inc/Observer.hpp"
# include "inc/Visitor.hpp"
# include "inc/SuperClass.hpp"
# include "inc/TClass.hpp"

START_BOOSTRELEASE_NS
template <typename Derived >
class TFoo: public SuperClass< Derived > {
private:
    Derived *parent;
public:
    std::string class_name;
    std::string class_parent;
    TFoo() {
        class_parent = std::string(typeid(Derived).name());
        class_name   = demangle(typeid(TFoo).name());
    }
    TFoo(std::string p) {
        class_parent = std::string(typeid(Derived).name());
        class_name   = demangle(typeid(TFoo).name());
    }
    std::string ClassName()  {
        return class_name;
    }
};

extern "C" void testFoo( ) {
    TFoo< TClass<> > foo;
    std::cout << foo.ClassName() << std::endl;
}

void useObjects(
    std::vector< EventObserver< int >*>
    &v)
{
    //for (const auto &item: v) {
//        std::visit( Visitor{}, item );
//    }
}

END_BOOSTRELEASE_NS
