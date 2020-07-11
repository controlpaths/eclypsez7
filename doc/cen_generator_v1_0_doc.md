![image](logo.png)
#  cen_generator_v1_0 
 **File:** ../../eclypsez7/src/cen_generator_v1_0.v  
**Module name**\: cen_generator_v1_0  
**Author**\: P Trujillo (pablo@controlpaths.com\)  
**Date**\: Mar20  
**Description**\: Clock enable generation according prescaler input.  
**Revision**\: 1.0: Module created.  

### Input list  
|**Name**|**Width**|**Description**|  
|-|-|-|  
|clk|[0:0]||  
|rstn|[0:0]||  
|i32_prescaler|[31:0]||  

### Output list  
|**Name**|**Width**|**Description**|  
|-|-|-|  
|or_cen|[0:0]||  

### Register list  
|**Name**|**Width**|**Description**|  
|-|-|-|  
|r32_prescaler_counter|[31:0]||  

### Instantiation example 
 ```verilog   
cen_generator_v1_0 cen_generator_v1_0_inst0(  
.clk(),  
.rstn(),  
.i32_prescaler(),  
.or_cen()   
);   
```

Automatic documentation generator. (https://github.com/controlpaths/verilog_parser)