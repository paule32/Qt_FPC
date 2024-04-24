#include <stdio.h>
#include <stdlib.h>
#include <strings.h>

#include <iostream>
#include <string>

extern "C" void TestTest(void)
{
    std::cout << "huch huchaya tucha\n" << std::endl;
}

extern "C" void C_TestTest(char *s)
{
    std::cout << "--> " << s << std::endl;
}

extern "C" void QString_Create_QString(void *p) { std::cout << "Create: QString" << std::endl; }
extern "C" void QString_Create_PChar  (void *p) { std::cout << "Create: PChar"   << std::endl; }
extern "C" void QString_Append_QString(void *p) { std::cout << "Append: QString" << std::endl; }
