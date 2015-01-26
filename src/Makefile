#-----------------------------------------------------------------------------*
#
# Product makefile. Uses mingw to cross compile cpp into a Windows binary.
#
#-----------------------------------------------------------------------------*
.PHONY : default all clean

WIN_64 := x86_64-w64-mingw32
WIN_32 := i686-w64-mingw32
ARCH   := $(WIN_64)

SYSROOT  := /usr
#CC     := $(SYSROOT)/bin/$(ARCH)-gcc
CXX     := $(SYSROOT)/bin/$(ARCH)-g++
#AR     := $(SYSROOT)/bin/$(ARCH)-ar
#LD     := $(SYSROOT)/bin/$(ARCH)-ld
#STRIP  := $(SYSROOT)/bin/$(ARCH)-strip

# array of .cpp that comprise the product
# each .cpp must include its .h
# each will be compiled separately
# then they will be linked together in a separate step
SOURCES := product.cpp lib1.cpp

# as the sources are compiled, store them in src/objects/*.o
OBJECTS_DIR := objects

# This is the goal output binary name
# you can set from command line with:
# make all EXECUTABLE=<something.exe>
EXECUTABLE := awesome.exe

CC_FLAGS := -D_WIN -std=c++11 
#--sysroot=$(SYSROOT)
#-s|--strip-all   : Omit all symbol information from the output file.
#-S|--strip-debug : Omit debugger symbol information (but not all symbols)
LD_FLAGS := -s 
# all -l after  -static are statically linked at compile time; 
# all -l before -static are dynamically linked at run time.
# -lws2_32 is winsock
# -lpthread is for threading
# -lpthread is static bc on one target it wasn't found as a dll
#LIBS := -lws2_32 -static -lpthread 
# NOTE: without any libs you will get a missing DLL on the target win machine (libgcc?????)
LIBS := -static -lpthread 

# this converts the SOURCES array into compile targets in the OBJECTS_DIR dir
ALL_OBJECT_FILES := $(patsubst %, $(OBJECTS_DIR)/%.o, $(SOURCES))

default: all

all: $(EXECUTABLE)

#--- Make object dir
$(OBJECTS_DIR):
	mkdir $(OBJECTS_DIR)

#--- C++ compile
# this target matches each element in ALL_OBJECT_FILES
$(OBJECTS_DIR)/%.cpp.o: %.cpp
	$(CXX) -c $< -o $@ $(CC_FLAGS)

#--- C++ link
# ensure the obj dir exists, and then check each element in SOURCES
# if all up to date or finished compiling, then do the link
$(EXECUTABLE): $(OBJECTS_DIR) $(ALL_OBJECT_FILES)
	$(CXX) $(ALL_OBJECT_FILES) -o $@ $(LD_FLAGS) $(LIBS)

clean:
	rm -f $(EXECUTABLE)
	rm -Rf $(OBJECTS_DIR)/
