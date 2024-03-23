
## 和I2C差异
1. SMbus限制电平范围：1.8-5.0
2. i2c Vih,Vil: 0.3/0.7Vcc, SMbus 0.8/1.35V
3. SMbus 400K 最低电平400mV
4. I2C没有规定最小时钟频率 ，SMbus最小频率10K，对时钟延展持续的bit数据(始终延展会cover多少个数据周期)和时间也有要求 *（tLOW:CEXT)   (tLOW:TEXT)  tTimeout*
5. SMbus要求从设备必须ACK
6. 

