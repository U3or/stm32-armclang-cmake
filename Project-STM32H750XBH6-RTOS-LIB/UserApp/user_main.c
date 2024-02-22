#include "user_main.h"
#include "main.h"
// cmsis dsp
#include "arm_math.h"
// freertos
#include "FreeRTOS.h"
#include "task.h"

/*
	__weak void SVC_Handler(void);
	__weak void PendSV_Handler(void);
	__weak void SysTick_Handler(void);
*/


void vTask1(void *argument);

const char *txt = "it works!\n";

void user_main()
{
	
	
//	ARM_MATH lib test code
    const float32_t src[3] = {-3.0f, 1.0f, 2.0f};
    float32_t dst[3] = {0.0f, 0.0f, 0.0f};
    arm_abs_f32(src, dst , 3);
	
//	FreeRTOS test code
    xTaskCreate(vTask1, "vTask1", 128, NULL, 1, NULL);
	
	vTaskStartScheduler();
	
	while (1){
		HAL_Delay(100);
		HAL_GPIO_TogglePin(GPIOA,GPIO_PIN_8);
	}
}


void vTask1(void *argument)
{

    while(1){
        HAL_GPIO_TogglePin(GPIOA, GPIO_PIN_8);
        HAL_Delay(200);
    }
}

