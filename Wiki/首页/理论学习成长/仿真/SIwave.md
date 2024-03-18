  

  

仿真步骤

> [!info] Loading...  
>  
> [https://ansyshelp.ansys.com/account/secured?returnurl=/Views/Secured/Electronics/v221/en/home.htm%23../Subsystems/SIwave/Subsystems/Getting%20Started%20with%20SIwave%20-%20A%20PCB%20Model/Content/SetPCBElementVisibility.htm?TocPath=SIwave%257CSIwave%2520Getting%2520Started%2520Guides%257CPCB%2520Model%257CSetting%2520Up%2520the%2520Design%257C_____1](https://ansyshelp.ansys.com/account/secured?returnurl=/Views/Secured/Electronics/v221/en/home.htm%23../Subsystems/SIwave/Subsystems/Getting%20Started%20with%20SIwave%20-%20A%20PCB%20Model/Content/SetPCBElementVisibility.htm?TocPath=SIwave%257CSIwave%2520Getting%2520Started%2520Guides%257CPCB%2520Model%257CSetting%2520Up%2520the%2520Design%257C_____1)  

1. 导入pcb
2. 设置叠层
3. 选择电源地网络
4. 有效性检查

  

  

1. 电源 谐振模型分析
    
    1. The resonant mode calculation is the first step in identifying non-ideal plane behavior that can affect signal integrity.
    
      
    
    - Define Pin Groups for GND and VCC
    - Define a Port between the pin groups
    - Generate the SYZ-parameters for selected power supply nets
    - Display the frequency-dependent impedance of the planes on an X-Y plot