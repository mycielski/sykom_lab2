module gpioemu(n_reset, saddress[15:0], srd, swr, sdata_in[31:0], sdata_out[31:0], gpio_in[31:0], gpio_latch, gpio_out[31:0], clk, gpio_in_s_insp[31:0]);

input n_reset;
input [15:0] saddress;
input srd;
input swr;
input [31:0] sdata_in;
input [31:0] gpio_in;
input gpio_latch;
input clk;

output[31:0] sdata_out;
output [31:0] gpio_out;
output [31:0] gpio_in_s_insp;

reg [31:0] gpio_in_s;
reg [31:0] gpio_out_s;
reg [31:0] sdata_in_s;
reg [31:0] sdata_out_s;



//odpowiedz na reset (aktywowane przejściem 1->0)
always@(negedge n_reset) begin
    sdata_out_s <= 0;
    gpio_out_s <= 0;
    gpio_in_s <= 0;
end

// odczyt z portu GPIO
always@(posedge gpio_latch) begin
    gpio_in_s <= gpio_in;
end


endmodule