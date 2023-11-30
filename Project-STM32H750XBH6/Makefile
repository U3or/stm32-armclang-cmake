
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

SOURCES =  \
	$(wildcard Core/Src/*.c) \
	$(wildcard Drivers/STM32H7xx_HAL_Driver/Src/*.c)


ASM_SOURCES = ${ASM_STARTUP}


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
OPT = -Ofast

# fpu
FPU = -mfpu=fpv5-d16
# float-abi
FLOAT-ABI = -mfloat-abi=hard
# mcu
MCU = -mcpu=$(CPU) -mthumb $(FPU) $(FLOAT-ABI) 

# ASM编译参数
ASFLAGS = $(MCU) $(DEFINITIONS) $(INCLUDE_DIRS) $(OPT) -Wall -fdata-sections -ffunction-sections
# C编译参数
CFLAGS += $(MCU) $(DEFINITIONS) $(INCLUDE_DIRS) $(OPT) -Wall -fdata-sections -ffunction-sections


ifeq ($(DEBUG), 1) 
    CFLAGS += -g -gdwarf-2
endif

# Generate dependency information
CFLAGS += -MMD -MP -MF"$(@:%.o=%.d)"

CFLAGS += -Wa,-a,-ad,-alms=$(BUILD_DIR)/$(notdir $(<:.c=.lst))

# ################################################
# 链接参数
# LDSCRIPT为外部变量, 在Platform对应的编译链配置中定义
# ################################################

# 链接库
LIBS = -lc -lm -lnosys 

LIBDIR = 

LDFLAGS = \
	$(MCU) -specs=nano.specs -T$(LDSCRIPT) $(LIBDIR) $(LIBS) \
	-Wl,-Map=$(BUILD_DIR)/$(TARGET).map,--cref -Wl,--gc-sections


# ################################################
# 构建可执行文件
# ################################################
# vpath %.cpp $(sort $(dir $(SOURCES)))
vpath %.c $(sort $(dir $(SOURCES)))
vpath %.s $(sort $(dir $(ASM_SOURCES)))
# list of objects
OBJECTS =  $(addprefix $(BUILD_DIR)/,$(notdir $(SOURCES:.c=.o)))
# OBJECTS += $(addprefix $(BUILD_DIR)/,$(notdir $(SOURCES:.cpp=.o)))
OBJECTS += $(addprefix $(BUILD_DIR)/,$(notdir $(ASM_SOURCES:.s=.o)))


$(BUILD_DIR)/%.o: %.c   Makefile | $(BUILD_DIR) 
	$(CC) -c $(CFLAGS)  $< -o $@

# $(BUILD_DIR)/%.o: %.cpp Makefile | $(BUILD_DIR)
# 	$(CXX) -c $(ASFLAGS) $< -o $@

$(BUILD_DIR)/%.o: %.s   Makefile | $(BUILD_DIR)
	$(AS) -c $(ASFLAGS) $< -o $@

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