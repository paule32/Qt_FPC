// -----------------------------------------------------------------
// File:   Visitor.cc
// Author: (c) 2023 Jens Kallup - paule32
// All rights reserved
//
// only for education, and non-profit usage !
// -----------------------------------------------------------------
# include "Visitor.hpp"

void useObjects(const std::vector< EventObserver*, UserObserver*> &v)
{
    for (const auto &item: v) {
        std::visit( Visitor{}, item );
    }
}
