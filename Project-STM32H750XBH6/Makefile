
# ################################################
# 工程
# ################################################
TARGET = stm32-project

CPU = cortex-m7
# 构建目录
BUILD_DIR = build

# ################################################
# 源文件
# ################################################

INCLUDE_DIRS =  \
	-ICore/Inc \
	-IDrivers/STM32H7xx_HAL_Driver/Inc \
	-IDrivers/STM32H7xx_HAL_Driver/Inc/Legacy \
	-IDrivers/CMSIS/Device/ST/STM32H7xx/Include \
	-IDrivers/CMSIS/Include

C_SOURCES =  \
	$(wildcard Core/Src/*.c) \
	$(wildcard Drivers/STM32H7xx_HAL_Driver/Src/*.c)


ASM_SOURCES =  \
	Platform/ARMGCC_startup_stm32h750xx.s


# ################################################
# 编译参数
# ################################################

# 全局宏定义
DEFINITIONS = -DUSE_HAL_DRIVER -DSTM32H750xx
# 导入编译链工具
include Platform/ARMGCC-Toolchain.mk
# debug build?
DEBUG = 1
# optimization
OPT = -Og
# fpu
FPU = -mfpu=fpv5-d16
# float-abi
FLOAT-ABI = -mfloat-abi=hard
# mcu
MCU = -mcpu=$(CPU) -mthumb $(FPU) $(FLOAT-ABI)

# 编译参数
ASFLAGS = $(MCU) $(DEFINITIONS) $(INCLUDE_DIRS) $(OPT) -Wall -fdata-sections -ffunction-sections
# 编译参数
CFLAGS += $(MCU) $(DEFINITIONS) $(INCLUDE_DIRS) $(OPT) -Wall -fdata-sections -ffunction-sections


ifeq ($(DEBUG), 1)
CFLAGS += -g -gdwarf-2
endif

# Generate dependency information
CFLAGS += -MMD -MP -MF"$(@:%.o=%.d)"

# ################################################
# 链接参数
# LDSCRIPT为外部变量, 在Platform对应的编译链配置中定义
# ################################################

# libraries
LIBS = -lc -lm -lnosys 
LIBDIR =

LDFLAGS = \
	$(MCU) -specs=nano.specs -T$(LDSCRIPT) $(LIBDIR) $(LIBS) \
	-Wl,-Map=$(BUILD_DIR)/$(TARGET).map,--cref -Wl,--gc-sections

# ################################################
# 构建可执行文件
# ################################################
# list of objects
OBJECTS = $(addprefix $(BUILD_DIR)/,$(notdir $(C_SOURCES:.c=.o)))
vpath %.c $(sort $(dir $(C_SOURCES)))
# list of ASM program objects
OBJECTS += $(addprefix $(BUILD_DIR)/,$(notdir $(ASM_SOURCES:.s=.o)))
vpath %.s $(sort $(dir $(ASM_SOURCES)))

$(BUILD_DIR)/%.o: %.c Makefile | $(BUILD_DIR) 
	$(CC) -c $(CFLAGS) -Wa,-a,-ad,-alms=$(BUILD_DIR)/$(notdir $(<:.c=.lst)) $< -o $@

$(BUILD_DIR)/%.o: %.s Makefile | $(BUILD_DIR)
	$(AS) -c $(CFLAGS) $< -o $@

$(BUILD_DIR)/$(TARGET).elf: $(OBJECTS) Makefile
	$(CC) $(OBJECTS) $(LDFLAGS) -o $@
	$(SZ) $@

$(BUILD_DIR)/%.hex: $(BUILD_DIR)/%.elf | $(BUILD_DIR)
	$(HEX_COMMAND) $< $@
	
$(BUILD_DIR)/%.bin: $(BUILD_DIR)/%.elf | $(BUILD_DIR)
	$(BIN_COMMAND) $< $@	
	
$(BUILD_DIR):
	mkdir $@		

#######################################
# 命令
#######################################

# default action: build all
all: $(BUILD_DIR)/$(TARGET).elf $(BUILD_DIR)/$(TARGET).hex $(BUILD_DIR)/$(TARGET).bin


clean:
	del /Q /F $(BUILD_DIR)
# -rm -fR $(BUILD_DIR)
  

# 依赖
# -include $(wildcard $(BUILD_DIR)/*.d)

# *** EOF ***