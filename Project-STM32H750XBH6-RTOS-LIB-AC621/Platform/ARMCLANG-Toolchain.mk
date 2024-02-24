# ############################
# 编译器设置
# ############################
ARMCLANG_PATH := C:/Keil_v5/ARM/ARMCLANG/bin

CC  = $(ARMCLANG_PATH)/armclang
CXX = $(ARMCLANG_PATH)/armclang
AS  = $(ARMCLANG_PATH)/armclang

LD  = $(ARMCLANG_PATH)/armlink

# 链接脚本地址
TOOLCHAIN_LDSCRIPT = Platform/ARMCLANG-STM32H750XBHx.sct
# 启动文件地址
TOOLCHAIN_ASM_STARTUP = Platform/ARMCLANG-startup_stm32h750xx.s

# ############################
# 编译参数 
# ############################

MCU += --target=arm-arm-none-eabi

TOOLCHAIN_CC_FLAGS =  \
	-w -gdwarf-4 -MD -fno-rtti -funsigned-char \
	-fshort-enums -fshort-wchar -ffunction-sections
	
TOOLCHAIN_CX_FLAGS = 

TOOLCHAIN_AS_FLAGS = -masm=auto -gdwarf-4

# ############################
# 链接参数 
# ${CPU}来自主Makefile
# ############################
TOOLCHAIN_LD_FLAGS = \
	--cpu ${CPU}.fp.dp \
	--strict --scatter $(TOOLCHAIN_LDSCRIPT) \
	--summary_stderr --info summarysizes \
	--load_addr_map_info --xref --callgraph --symbols --map \
	--info sizes --info totals --info unused --info veneers

