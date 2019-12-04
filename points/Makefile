PROJPATH 	= $(PWD)
PROJNAME 	= $(notdir $(PROJPATH))

TARGET 		= $(PROJNAME).bin
ASM 		:= as
GPP			:= gcc
LINK		:= gcc

FLAGS 		:= -static

ASMSRCS 	:= $(wildcard ./gpio/*.s)
CPPSRCS		:= $(wildcard ./*.cpp)
ASMOBJS		:= $(ASMSRCS:.s=.o)
OBJS 		:= $(ASMOBJS) $(CPPOBJS)
OBJDIR		:= gpio_objects

.DEFAULT_GOAL := all

.PHONY: all
all: $(TARGET)

%.o: %.s
	$(ASM) -o $@ $<

$(TARGET): $(OBJS)
	mv $(OBJS) $(OBJDIR)

.PHONY: run
run: $(TARGET)
	./$(TARGET)

.PHONY: clean
clean:
	rm -rf $(TARGET) $(OBJS)
