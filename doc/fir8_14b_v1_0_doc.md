![image](logo.png)
#  fir8_14b_v1_0 
 **File:** ../../eclypsez7/src/fir8_14b_v1_0.v  
**Module name**\: fir8_14b  
**Author**\: P Trujillo (pablo@controlpaths.com\)  
**Date**\: May 2020  
**Description**\: 8th order FIR filter. 14 bits width  
**Revision**\: 1.0 Module created  

### Input list  
|**Name**|**Width**|**Description**|  
|-|-|-|  
|clk|[0:0]||  
|rstn|[0:0]||  
|ce|[0:0]||  
|is32_coeff_0|[31:0]|FIR filter coefficient|  
|is32_coeff_1|[31:0]|FIR filter coefficient|  
|is32_coeff_2|[31:0]|FIR filter coefficient|  
|is32_coeff_3|[31:0]|FIR filter coefficient|  
|is32_coeff_4|[31:0]|FIR filter coefficient|  
|is32_coeff_5|[31:0]|FIR filter coefficient|  
|is32_coeff_6|[31:0]|FIR filter coefficient|  
|is32_coeff_7|[31:0]|FIR filter coefficient|  
|is32_coeff_8|[31:0]|FIR filter coefficient|  
|is14_in|[13:0]|Filter input|  

### Output list  
|**Name**|**Width**|**Description**|  
|-|-|-|  
|os14_out|[13:0]|Filter output|  

### Wire list  
|**Name**|**Width**|**Description**|  
|-|-|-|  
|ws64_pipe_coeff|[(32*2)-1:0][8:0]|Multipliers results|  

### Register list  
|**Name**|**Width**|**Description**|  
|-|-|-|  
|rs32_pipe|[31:0][8:0]|Pipeline registers|  

### Instantiation example 
 ```verilog   
fir8_14b_v1_0 fir8_14b_v1_0_inst0(  
.clk(),  
.rstn(),  
.ce(),  
.is32_coeff_0(),  
.is32_coeff_1(),  
.is32_coeff_2(),  
.is32_coeff_3(),  
.is32_coeff_4(),  
.is32_coeff_5(),  
.is32_coeff_6(),  
.is32_coeff_7(),  
.is32_coeff_8(),  
.is14_in(),  
.os14_out()   
);   
```

Automatic documentation generator. (https://github.com/controlpaths/verilog_parser)