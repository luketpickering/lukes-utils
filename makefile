CXX := g++

LDIR :=lib

CXXFLAGS := -fPIC $(ROOTCFLAGS) -g -std=c++11 -Wall
LDFLAGS := $(ROOTLDFLAGS) -Wl,-rpath=.

SRCF := CLITools.cxx PureGenUtils.cxx
HF := $(SRCF:.cxx=.hxx)
OBJ := $(SRCF:.cxx=.o)

TARGETSO := libPureGenUtils.so
TARGET := libPureGenUtils.a

.PHONEY: all clean

all: tests
	./UtilsTests.exe
	@echo ""
	@echo "*********************************************************************"
	@echo "Success. Built Utils."
	@echo "*********************************************************************"

tests: UtilsTests.cxx $(HF) $(SRCF) $(LDIR)/$(TARGET)
	$(CXX) -o UtilsTests.exe  UtilsTests.cxx $(CXXFLAGS) $(LDFLAGS) -L$(LDIR) -lPureGenUtils

%.o : %.cxx $(HF)
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(LDIR)/$(TARGET): $(OBJ)
	mkdir -p $(LDIR)
	ar rcs $@ $^

$(TARGETSO): $(SRCF) $(HF)
	$(CXX) $(CXXFLAGS) $(LDFLAGS) -shared $(SRCF) -o $@

clean:
	rm -rf UtilsTests.exe $(LDIR) ./*o
