# ############################
# 编译器设置
# ############################
GCC_PATH := D:\env\arm-none-eabi-gcc\13.2-Rel1\bin

CC  = $(GCC_PATH)/arm-none-eabi-gcc
CXX = $(GCC_PATH)/arm-none-eabi-gcc
AS  = $(GCC_PATH)/arm-none-eabi-gcc -x assembler-with-cpp

LD  = $(GCC_PATH)/arm-none-eabi-gcc

CP = $(GCC_PATH)/arm-none-eabi-objcopy
SZ = $(GCC_PATH)/arm-none-eabi-size

# 链接脚本
TOOLCHAIN_LDSCRIPT = Platform/ARMGCC-STM32H750XBHx_FLASH.ld
# 启动文件
TOOLCHAIN_ASM_STARTUP = Platform/ARMGCC-startup_stm32h750xx.s


# ############################
# 编译参数 
# ############################

MCU += -mthumb

TOOLCHAIN_CC_FLAGS += \
	-Wall -fdata-sections -ffunction-sections \
	-g -gdwarf-2 -MMD -MP -MF"$(@:%.o=%.d)"	\
	-Wa,-a,-ad,-alms=${BUILD_DIR}/$(notdir $(<:.c=.lst))

TOOLCHAIN_CX_FLAGS = 

TOOLCHAIN_AS_FLAGS = -Wall -fdata-sections -ffunction-sections

# ############################
# 链接参数 
# ${CPU}来自主Makefile
# ############################
# 链接库
TOOLCHAIN_LIBS = -lc -lm -lnosys 

TOOLCHAIN_LIBDIR = 

TOOLCHAIN_LD_FLAGS = \
	${MCU} -specs=nano.specs -T$(TOOLCHAIN_LDSCRIPT) \
	$(TOOLCHAIN_LIBDIR) $(TOOLCHAIN_LIBS) \
	-Wl,-Map=${BUILD_DIR}/${TARGET}.map,--cref \
	-Wl,--gc-sections \
	-Wl,--no-warn-rwx-segments

# ############################
# 命令
# ############################
# 生成二进制文件命令
HEX_COMMAND = $(CP) -O ihex
BIN_COMMAND = $(CP) -O binary -S


