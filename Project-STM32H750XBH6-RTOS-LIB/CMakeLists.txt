
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_VERSION 1)
cmake_minimum_required(VERSION 3.26)

set(CMAKE_C_COMPILER_WORKS 		TRUE)
set(CMAKE_CXX_COMPILER_WORKS 	TRUE)

set(CMAKE_SYSTEM_PROCESSOR cortex-m7)

# ############################
# 工程
# ############################
set(PROJECT_NAME stm32-project)

# ############################
# 编译器设置
# ############################
set(ARMCLANG_TOOLCHAIN_PATH "C:/Keil_v5/ARM/ARMCLANG/bin")
set(ARMCLANG_TOOLCHAIN_INC "C:/Keil_v5/ARM/ARMCLANG/include")
set(ARMCLANG_TOOLCHAIN_LIB "C:/Keil_v5/ARM/ARMCLANG/lib")
# 编译器
set(CMAKE_C_COMPILER 	${ARMCLANG_TOOLCHAIN_PATH}/armclang.exe)
set(CMAKE_CXX_COMPILER 	${ARMCLANG_TOOLCHAIN_PATH}/armclang.exe)
set(CMAKE_ASM_COMPILER  ${ARMCLANG_TOOLCHAIN_PATH}/armclang.exe)
# 链接器
set(CMAKE_C_LINK_EXECUTABLE     ${ARMCLANG_TOOLCHAIN_PATH}/armlink.exe)
set(CMAKE_CXX_LINK_EXECUTABLE   ${ARMCLANG_TOOLCHAIN_PATH}/armlink.exe)
set(CMAKE_ASM_LINK_EXECUTABLE   ${ARMCLANG_TOOLCHAIN_PATH}/armlink.exe)
# 目标文件转换工具
set(FROMELF_EXECUTABLE ${ARMCLANG_TOOLCHAIN_PATH}/fromelf.exe)


# ############################
# 编译参数
# ############################
# FPU 设置
set(FPU_COMPILE_FLAGS "-mfpu=fpv5-d16 -mfloat-abi=hard")
set(FPU_LINKER_FLAGS "--cpu ${CMAKE_SYSTEM_PROCESSOR}.fp.dp")

set(COMMON_FLAGS "--target=arm-arm-none-eabi -mcpu=${CMAKE_SYSTEM_PROCESSOR}")

set(CMAKE_ASM_FLAGS_INIT " \
	${COMMON_FLAGS} ${FPU_COMPILE_FLAGS} \
	-masm=auto -c -gdwarf-4"
)
set(CMAKE_C_FLAGS_INIT " \
	-xc -std=c99 -w -c -O1 -gdwarf-4 -MD \
	${FPU_COMPILE_FLAGS} ${COMMON_FLAGS} \
	-fno-rtti -funsigned-char -fshort-enums \
	-fshort-wchar -ffunction-sections"
)

set(CMAKE_CXX_FLAGS_INIT ${CMAKE_C_FLAGS_INIT})

# ############################
# 链接参数
# ############################
# 链接脚本地址
set(SECTIONS_SCRIPT_PATH "${CMAKE_SOURCE_DIR}/MDK-ARM/${PROJECT_NAME}/${PROJECT_NAME}.sct") 

set(CMAKE_EXE_LINKER_FLAGS_INIT " \
	${FPU_LINKER_FLAGS} \
	--strict --scatter ${SECTIONS_SCRIPT_PATH} \
	--summary_stderr --info summarysizes --map \
	--load_addr_map_info --xref --callgraph --symbols \
	--info sizes --info totals --info unused --info veneers"
)


project(${PROJECT_NAME} C CXX ASM)

#include_directories(${ARMCLANG_TOOLCHAIN_INC})
include_directories(
	Core/Inc 
	Drivers/STM32H7xx_HAL_Driver/Inc
	Drivers/STM32H7xx_HAL_Driver/Inc/Legacy
	Drivers/CMSIS/Device/ST/STM32H7xx/Include
	Drivers/CMSIS/Include
	Drivers/CMSIS/Core/Include
	UserApp
)

add_definitions(-DUSE_HAL_DRIVER -DSTM32H750xx)

file(GLOB_RECURSE SOURCES 
	"MDK-ARM/startup_stm32h750xx.s"
	"Core/*.*"
	"Drivers/*.*"
	"UserApp/user_main.c"
)

#生成可执行文件
add_executable(${PROJECT_NAME} ${SOURCES})


# cmake
# cmake .. -G "MinGW Makefiles" && mingw32-make
# keil
# uv4 -r stm32-project.uvprojx -j0 -o ./log.txt


