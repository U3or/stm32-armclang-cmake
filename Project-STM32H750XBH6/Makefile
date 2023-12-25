# ################################################
#                      工程
# ################################################
TARGET = stm32-project

# 构建目录
BUILD_DIR = build

# CPU
CPU = cortex-m7
# 全局宏定义
DEFINITIONS = -DUSE_HAL_DRIVER -DSTM32H750xx

# debug build?
DEBUG = 1
# optimization
OPT = -O0
# fpu
FPU = -mfpu=fpv5-d16
# float-abi
FLOAT-ABI = -mfloat-abi=hard
# mcu
MCU = -mcpu=$(CPU) $(FPU) $(FLOAT-ABI)

# 导入编译链工具
include Platform/ARMGCC-Toolchain.mk

# ################################################
#                    源文件
# ################################################

INCLUDE_DIRS =  \
	-ICore/Inc \
	-IDrivers/STM32H7xx_HAL_Driver/Inc \
	-IDrivers/STM32H7xx_HAL_Driver/Inc/Legacy \
	-IDrivers/CMSIS/Device/ST/STM32H7xx/Include \
	-IDrivers/CMSIS/Include \
	-IUserApp

SOURCES =  \
	$(wildcard Core/Src/*.c) \
	$(wildcard Drivers/STM32H7xx_HAL_Driver/Src/*.c) \
	$(wildcard UserApp/*.c)


ASM_SOURCES = ${TOOLCHAIN_ASM_STARTUP}


# ################################################
#                    编译参数
# ################################################

# ASM编译参数
ASFLAGS = $(MCU) $(DEFINITIONS) $(INCLUDE_DIRS) $(OPT) ${TOOLCHAIN_AS_FLAGS}
# C编译参数
CFLAGS  = $(MCU) $(DEFINITIONS) $(INCLUDE_DIRS) $(OPT) ${TOOLCHAIN_CC_FLAGS}
# ################################################
#                    链接参数
# ################################################
LDFLAGS = ${TOOLCHAIN_LD_FLAGS}


# ################################################
#                  构建可执行文件
# ################################################
vpath %.c $(sort $(dir $(SOURCES)))
vpath %.s $(sort $(dir $(ASM_SOURCES)))
# list of objects
OBJECTS  =  $(addprefix $(BUILD_DIR)/,$(notdir $(SOURCES:.c=.o)))
OBJECTS +=  $(addprefix $(BUILD_DIR)/,$(notdir $(ASM_SOURCES:.s=.o)))


$(BUILD_DIR)/%.o: %.c   Makefile | $(BUILD_DIR) 
	$(CC) -c $(CFLAGS)  $< -o $@

$(BUILD_DIR)/%.o: %.s   Makefile | $(BUILD_DIR)
	$(AS) -c $(ASFLAGS) $< -o $@

$(BUILD_DIR)/$(TARGET).elf: $(OBJECTS) Makefile
	$(LD) $(OBJECTS) $(LDFLAGS) -o $@

$(BUILD_DIR):
	mkdir $@	

#######################################
# 命令
#######################################

all: $(BUILD_DIR)/$(TARGET).elf 


clean:
	del /Q /F $(BUILD_DIR)
# -rm -fR $(BUILD_DIR)
  


# *** EOF ***