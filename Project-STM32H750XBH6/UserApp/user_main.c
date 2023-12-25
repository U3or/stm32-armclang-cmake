#include "user_main.h"
#include "main.h"

void user_main()
{
    while (1){
        HAL_Delay(100);
        HAL_GPIO_TogglePin(GPIOA,GPIO_PIN_8);
    }
}


