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
INCDIR = ./inc
OBJDIR = ./obj
DLLDIR = ../../tests

TARGET = $(DLLDIR)/app_rtl.dll

HEADER = $(wildcard $(INCDIR)/*.hpp)
SOURCE = $(wildcard $(SRCDIR)/*.cc)

OBJS   = $(patsubst $(SRCDIR)/%.cc,$(OBJDIR)/%.o,$(SOURCE))
INCL   = -I. -I$(INCDIR)

all: PRETASKS $(TARGET)

PRETASKS:
	rm -rf $(OBJDIR)
	mkdir  $(OBJDIR)

$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -shared -o $@ $(OBJS)
	strip $@

$(OBJDIR)/%.o: $(SRCDIR)/%.cc $(HEADER)
	$(CC) $(CFLAGS) $(INCL) -c $< -o $@

#	cp $@ ../../tests/$@
