# 平台说明

​		本实验例程基于 EC600S_QuecPython_EVB_V1.1 开发板完成。



## 开发板lcd接口说明

​		本实验所使用的ST7789V lcd引脚定义与开发板的LCD接口是完全匹配的，可以直接插到开发板的LCD接口使用。开发板LCD接口如下：

![Quectel_Qp_little_demo_lcd_01](media\Quectel_Qp_little_demo_lcd_01.png)

| 开发板lcd引脚 | 引脚定义                       |
| ------------- | ------------------------------ |
| GND           | 电源地                         |
| VCC_3V3       | 电源3.3V                       |
| LCD_SCL_3V3   | SPI总线时钟信号                |
| LCD_SDA_3V3   | SPI总线写数据信号              |
| LCD_RST_3V3   | 液晶屏复位控制信号，低电平复位 |
| LCD_DC_3V3    | 写寄存器/写数据控制信号        |
| LCD_BLK       | 液晶屏背光控制信号             |



## ST7789V lcd 接口说明

<img src="media\st7789v.png" alt="st7789v" style="zoom:75%;" />



| lcd引脚 | 引脚定义                       |
| ------- | ------------------------------ |
| GND     | 电源地                         |
| VCC     | 电源3.3V                       |
| SCL     | SPI总线时钟信号                |
| SDA     | SPI总线写数据信号              |
| RES     | 液晶屏复位控制信号，低电平复位 |
| DC      | 写寄存器/写数据控制信号        |
| BLK     | 液晶屏背光控制信号             |

# 接线方式

​		以下为1.14inch ST7789V液晶屏模块与 EC600S_QuecPython_EVB_V1.1 模块的接线对应关系。EC600S_QuecPython_EVB_V1.1 模块 LCD 接口定义请参考该开发板的模块原理图。

| 1.14inch ST7789V LCD模块引脚 | EC600S_QuecPython_EVB_V1.1 引脚 |
| ---------------------------- | ------------------------------- |
| GND                          | GND                             |
| VCC                          | VCC_3V3                         |
| SCL                          | LCD_SCL_3V3                     |
| SDA                          | LCD_SDA_3V3                     |
| RES                          | LCD_RST_3V3                     |
| DC                           | LCD_DC_3V3                      |
| BLK                          | LCD_BLK                         |



# 软件说明

​		本示例中的接口是基于QuecPython 的machine.LCD库实现，具体可阅读示例程序的源码。

## 文件说明

| 文件                     | 描述                                                         |
| ------------------------ | ------------------------------------------------------------ |
| st7789v.py               | 包含驱动IC为ST7789V的液晶屏驱动程序以及显示字符与图片等接口。 |
| fonts.py                 | 示例程序中用到的字库。                                       |
| image.py                 | 示例程序中用到的图片数据。                                   |
| example_display_image.py | 显示图片主程序，调用其它几个文件中的方法与数据。             |
| example_display_char.py  | 显示字符主程序，调用其它几个文件中的方法与数据。             |



## ST7789V LCD 驱动方法使用说明

### 创建st7789v对象

> **from usr import st7789v**
>
> **lcd_st7789v = st7789v.ST7789V(width, hight)** 

* 功能：

  创建一个lcd对象，进行lcd初始化。

* 参数：

| 参数  | 类型 | 说明       |
| ----- | ---- | ---------- |
| width | 整型 | 显示屏的宽 |
| hight | 整型 | 显示屏的高 |

* 返回值：

  返回一个lcd对象。

* 示例：

```python
from usr import st7789v
lcd_st7789v = st7789v.ST7789V(240, 240)
```



### 显示单个字符

> **lcd_st7789v.lcd_show_char(x, y, xsize, ysize, ch_buf, fc, bc)**

* 功能：

  单个字符显示，可显示汉字和ASCII字符。

* 参数：

| 参数   | 类型         | 说明                          |
| ------ | ------------ | ----------------------------- |
| x      | 整型         | x轴起点坐标                   |
| y      | 整型         | y轴起点坐标                   |
| xsize  | 整型         | 待显示字符的宽                |
| ysize  | 整型         | 待显示字符的高                |
| ch_buf | 元组或列表   | 存放待显示字符的字模数据      |
| fc     | 16位十六进制 | 字体颜色，如 0x0000 表示黑色  |
| bc     | 16位十六进制 | 背景颜色，如 0xFFFF  表示白色 |

* 返回值：

  无



### 单个ASCII字符显示

