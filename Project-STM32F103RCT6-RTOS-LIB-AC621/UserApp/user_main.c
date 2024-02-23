#include "user_main.h"
#include "FreeRTOSConfig.h"
#include "main.h"
#include "usart.h"
#include "string.h"
#include <stdbool.h>
#include "FreeRTOS.h"
#include "task.h"
#include "arm_math.h"



void vTask1(void *argument);
void vTask2(void *argument);

const char *txt = "it works!\n";

__NO_RETURN void user_main(void)
{
	
//	ARM_MATH lib test code
    float32_t src1[3] = {1.0f, 3.3f, 9.4f};
    float32_t src2[3] = {1.3f, 3.2f, 9.1f};
    float32_t dst[3] = {0};

    arm_add_f32(src1, src2, dst, 3);
	
//	FreeRTOS test code
    xTaskCreate(vTask1, "vTask1", 128, NULL, 1, NULL);
    xTaskCreate(vTask2, "vTask2", 128, NULL, 1, NULL);

    vTaskStartScheduler();
    
	
    while (true){
        HAL_GPIO_TogglePin(GPIOA, GPIO_PIN_8);
        HAL_Delay(1000);
    }

}

__NO_RETURN void vTask1(void *argument)
{
	(void)argument;
    while(1){
        HAL_GPIO_TogglePin(GPIOA, GPIO_PIN_8);
        vTaskDelay(300);
    }
}

__NO_RETURN void vTask2(void *argument)
{
    (void)argument;
    while(1){
        HAL_UART_Transmit(&huart1, (uint8_t *)txt, (uint16_t)strlen(txt), 100);
        vTaskDelay(1000);
    }
}



