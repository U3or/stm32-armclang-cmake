
ifdef GCC_PATH
CC = $(GCC_PATH)/arm-none-eabi-gcc
AS = $(GCC_PATH)/arm-none-eabi-gcc -x assembler-with-cpp
CP = $(GCC_PATH)/arm-none-eabi-objcopy
SZ = $(GCC_PATH)/arm-none-eabi-size
else
CC = arm-none-eabi-gcc
AS = arm-none-eabi-gcc -x assembler-with-cpp
CP = arm-none-eabi-objcopy
SZ = arm-none-eabi-size
endif

# 生成二进制文件命令
HEX_COMMAND = $(CP) -O ihex
BIN_COMMAND = $(CP) -O binary -S


# 链接脚本
LDSCRIPT = Platform/ARMGCC_STM32H750XBHx_FLASH.ld
# 启动文件
ASM_STARTUP = Platform/ARMGCC_startup_stm32h750xx.s

