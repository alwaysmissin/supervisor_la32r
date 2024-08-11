CC := gcc
GCCPREFIX	?= loongarch32r-linux-gnusf-
CFLAGS := -Iinclude
LDFLAGS := 
SRCDIR := src
BUILDDIR := build
OBJDIR := $(BUILDDIR)/objs
TARGET := $(BUILDDIR)/main
LDSCRIPT := $(SRCDIR)/kernel.ld

# 获取源文件列表
SRCS := $(wildcard $(SRCDIR)/*.c)
# 生成对应的目标文件列表
OBJS := $(SRCS:$(SRCDIR)/%.c=$(OBJDIR)/%.o)
# ARGS := -l $(BUILDDIR)/main.log

# 默认目标，编译可执行文件
all: $(TARGET)

# run: $(TARGET)
# 	$(TARGET) $(ARGS)

disasm: $(TARGET)
	$(GCCPREFIX)objdump -d $(TARGET) > $(BUILDDIR)/main.disasm

# 链接目标文件生成可执行文件
$(TARGET): $(OBJS) | $(BUILDDIR)
	$(GCCPREFIX)$(CC) -Wall -Wno-unused-label -O3 $^ $(LDFLAGS) -o $@ 

# 编译每个源文件生成对应的目标文件
$(OBJDIR)/%.o: $(SRCDIR)/%.c | $(OBJDIR)
	$(GCCPREFIX)$(CC) -Wall -Wno-unused-label -O3 $(CFLAGS) -c $< -o $@ 

# 创建 build 目录
$(BUILDDIR):
	mkdir -p $(BUILDDIR)

# 创建 objs 目录
$(OBJDIR):
	mkdir -p $(OBJDIR)

# 清理生成的文件
clean:
	$(RM) -r $(BUILDDIR)

.PHONY: all clean