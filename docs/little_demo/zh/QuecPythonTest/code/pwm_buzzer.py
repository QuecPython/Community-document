from misc import PWM
import utime as time
import urandom as random
import log

# API https://python.quectel.com/wiki/#/zh-cn/api/QuecPythonClasslib?id=pwm
# 蜂鸣器模块 https://detail.tmall.com/item.htm?id=41251333522
# 无源蜂鸣器-频率可控版

"""

pwm0 = PWM(PWM.PWMn,PWM.ABOVE_xx,highTime,cycleTime)

注：EC600SCN平台，支持PWM0-PWM3，对应引脚如下：

PWM0 – 引脚号52

PWM1 – 引脚号53

PWM2 – 引脚号70

PWM3 – 引脚号69

"""

# 获取logger对象

buzzer_log = log.getLogger("buzzer_test")

# Duration 为 ms

def outputpwm(HZ, duty_cycle, Duration):

    # 将HZ 转化为 10us 级别

    cycleTime = int((10000000/HZ)/10)
    highTime = int(cycleTime * duty_cycle)

    # 输出debug级别的日志
        
    buzzer_log.debug(
	    """out put pin70 cycleTime {0} * 10us,
	    highTime {1} * 10us, Duration of {2}"""
	    .format(cycleTime, highTime, Duration))
    pwm1 = PWM(PWM.PWM2, PWM.ABOVE_10US, highTime, cycleTime)       
    pwm1.open()

    # 休眠给定毫秒数的时间
        
    time.sleep_ms(Duration)
    pwm1.close()
    pass


def test_Buzzer():

	#设置日志输出级别

	log.basicConfig(level=log.DEBUG)

	# 循环遍历10次

	for i in range(10):

		# 随机生成 start 到 end 范围内的浮点数，范围可以自己选择， 0~1

		duty_cycle = random.uniform(0.1, 0.8)

		# 建议输出2000~5000HZ 的PWM波形
		# 随机生成一个 start 到 end 之间的整数

		HZ = random.randint(2000, 5000)
		outputpwm(HZ, duty_cycle, 500)
		time.sleep_ms(1500)
        
	pass


if __name__ == "__main__":

	# creat a thread Check key status

	test_Buzzer()