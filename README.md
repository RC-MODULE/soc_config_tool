# Инструмент конфигурации микросхемы 1888ВС048

## Общая информация

Задача этой утилиты производить настройку микросхемы на основе конфигурационного файла в формате ini. 

Конфигурация в формате .ini дописывается в конец программы конфигурации (config_tool.tmpl в этом репозитории) и накрывается общей контрольной суммой.

Примеры конфигурации представлены в каталоге configs/

_ВАЖНО_: Текущий вариант настройки DDR не учитывает некоторые возможные режимы контроллера. 
Так, например, нет возможности включать и выключать режим ECC из конфигурационного файла. 
Это будет доработано в следующих версиях. Свои пожелания фиксируйте в виде issues к этому репозиторию.

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


# Проверенные DIMM модули памяти

Проверка осуществлялась на MT143.05 с теми моделями памяти, которые были в наличие. 
Проверялась минимальная работоспособность (загрузка u-boot из DDR). 

_ВАЖНО_: Будем рады pull request'ам с результатами тестирования DIMM модулей памяти, отсутствующих в этой таблице.

| DIMM Модуль                  | Чипы памяти 	        | Значение в ini 	   | Работоспособность 	       | Примечание 	                  |
|-------------                 |-------------	       |----------------	|-------------------	|------------                     |
| Crucial CT25664BF160B.C8FKD  | CT41K256M8DA-125:K    |  mt41k256m8     	| работает                | рекомендуется для mt41k256m8 в ini |
| Neo Forza NMSO320C81         | Goldkey GL2081600H0   |  mt41k256m8        | работает                |            	                    |
| SK Hynix HMT351S6EFR8A       | Hynix H5TC2G83EFR     |  mt41k256m8        | работает                |            	                    |
| SK Hynix HMT312S6DFR6C       | Hynix H5TQ2G63DFA     |  mt41k256m8        | работает                |            	                    |
| SK Hynix HMT312S6DFR6C       | Hynix H5TQ2G63DFA     |  mt41k256m8        | работает                |            	                    |
| Transcend TS256MSK64W6N      | K4B2G08               |  mt41k256m8        | работает                |            	                    |
| AMD R532G1601S1SL-UO         | AMD 3EY4787MB6K       |                    | не работает              |            	                 |
| Kingston KVR13KS9S6/2        | Kingston NO1457-05    |                	| не работает              |                                 |