> **lcd_st7789v.lcd_show_ascii(x, y, xsize, ysize, ch, fc, bc)**

* 功能：

  ASCII字符显示，目前支持8x16、16x24的字体大小，如果需要其他字体大小需要自己增加对应大小的字库数据，并在该函数中增加这个对应字库的字典。

* 参数：

| 参数  | 类型         | 说明                          |
| ----- | ------------ | ----------------------------- |
| x     | 整型         | x轴起点坐标                   |
| y     | 整型         | y轴起点坐标                   |
| xsize | 整型         | 待显示字符的宽                |
| ysize | 整型         | 待显示字符的高                |
| ch    | 字符         | 待显示的ASCII字符             |
| fc    | 16位十六进制 | 字体颜色，如 0x0000 表示黑色  |
| bc    | 16位十六进制 | 背景颜色，如 0xFFFF  表示白色 |

* 返回值：

  无



### ASCII字符串显示

> **lcd_st7789v.lcd_show_ascii_str(x, y, xsize, ysize, str, fc, bc)**

* 功能：

  ASCII字符串显示，显示顺序，以设置的起始坐标开始自左向右显示。示例中只提供了8x16大小的ascii字符，如果用户需要其他大小的字符，需要自己重新制作字库，并在` lcd_st7789v.lcd_show_ascii(x, y, xsize, ysize, ch, fc, bc)` 接口中增加对新增字库的支持。

  注意，要确定传入的字符串能够在当前行显示完，即传入字符串总长度乘以单个字符宽度的值 ，加上起始坐标x的值不能超过屏宽，否则程序会直接报错，提示超过显示范围。

参数：

| 参数  | 类型         | 说明                          |
| ----- | ------------ | ----------------------------- |
| x     | 整型         | x轴起点坐标                   |
| y     | 整型         | y轴起点坐标                   |
| xsize | 整型         | 待显示字符的宽                |
| ysize | 整型         | 待显示字符的高                |
| str   | 字符串       | 待显示的ASCII字符             |
| fc    | 16位十六进制 | 字体颜色，如 0x0000 表示黑色  |
| bc    | 16位十六进制 | 背景颜色，如 0xFFFF  表示白色 |

* 返回值：

  无。



### 单个汉字显示

> **lcd_st7789v.lcd_show_chinese(x, y, xsize, ysize, ch, fc, bc)**

* 功能：

  汉字显示，目前支持示例中几个汉字的16x16、16x24、24x24的字体大小，如果需要显示其他汉字以及其他字体大小需要自己增加对应大小的字库数据，并在该函数中增加这个对应字库的字典。

* 参数：

| 参数  | 类型         | 说明                          |
| ----- | ------------ | ----------------------------- |
| x     | 整型         | x轴起点坐标                   |
| y     | 整型         | y轴起点坐标                   |
| xsize | 整型         | 待显示字符的宽                |
| ysize | 整型         | 待显示字符的高                |
| ch    | 字符         | 待显示的汉字                  |
| fc    | 16位十六进制 | 字体颜色，如 0x0000 表示黑色  |
| bc    | 16位十六进制 | 背景颜色，如 0xFFFF  表示白色 |

* 返回值：

  无



### 汉字字符串显示

> **lcd_st7789v.lcd_show_chinese_str(x, y, xsize, ysize, str, fc, bc)**

* 功能：

  汉字字符串显示，显示顺序，以设置的起始坐标开始自左向右显示。示例中只提供了用到的几个汉字的16x16大小的字库，如果用户需要其他大小的字符，需要自己重新制作字库，并在 `lcd_st7789v.lcd_show_chinese(x, y, xsize, ysize, str, fc, bc)` 接口中增加对新增字库的支持。

  注意，要确定传入的字符串能够在当前行显示完，即传入汉字个数乘以单个汉字宽度的值 ，加上起始坐标x的值不能超过屏宽，否则程序会直接报错，提示超过显示范围。

* 参数：

| 参数  | 类型         | 说明                                |
| ----- | ------------ | ----------------------------------- |
| x     | 整型         | x轴起点坐标                         |
| y     | 整型         | y轴起点坐标                         |
| xsize | 整型         | 待显示字符的宽                      |
| ysize | 整型         | 待显示字符的高                      |
| str   | 字符串       | 待显示的汉字字符串，比如 '移远通信' |
| fc    | 16位十六进制 | 字体颜色，如 0x0000 表示黑色        |
| bc    | 16位十六进制 | 背景颜色，如 0xFFFF  表示白色       |

