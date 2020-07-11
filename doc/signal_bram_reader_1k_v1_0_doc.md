![image](logo.png)
#  signal_bram_reader_1k_v1_0 
 **File:** ../../eclypsez7/src/signal_bram_reader_v1_0.v  
**Module name**\: signal_bram_reader_1k_v1_0  
**Author**\: P Trujillo (pablo@controlpaths.com\)  
**Date**\: May 2020  
**Description**\: Module for read a signal stored in 1k bram.  
**Revision**\: 1.0 Module created  

### Input list  
|**Name**|**Width**|**Description**|  
|-|-|-|  
|clk|[0:0]|Input clock signal|  
|rstn|[0:0]|Input reset signal|  
|ce|[0:0]|Clock enable signal.|  

### Output list  
|**Name**|**Width**|**Description**|  
|-|-|-|  
|o14_signal|[13:0]|14 bit output signal.|  

### Register list  
|**Name**|**Width**|**Description**|  
|-|-|-|  
|m14x1024_signal_memory|[13:0][1023:0]|Memory for store signal. ROM infered|  
|r10_mem_index|[9:0]|Read index for bram|  

### Instantiation example 
 ```verilog   
signal_bram_reader_1k_v1_0 signal_bram_reader_1k_v1_0_inst0(  
.clk(),  
.rstn(),  
.ce(),  
.o14_signal()   
);   
```

Automatic documentation generator. (https://github.com/controlpaths/verilog_parser)