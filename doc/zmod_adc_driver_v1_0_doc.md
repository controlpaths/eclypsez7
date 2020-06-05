![image](logo.png)
#  zmod_adc_driver_v1_0 
 **File:** ../../eclypsez7/src/zmod_adc_driver_v1_0.v  
**Module name**\: zmod_adc_driver  
**Author**\: P Trujillo (pablo@controlpaths.com\)  
**Date**\: Feb 2020  
**Description**\: Driver for ad9648. ZMOD ADC from Digilent. Module uses 2 different clock, so it's neccesary use synchronizers  
**Revision**\: 1. Module created.  

### Input list  
|**Name**|**Width**|**Description**|  
|-|-|-|  
|clk|[0:0]|Clock input|  
|rst|[0:0]|Reset input|  
|i14_data|[13:0]|Parallel input data from ADC|  
|i_dco|[0:0]|Input ch select|  
|clk_spi|[0:0]|Input clock for SPI. or_sclk = clk_spi/4|  

### Output list  
|**Name**|**Width**|**Description**|  
|-|-|-|  
|o14_data_a|[13:0]|Parallel converted ADC ch A|  
|o14_data_b|[13:0]|Parallel converted ADC ch B|  
|o_adc_configured|[0:0]|Adc configuration complete signal|  
|or_sck|[0:0]|ADC SPI clk out|  
|or_cs|[0:0]|ADC SPI data IO|  
|o_sdio|[0:0]|ADC SPI cs out|  

### Wire list  
|**Name**|**Width**|**Description**|  
|-|-|-|  
|w_spi_busy|[0:0]|SPI busy signal|  

### Register list  
|**Name**|**Width**|**Description**|  
|-|-|-|  
|r24_spi_data_out|[23:0]|Synchronizer 0 spi_data_out. RW | W[1:0] | A[12:0] | DATA[7:0]|  
|r24_spi_data_out_1|[23:0]|Synchronizer 1 spi_data_out. RW | W[1:0] | A[12:0] | DATA[7:0]|  
|24_spi_data_out_2|[23:0]|Synchronizer 2 spi_data_out. RW | W[1:0] | A[12:0] | DATA[7:0]|  
|r_spi_start|[0:0]|Sychronyzer 0 spi_start|  
|r_spi_start_1|[0:0]|Synchronizer 1 spi start|  
|r_spi_start_2|[0:0]|Synchronizer 2 spi start|  
|r27_delay_1ms_counter|[26:0]|Initial 1ms delay counter|  
|r30_delay_3s_counter|[29:0]|Initial 3 seconds delay counter. Only for Debug.|  
|r5_adc_config_state|[4:0]|ADC controller state|  
|r_cmd_read|[0:0]|Read command signal|  
|r4_spi_state|[3:0]|SPI controller state|  
|r5_data_counter|[4:0]|SPI data to write signal|  

### Instantiation example 
 ```verilog   
zmod_adc_driver_v1_0 zmod_adc_driver_v1_0_inst0(  
.clk(),  
.rst(),  
.o14_data_a(),  
.o14_data_b(),  
.o_adc_configured(),  
.i14_data(),  
.i_dco(),  
.clk_spi(),  
.or_sck(),  
.or_cs(),  
.o_sdio()   
);   
```

Automatic documentation generator. (https://github.com/controlpaths/verilog_parser)