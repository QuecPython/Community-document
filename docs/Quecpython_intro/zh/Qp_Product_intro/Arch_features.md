## 探秘QuecPython技术架构

### 系统架构介绍

![](media/Quectel_Qp_Intro_sys_Arch.png)

从系统架构图中可以直观地看到从平台底层到用户接口层的架构分层，分别是Hardware平台硬件层、平台OS层、QuecPython Adapter Layer平台适配层、QuecPython VM虚拟机层、QuecPython编译器层，QuecPythonModules用户接口层。

其中：

-   **C-SDK**：Hardware平台硬件层、平台OS层；

-   **QuecPython完整结构层**：QuecPython Adapter Layer平台适配层、QuecPython VM虚拟机层，QuecPython编译器层和QuecPython Modules用户接口层。

用户仅需关注QuecPython Modules用户接口层，该层提供了大量的API接口，包括I2C/SPI/GPIO/AUDIO/PWM/POWER/ADC/FOTA/Datacall/Aliyun等模块。

### 目录结构

![](media/Quectel_Qp_Intro_dir_tpc.png.png)

目录说明：

-   **Micropython----\>docs----\>quectel**：该目录下主要包含移远关于QuecPython的入门教程文档，比如驱动安装、开发板介绍等。

-   **Micropython----\>examples----\>quectel**：该目录下主要包含QuecPython的demo例程。

-   **Micropython----\>ports----\>quectel----\>boards**：该目录下主要包含QuecPython移植到不同平台的适配层接口。

-   **Micropython----\>ports----\>quectel----\>core**：该目录下主要包含QuecPython Modules用户接口层逻辑处理。

-   **Micropython----\>tools----\>quectel**：该目录下主要包含QuecPython相关使用工具。

#### 附录

表1：术语缩写

| **术语** | **英文全称**                      | **中文全称**     |
| -------- | --------------------------------- | ---------------- |
| SDK      | Software Development Kit          | 软件开发工具包   |
| VM       | Virtual Machine                   | 虚拟机           |
| OS       | Operating System                  | 操作系统         |
| DTU      | Data Transfer Uni                 | 数据传输单元     |
| API      | Application Programming Interface | 应用程序编程接口 |
| APP      | Application                       | 应用程序         |

***持续更新中，更多精彩敬请关注！***



> ​	***For full documentation visit [http://python.quectel.com/.](http://python.quectel.com/.)***

