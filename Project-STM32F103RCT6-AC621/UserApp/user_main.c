#include "user_main.h"
#include "main.h"
#include <stdbool.h>

void user_main(void)
{
    // ...
    while(true) {
        HAL_GPIO_TogglePin(GPIOA, GPIO_PIN_8);
        HAL_Delay(300);
    }
}


