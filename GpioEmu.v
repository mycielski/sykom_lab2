module gpioemu(n_reset, saddress[15:0], srd, swr, sdata_in[31:0], sdata_out[31:0],
gpio_in[31:0], gpio_latch, gpio_out[31:0], clk, gpio_in_s_insp[31:0]);
input n_reset;
input [15:0] saddress;
input srd;
input swr;
input [31:0] sdata_in;
output[31:0] sdata_out;
input [31:0] gpio_in;
input gpio_latch;
output [31:0] gpio_out;
reg [31:0] gpio_in_s;
reg [31:0] gpio_out_s;
reg [31:0] sdata_out;
output [31:0] gpio_in_s_insp;
input clk;
endmodule

//odpowiedz na reset (aktywowane przejściem 1->0)
