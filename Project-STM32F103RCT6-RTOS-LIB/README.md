# STM32F103RCT6 - FreeRTOS

## STM32F103RCT6存储空间

```markdown
CPU：STM32F103RCT6，LQFP64，FLASH:256KB，SRAM：48KB；
```

| 区域  | 起始地址    | 大小(HEX)   | 大小(Bytes/字节) | 大小(KBytes) |
| ----- | ----------- | ----------- | ---------------- | ------------ |
| Flash | 0x0800_0000 | 0x0004_0000 | 262144           | 256          |
| RAM   | 0x2000_0000 | 0x0000_C000 | 49125            | 48           |

…

## Memory usage 内存使用情况统计

```markdown
总分配数: 4096 (单位: Bytes/字节)

	用户任务使用: 1792
		task1 
			stack	1056 (stack depth: 256)
			tcb		104
		task2
			stack	528  (stack depth: 128)
			tcb		104

	系统调度使用: 2032
		IdleTask
			stack	528
			tcb 	104
		prvCheckForValidListAndQueue
					256
		prvTimerTask
			stack	1040
			tcb		104

	剩余: 272
```

…