* 返回值：

  无。



### 显示小尺寸图片

> **lcd_st7789v.lcd_show_image(image_data, x, y, width, heigth)**

* 功能：

  显示图片，该方法适合显示尺寸较小的图片，如果图片分辨率（宽高）小于80x80，可直接用该方法一次性将图片数据写入显示。

* 参数：

| 参数       | 类型       | 说明                    |
| ---------- | ---------- | ----------------------- |
| image_data | 元组或列表 | 存放待显示图片的RGB数据 |
| x          | 整型       | x轴起点坐标             |
| y          | 整型       | y轴起点坐标             |
| width      | 整型       | 待显示图片的宽度        |
| heigth     | 字符       | 待显示图片的高度        |

* 返回值：

  无



### 显示大尺寸图片

> **lcd_st7789v.lcd_show_image_file(path, x, y, width, heigth, h)**

* 功能：

  显示图片，该方法适合显示尺寸较大的图片，如果图片分辨率（宽高）大于80x80，需要使用该方法来显示。该方法从文件中读取图片数据分段写入。分段写入原理如下：

  假如要显示图片的分辨率（宽高）为 width*heigth，将待显示的图片分成若干宽高为 width * h 大小的图片，最后一块高度不足h的按实际高度计算，h为分割后每个图片的高度，可由用户通过参数 h 指定，h的取值应该满足关系： `width * h * 2 < 4096`

参数：

| 参数   | 类型   | 说明                                                       |
| ------ | ------ | ---------------------------------------------------------- |
| path   | string | 存放图片数据的txt文件路径，包含文件名，如 '/usr/image.txt' |
| x      | int    | x轴显示起点                                                |
| y      | int    | y轴显示起点                                                |
| width  | int    | 图片宽度                                                   |
| heigth | int    | 图片高度                                                   |
| h      | int    | 分割后每个图片的高度                                       |

* 返回值：

  无

示例：

假如要显示一张240x240的图片，图片如下：

![Quectel_Qp_little_demo_lcd_02](media\Quectel_Qp_little_demo_lcd_02.jpg)

（1）使用Image2Lcd 软件获取图片色彩数据

![Quectel_Qp_little_demo_lcd_03](media\Quectel_Qp_little_demo_lcd_03.png)

（2）得到数据如下图1、2，将该 .c 文件中头部和尾部多余部分都删除，只保留中间的数据部分，确保处理后的数据第一行就是数据，且最后没有多余行，每一行前面没有空格等多余字符

![Quectel_Qp_little_demo_lcd_04](media\Quectel_Qp_little_demo_lcd_04.png)

![Quectel_Qp_little_demo_lcd_05](media\Quectel_Qp_little_demo_lcd_05.png)

（3）将处理后的图片数据文件保存为txt格式文件，假设命名为image.txt

（4）将image.txt文件上传到开发板模块中【注意，此时没有image.py文件，不需要 from usr import image】

（5）在主程序  example_display_image.py 中，使用如下代码来显示该图片

```python
# -*- coding: UTF-8 -*-


import utime
'''
如果用户使用的固件版本中没有checkNet库，请将checkNet.mpy文件上传到模块的usr目录，
并将 import checkNet 改为 from usr import checkNet
'''
import checkNet
from usr import st7789v
# from usr import image

'''
下面两个全局变量是必须有的，用户可以根据自己的实际项目修改下面两个全局变量的值，
在执行用户代码前，会先打印这两个变量的值。
'''
PROJECT_NAME = "QuecPython_ST7789V_LCD_Example"
PROJECT_VERSION = "1.0.0"

checknet = checkNet.CheckNetwork(PROJECT_NAME, PROJECT_VERSION)
lcd_st7789v = st7789v.ST7789V(240, 240)


if __name__ == '__main__':
    '''
    手动运行本例程时，可以去掉该延时，如果将例程文件名改为main.py，希望开机自动运行时，需要加上该延时,
    否则无法从CDC口看到下面的 poweron_print_once() 中打印的信息
    '''
    # utime.sleep(5)
    checknet.poweron_print_once()

    '''
    如果用户程序包含网络相关代码，必须执行 wait_network_connected() 等待网络就绪（拨号成功）；
    如果是网络无关代码，可以屏蔽 wait_network_connected()
    '''
    # checknet.wait_network_connected()

    # 用户代码
    '''######################【User code star】#####################################'''
  
    # 显示一张240*240大小的图片
    lcd_st7789v.lcd_show_image_file("/usr/image.txt", 0, 0, 240, 240, 8)

    '''######################【User code end 】#####################################'''

```

