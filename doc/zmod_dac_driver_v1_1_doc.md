![image](logo.png)
#  zmod_dac_driver_v1_1 
 **File:** ../../eclypsez7/src/zmod_dac_driver_v1_1.v  
**Module name**\: zmod_dac_driver  
**Author**\: P Trujillo (pablo@controlpaths.com\)  
**Date**\: May 2020  
**Description**\: Driver for ad9717. ZMOD DAC from Digilent  
**Revision**\: 1.1 All in one driver. Include Relay and gpio configuration.  

### Input list  
|**Name**|**Width**|**Description**|  
|-|-|-|  
|clk|[0:0]|Clock input. This signal is corresponding with sample frequency|  
|rstn|[0:0]|Reset input|  
|is14_data_i|[13:0]|Data for ch i|  
|is14_data_q|[13:0]|Data for ch q|  
|i_run|[0:0]|DAC enable input|  

### Output list  
|**Name**|**Width**|**Description**|  
|-|-|-|  
|os14_data|[13:0]|Parallel DDR data for ADC|  
|rst_spi|[0:0]|DAC reset out|  
|or_sck|[0:0]|DAC SPI clk out|  
|or_cs|[0:0]|DAC SPI cs out|  
|o_sdo|[0:0]|DAC SPI data IO out|  
|o_relay|[0:0]|Output relay|  
|o_dac_fsadji|[0:0]|Full scale selection|  
|o_dac_fsadjq|[0:0]|Full scale selection|  

### Instantiation example 
 ```verilog   
zmod_dac_driver_v1_1 zmod_dac_driver_v1_1_inst0(  
.clk(),  
.rstn(),  
.is14_data_i(),  
.is14_data_q(),  
.i_run(),  
.os14_data(),  
.rst_spi(),  
.or_sck(),  
.or_cs(),  
.o_sdo(),  
.o_relay(),  
.o_dac_fsadji(),  
.o_dac_fsadjq()   
);   
```

Automatic documentation generator. (https://github.com/controlpaths/verilog_parser)