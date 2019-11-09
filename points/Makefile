PROJPATH 	= $(PWD)
PROJNAME 	= $(notdir $(PROJPATH))

TARGET 		= $(PROJNAME)
ASM 		:= aarch64-linux-gnu-as
GPP			:= aarch64-linux-gnu-g++
LINK		:= aarch64-linux-gnu-g++

FLAGS 		:= -static

ASMSRCS 	:= $(wildcard ./*.s)
CPPSRCS		:= $(wildcard ./*.cpp)
ASMOBJS		:= $(ASMSRCS:.s=.o)
CPPOBJS		:= $(CPPSRCS:.cpp=.o)
OBJS 		:= $(ASMOBJS) $(CPPOBJS)

.DEFAULT_GOAL := all

.PHONY: all
all: $(TARGET)

%.o: %.s
	$(ASM) -o $@ $<

%.o: %.cpp
	$(GPP) -c -o $@ $<

$(TARGET): $(OBJS)
	$(LINK) $(FLAGS) -o $@ $^

.PHONY: run
run: $(TARGET)
	./$(TARGET)

.PHONY: clean
clean:
	rm -rf $(TARGET) $(OBJS)