显示结果：


![Quectel_Qp_little_demo_lcd_06](media\Quectel_Qp_little_demo_lcd_06.jpg)



# 实验操作



## 显示图片

​		在实验例程的目录下，找到【显示图片】目录，进入该目录下，有如下几个源码文件：

| 文件                     | 说明                                                         |
| ------------------------ | ------------------------------------------------------------ |
| st7789v.py               | 包含 ST7789V lcd 驱动初始化、写ASCII字符、写汉字以及显示图片的方法接口。 |
| image.py                 | 示例图片的RGB数据                                            |
| example_display_image.py | 主程序，调用st7789v.py和image.py中接口及信息来实现图片显示   |
| fonts.py                 | 字库，提供常见ASCII字符的两种大小的字库，分别是8x16和16x24，同时包含了实验中用到汉字的几种不同大小的字库。用户可根据自己的需要制作字库，使用PCtoLCD2002软件，参照fonts.py中说明来制作。 |



### 实验步骤

（1）将240*240的显示屏正确接到模块上；
（2）将本目录的4个py文件（st7789v.py、image.py、fonts.py、example_display_image.py）拷贝到模块的usr目录下；
（3）进入模块的命令行，执行如下指令即可看到显示屏显示图片：

```
import example
example.exec('usr/example_display_image.py')
```



### 实验结果

![Quectel_Qp_little_demo_lcd_07](media\Quectel_Qp_little_demo_lcd_07.png)





## 显示字符

​		在实验例程的目录下，找到【显示字符】目录，进入该目录下，有如下几个源码文件：

| 文件                    | 说明                                                         |
| ----------------------- | ------------------------------------------------------------ |
| st7789v.py              | 包含 ST7789V lcd 驱动初始化、写ASCII字符、写汉字以及显示图片的方法接口。 |
| fonts.py                | 字库，提供常见ASCII字符的两种大小的字库，分别是8x16和16x24，同时包含了实验中用到汉字的几种不同大小的字库。用户可根据自己的需要制作字库，使用PCtoLCD2002软件，参照fonts.py中说明来制作。 |
| example_display_char.py | 主程序，调用st7789v.py和fonts.py中接口及信息来实现ASCII字符的显示与汉字的显示。 |

### 实验步骤

（1）将240*240的显示屏正确接到模块上；
（2）将本目录的3个py文件（st7789v.py、fonts.py、example_display_char.py）拷贝到模块的usr目录下；
（3）进入模块的命令行，执行如下指令即可看到显示屏显示图片：

```
import example
example.exec('usr/example_display_char.py')
```



### 实验结果

![Quectel_Qp_little_demo_lcd_08](media\Quectel_Qp_little_demo_lcd_08.jpg)



# 字符和图片取模工具使用

## 工具简介

（1）Image2Lcd

Image2Lcd 软件用于图片取模，可以提取单色和彩色图片。

（2）PCtoLCD2002

PCtoLCD2002 是一款字符取模软件，可以生成汉字、英文以及标点符号的字模数据。



## 如何对图片取模

（1）打开 Image2Lcd 软件，点击【打开】按钮，选择要显示的图片；

![Quectel_Qp_little_demo_lcd_09](media\Quectel_Qp_little_demo_lcd_09.png)

（2）输出数据类型选择【C语言数组(*.c)】,扫描方式选择【水平扫描】，输出灰度一定要选择【16位真彩色】；

（3）设置图片的最大宽度和高度，实际输出大小以上图中最下方的【输出图像:（xx, yy）】部分显示为准；

（4）点击【保存】按钮，得到图片的取模数据，将其放到元组中保存即可。



## 如何对字符取模

（1）打开 PCtoLCD2002 软件，依次点击【模式】-【字符模式(W)】；

（2）根据需要选择字体，设置字体大小等；

![字符取模1](media\Quectel_Qp_little_demo_lcd_10.png)

（3）点击齿轮图标，进入如下所示界面，选择 【阴码】、【逐行式】、【顺向】、【C51格式】，点击确定；

![字符取模2](media\Quectel_Qp_little_demo_lcd_11.png)

（4）输入要取模的字符后，点击【生成字模】，即可得到对应的字模数据，按照示例 fonts.py 文件中的格式，将字模数据保存到字典中。

# 配套代码

 <a href="code/LCD_file.zip" target="_blank">下载实验材料</a>