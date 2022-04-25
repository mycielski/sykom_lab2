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
always@(posedge gpio_in) begin
    gpio_in_s <= gpio_in;
end

// odczyt na gpio

wire [11:0] cut_address;
assign cut_address = {sadddress[15:12], sadddress[7:0]};

always@(posedge srd) begin
    if(cut_address == 12'h6b0)
        sdata_in_s <= gpio_in_s[3:0] << 8;
    else if (cut_address == 12'hdb0) 
        sdata_in_s <= gpio_in_s[7:4] << 20;
    else 
        sdata_in_s <= 0;
end


always@(posedge swr) begin
    if(cut_address == 12'h6b0)
        sdata_out_s[3:0] <= sdata_out[11:8];
    else if (cut_address == 12'hdb0) 
        sdata_out_s[7:4] <= sdata_out[23:20];
    else 
        gpio_out_s <= gpio_out;
end

assign sdata_in = sdata_in_s;
assign gpio_out = gpio_out_s;


endmodule