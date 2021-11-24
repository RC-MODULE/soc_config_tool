# Инструмент конфигурации микросхемы 1888ВС048

## Общая информация

Задача этой утилиты производить настройку микросхемы на основе конфигурационного файла в формате ini. 

Конфигурация в формате .ini дописывается в конец программы конфигурации (config_tool.tmpl в этом репозитории) и накрывается общей контрольной суммой.

Примеры конфигурации представлены в каталоге configs/


## Сборка

Для сборки необходим пакет rumboot-tools (pip install rumboot-tools)
```
make
```

Это создаст директорию output/, где будут расположены готовые бинарные файлы, по одному на каждую конфигурацию в config/

## Полный пример файла конфигурации со всеми возможными секциями

```ini
[DDR]
; Supported chips are:
; mt41k256m8
; mt41j512m8
; Ask support for others if you need
slot[0]="mt41k256m8"
slot[1]="mt41k256m8"

[PCIe]
speed            = 0x0
device_id        = 0x100
revision_id      = 0x00
subclass_code    = 0xFF
class_code       = 0xFF
state_auto_ack   = 0x1

# Valid bar numbers: 0-5
BAR[0].axi_start = 0x00000000
BAR[0].aperture  = 0x13
BAR[0].type      = 0x4

# Must always be the last section
[EXIT]
# loop == endless loop
# wfiloop == endless with WFI instruction (some powersave)
# host == jump to host mode
# next == boot from next image/device
# jump:N == Jump to the boot device N, where N=1,2,...
mode = wfiloop

```