# -----------------------------------------------------------------
# File:   Makefile
# Author: (c) 2024 Jens Kallup - paule32
# All rights reserved
#
# only for education, and non-profit usage !
# -----------------------------------------------------------------
CC     = g++
CFLAGS = -O2 -m64 -fPIC -std=c++20 -Wno-write-strings

SRCDIR = .
INCDIR = .
OBJDIR = ../../tests

TARGET = $(OBJDIR)/app_rtl.dll

HEADER = $(wildcard $(INCDIR)/*.hpp)
SOURCE = $(wildcard $(SRCDIR)/*.cc)

OBJS   = $(patsubst $(SRCDIR)/%.cc,$(OBJDIR)/%.o,$(SOURCE))

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -shared -o $@ $(OBJS)
	strip $@

$(OBJDIR)/%.o: $(SRCDIR)/%.cc $(HEADER)
	$(CC) $(CFLAGS) -c $< -o $@

#	cp $@ ../../tests/$@
