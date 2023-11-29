
# ############################
# 编译器设置
# ############################

ARMCLANG_PATH := C:/Keil_v5/ARM/ARMCLANG/bin

CC  = $(ARMCLANG_PATH)/armclang
CXX = $(ARMCLANG_PATH)/armclang
AS  = $(ARMCLANG_PATH)/armclang

CP  = $(ARMCLANG_PATH)/fromelf
SZ  = $(ARMCLANG_PATH)/fromelf

# ############################
# 编译选项
# ############################

COMMON_FLAGS = --target=arm-arm-none-eabi -mcpu=${CPU}

FPU_COMPILE_FLAGS = -mfpu=fpv5-d16 -mfloat-abi=hard
FPU_LINKER_FLAGS  = --cpu ${CPU}.fp.dp")

C_FLAGS := 

CXX_FLAGS := 

ASM_FLAGS := 

LD_FLAGS :=


# 链接脚本
LDSCRIPT = Platform/ARMCLANG_STM32H750XBHx.sct