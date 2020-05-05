#  zmod_dac_driver_v1_0
 --- 
 **File:** ../../eclypsez7/src/zmod_dac_driver_v1_0.v  
**Module name**\: zmod_dac_driver  
**Author**\: P Trujillo (pablo@controlpaths.com\)  
**Date**\: Feb 2020  
**Description**\: Driver for ad9717. ZMOD DAC from Digilent  
**Revision**\: 1.0 Module created.  
### Parameter list  
|**Name**|**Default Value**|**Description**|  
|-|-|-|  
      
### Input list  
|**Name**|**Width**|**Description**|  
|-|-|-|  
|clk|[0:0]|Clock input. This signal is corresponding with sample frequency|  
|rst|[0:0]|Reset input|  
|is14_data_i|[13:0]|Data for ch i|  
|is14_data_q|[13:0]|Data for ch q|  
|i_run|[0:0]|DAC enable input|  
|clk_spi|[0:0]|Clock input for SPI communication. clk_spi = clk_spi/4|  
|rst_spi|[0:0]|DAC reset out|  
      
### Output list  
|**Name**|**Width**|**Description**|  
|-|-|-|  
|os14_data|[13:0]|Parallel DDR data for ADC|  
|or_sck|[0:0]|DAC SPI clk out|  
|or_cs|[0:0]|DAC SPI cs out|  
|o_sdo|[0:0]|DAC SPI data IO out|  
      
### Wire list  
|**Name**|**Width**|**Description**|  
|-|-|-|  
      
### Register list  
|**Name**|**Width**|**Description**|  
|-|-|-|  
|r_dacrun|[0:0]|configuration done. DAC run signal.|  
|r_spi_start|[0:0]|SPI start communication|  
|r16_data_out|[15:0]|SPI data out|  
|r4_spi_state|[3:0]|SPI communication state|  
|r4_data_counter|[3:0]|SPI data counter|  
      
### Instantiation example 
 ```verilog   
zmod_dac_driver_v1_0 zmod_dac_driver_v1_0_inst0(  
.clk(),  
.rst(),  
.is14_data_i(),  
.is14_data_q(),  
.i_run(),  
.os14_data(),  
.clk_spi(),  
.rst_spi(),  
.or_sck(),  
.or_cs(),  
.o_sdo()   
);   
```