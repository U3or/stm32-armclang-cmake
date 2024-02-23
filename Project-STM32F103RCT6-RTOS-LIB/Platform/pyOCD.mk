#######################################
# 工具
#######################################
PYOCD_PATH = C:/Users/Q/.conda/envs/pyocd/Scripts

PYOCD = $(PYOCD_PATH)/pyocd


#######################################
# 参数
#######################################
FIRMWARE = ${BUILD_DIR}/${TARGET}.elf

PYOCD_CONFIG_FILE = Platform/pyOcd-config.yaml

DOWNLOAD_FLAGS = $(FIRMWARE) --target STM32F103RC

DEBUG_FLAGS = --elf $(FIRMWARE) --port 65533 --target STM32F103RC -f 10M -O rtos.enable=False

#######################################
# 命令
#######################################
load:
	$(PYOCD) flash $(DOWNLOAD_FLAGS)

server:
	$(PYOCD) gdbserver $(DEBUG_FLAGS) 
# --config $(PYOCD_CONFIG_FILE)

debug:
	arm-none-eabi-gdb $(FIRMWARE) 
# target remote localhost:65533
