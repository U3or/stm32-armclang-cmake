#include "user_main.h"
#include "main.h"
#include "arm_math.h"

void user_main()
{

    const float32_t src[3] = {-3.0f, 1.0f, 2.0f};
    float32_t dst[3] = {0.0f, 0.0f, 0.0f};
    arm_abs_f32(src, dst , 3);

	while (1){
		HAL_Delay(100);
		HAL_GPIO_TogglePin(GPIOA,GPIO_PIN_8);
	}
}


