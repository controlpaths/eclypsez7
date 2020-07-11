![image](logo.png)
#  fir32_14b_v1_0 
 **File:** ../../eclypsez7/src/fir32_14b_v1_0.v  
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
|is32_coeff_9|[31:0]|FIR filter coefficient|  
|is32_coeff_10|[31:0]|FIR filter coefficient|  
|is32_coeff_11|[31:0]|FIR filter coefficient|  
|is32_coeff_12|[31:0]|FIR filter coefficient|  
|is32_coeff_13|[31:0]|FIR filter coefficient|  
|is32_coeff_14|[31:0]|FIR filter coefficient|  
|is32_coeff_15|[31:0]|FIR filter coefficient|  
|is32_coeff_16|[31:0]|FIR filter coefficient|  
|is32_coeff_17|[31:0]|FIR filter coefficient|  
|is32_coeff_18|[31:0]|FIR filter coefficient|  
|is32_coeff_19|[31:0]|FIR filter coefficient|  
|is32_coeff_20|[31:0]|FIR filter coefficient|  
|is32_coeff_21|[31:0]|FIR filter coefficient|  
|is32_coeff_22|[31:0]|FIR filter coefficient|  
|is32_coeff_23|[31:0]|FIR filter coefficient|  
|is32_coeff_24|[31:0]|FIR filter coefficient|  
|is32_coeff_25|[31:0]|FIR filter coefficient|  
|is32_coeff_26|[31:0]|FIR filter coefficient|  
|is32_coeff_27|[31:0]|FIR filter coefficient|  
|is32_coeff_28|[31:0]|FIR filter coefficient|  
|is32_coeff_29|[31:0]|FIR filter coefficient|  
|is32_coeff_30|[31:0]|FIR filter coefficient|  
|is32_coeff_31|[31:0]|FIR filter coefficient|  
|is32_coeff_32|[31:0]|FIR filter coefficient|  
|is14_in|[13:0]|Filter input|  

### Output list  
|**Name**|**Width**|**Description**|  
|-|-|-|  
|os14_out|[13:0]|Filter output|  

### Wire list  
|**Name**|**Width**|**Description**|  
|-|-|-|  
|ws64_pipe_coeff|[(32*2)-1:0][32:0]|Multipliers results|  

### Register list  
|**Name**|**Width**|**Description**|  
|-|-|-|  
|rs32_pipe|[31:0][32:0]|Pipeline registers|  

### Instantiation example 
 ```verilog   
fir32_14b_v1_0 fir32_14b_v1_0_inst0(  
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
.is32_coeff_9(),  
.is32_coeff_10(),  
.is32_coeff_11(),  
.is32_coeff_12(),  
.is32_coeff_13(),  
.is32_coeff_14(),  
.is32_coeff_15(),  
.is32_coeff_16(),  
.is32_coeff_17(),  
.is32_coeff_18(),  
.is32_coeff_19(),  
.is32_coeff_20(),  
.is32_coeff_21(),  
.is32_coeff_22(),  
.is32_coeff_23(),  
.is32_coeff_24(),  
.is32_coeff_25(),  
.is32_coeff_26(),  
.is32_coeff_27(),  
.is32_coeff_28(),  
.is32_coeff_29(),  
.is32_coeff_30(),  
.is32_coeff_31(),  
.is32_coeff_32(),  
.is14_in(),  
.os14_out()   
);   
```

Automatic documentation generator. (https://github.com/controlpaths/verilog_parser)