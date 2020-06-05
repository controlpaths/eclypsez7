![image](logo.png)
#  top_eclypse_v1_0 
 **File:** ../../eclypsez7/src/top_eclypse_v1_0.v  
**Module name**\: top_eclypse_v1_0  
**Author**\: P Trujillo (pablo@controlpaths.com\)  
**Date**\: Feb 2020  
**Description**\: Top module for manage DAC output. ZMOD DAC from Digilent  
**Revision**\: 1.0 Module created.  

### Input list  
|**Name**|**Width**|**Description**|  
|-|-|-|  
|clk125mhz|[0:0]|25Mhz input clock|  
|i14_adc_data|[13:0]|Parallel ADC data in|  
|i_adc_dco|[0:0]|ADC data select input|  

### Output list  
|**Name**|**Width**|**Description**|  
|-|-|-|  
|o14_dac_data|[13:0]|Parallel DAC data out|  
|o_dac_clkout|[0:0]|DAC clock out|  
|o_dac_dclkio|[0:0]|DAC output select|  
|o_dac_fsadji|[0:0]|DAC full scale select for ch i out|  
|o_dac_fsadjq|[0:0]|DAC full scale select for ch q out|  
|o_dac_sck|[0:0]|DAC SPI clk out|  
|o_dac_sdio|[0:0]|DAC SPI data IO out|  
|o_dac_cs|[0:0]|DAC SPI cs out|  
|o_dac_rst|[0:0]|DAC reset out|  
|o_adc_clkout_p|[0:0]|ADC differential output clock p|  
|o_adc_clkout_n|[0:0]|ADC differential output clock p|  
|o_adc_sck|[0:0]|ADC SPI clk out|  
|o_adc_cs|[0:0]|ADC SPI cs out|  
|o_adc_sync|[0:0]|ADC SYNC out. SIgnal used for select configuration mode|  
|or_zmod_dac_relay|[0:0]|ZMOD DAC out relay|  
|o_zmod_adc_coupling_h_a|[0:0]|ZMOD ADC input coupling select for of channel A. Differential driver|  
|o_zmod_adc_coupling_l_a|[0:0]|ZMOD ADC input coupling select for of channel A. Differential driver|  
|o_zmod_adc_coupling_h_b|[0:0]|ZMOD ADC input coupling select for of channel B. Differential driver|  
|o_zmod_adc_coupling_l_b|[0:0]|ZMOD ADC input coupling select for of channel B. Differential driver|  
|o_zmod_adc_gain_h_a|[0:0]|ZMOD ADC input gain select for of channel A. Differential driver|  
|o_zmod_adc_gain_l_a|[0:0]|ZMOD ADC input gain select for of channel A. Differential driver|  
|o_zmod_adc_gain_h_b|[0:0]|ZMOD ADC input gain select for of channel B. Differential driver|  
|o_zmod_adc_gain_l_b|[0:0]|ZMOD ADC input gain select for of channel B. Differential driver|  
|o_zmod_adc_com_h|[0:0]|ZMOD ADC commom signal. Differential driver|  
|o_zmod_adc_com_l|[0:0]|ZMOD ADC commom signal. Differential driver|  
|or3_led0|[2:0]|Eclypse Z7 led 0|  
|or3_led1|[2:0]|Eclypse Z7 led 1|  

### Wire list  
|**Name**|**Width**|**Description**|  
|-|-|-|  
|pll_locked|[0:0]|PLL locked signal|  
|clk100mhz|[0:0]|100mhz clock signal|  
|clk50mhz|[0:0]|50mhz clock signal|  
|clk50mhz_ddr|[0:0]|50mhz forwarded clock signal to out|  
|w14_data_a_adc|[13:0]|Channel A ADC data|  
|w14_data_b_adc|[13:0]|Channel B ADC data|  
|adc_configured|[0:0]|Configuration done signal|  

### Register list  
|**Name**|**Width**|**Description**|  
|-|-|-|  
|rst_1|[0:0]|Synchronizer reset signal|  
|rst|[0:0]|Synchronizer reset signal|  
|r26_led_counter|[25:0]|Led blink prescaler|  
|r24_relay_delay_counter|[23:0]|Delay coungter to enable DAC output relay|  
|m14_signal|[13:0][127:0]|Memory for store signal|  
|rs14_data2write|[13:0]|Data indexed to write in DAC output|  
|r7_data_index|[6:0]|Index for data to write in DAC output|  

### Instantiation example 
 ```verilog   
top_eclypse_v1_0 top_eclypse_v1_0_inst0(  
.clk125mhz(),  
.o14_dac_data(),  
.o_dac_clkout(),  
.o_dac_dclkio(),  
.o_dac_fsadji(),  
.o_dac_fsadjq(),  
.o_dac_sck(),  
.o_dac_sdio(),  
.o_dac_cs(),  
.o_dac_rst(),  
.i14_adc_data(),  
.i_adc_dco(),  
.o_adc_clkout_p(),  
.o_adc_clkout_n(),  
.o_adc_sck(),  
.o_adc_cs(),  
.o_adc_sync(),  
.or_zmod_dac_relay(),  
.o_zmod_adc_coupling_h_a(),  
.o_zmod_adc_coupling_l_a(),  
.o_zmod_adc_coupling_h_b(),  
.o_zmod_adc_coupling_l_b(),  
.o_zmod_adc_gain_h_a(),  
.o_zmod_adc_gain_l_a(),  
.o_zmod_adc_gain_h_b(),  
.o_zmod_adc_gain_l_b(),  
.o_zmod_adc_com_h(),  
.o_zmod_adc_com_l(),  
.or3_led0(),  
.or3_led1()   
);   
```

Automatic documentation generator. (https://github.com/controlpaths/verilog_parser)