RM	:= rm -f
ifeq ($(OS),Windows_NT)
# Windows Host
GCCPREFIX	?= 
else
GCCPREFIX	?= loongarch32r-linux-gnusf-
endif
QEMU := qemu-system-loongarch32
LD	:= $(GCCPREFIX)ld
CC	:= $(GCCPREFIX)gcc
OBJDIR	:= obj
INCLUDE	:= include
SRCDIR	:= kern
LDSCRIPT	:= kern/kernel.ld
SRC	:= $(foreach sdir, $(SRCDIR), $(wildcard $(sdir)/*.S))
OBJ	:= $(patsubst $(SRCDIR)/%.S, $(OBJDIR)/%.o, $(SRC))
TARGET	:= kernel.elf
ASFLAG	:= -nostdinc -nostdlib -fno-builtin -mabi=ilp32s -g

# 默认运行在QEMU中
override ON_FPGA ?= n
ifeq ($(ON_FPGA), y)
	MACH_DEF = -DMACH_FPGA
else
   	MACH_DEF = -DMACH_QEMU
endif
ASFLAG += $(MACH_DEF)
CONFIG_FILE := .config_$(ON_FPGA)_$(EN_INT)_$(EN_TLB)

.PHONY: all clean checkdirs show-utest

all: $(TARGET) kernel.bin show-utest

$(CONFIG_FILE):
	@rm -f .config_*
	touch $@

$(TARGET): checkdirs $(OBJ) $(LDSCRIPT)
	$(LD) $(OBJ) -T$(LDSCRIPT)

$(OBJ): $(OBJDIR)/%.o : $(SRCDIR)/%.S $(CONFIG_FILE)
	$(CC) -o $@ $< -c -I$(INCLUDE) $(ASFLAG)

checkdirs: $(OBJDIR)

$(OBJDIR):
	test -d $@ || mkdir $@

kernel.bin: $(TARGET)
	@$(GCCPREFIX)objcopy -j .text -j .got -O binary $< kernel.bin
	@$(GCCPREFIX)objdump -d $< > kernel.txt

show-utest: $(TARGET)
	@$(GCCPREFIX)objdump -D $< | grep "^[0-9a-f]\{8\} <UTEST_" | grep -n --color=auto 'UTEST_'

sim: $(TARGET)
	$(QEMU) -M ls3a5k32 -m 8M -kernel $< -nographic -monitor none -serial tcp::6666,server -s

debug: $(TARGET)
	$(QEMU) -M ls3a5k32 -m 8M -kernel $< -nographic -monitor none -serial tcp::6666,server -S -s

clean:
	-$(RM) -r $(OBJDIR)
