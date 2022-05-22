/*verilator lint_off UNUSED */
/*verilator lint_off WIDTH */
/*verilator lint_off MULTIDRIVEN */
module gpioemu(n_reset, saddress[15:0], srd, swr, sdata_in[31:0], sdata_out[31:0], gpio_in[31:0], gpio_latch, gpio_out[31:0], clk, gpio_in_s_insp[31:0], counter[7:0]);

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
output [7:0] counter;

reg [31:0] gpio_in_s;
reg [31:0] gpio_out_s;
reg [31:0] sdata_out_s;
reg [7:0] counter_s;
//reg count_flag;
reg interrupt;


//Reset
always@(negedge n_reset) begin
    sdata_out_s <= 0;
    gpio_out_s <= 0;
    gpio_in_s <= 0;
    counter_s <= 8'h4e;
    interrupt <= 0;
end

// odczyt na gpio
always@(posedge gpio_latch) begin
    gpio_in_s <= gpio_in;
end

always @(posedge clk) begin 
    //if(count_flag == 1) begin 
    if(counter_s >= 0)
        counter_s = counter_s - 1;
    else
        interrupt <= 1;
    //end
end


wire [11:0] cut_address;
assign cut_address = {saddress[15:8], saddress[3:0]};

always@(posedge srd) begin
    if(cut_address == 12'h6b0)
        //sdata_out_s <= (gpio_in_s[3:0] << 8);
        sdata_out_s <= (gpio_in_s & 32'h0f) << 8;
    else if (cut_address == 12'hdb0) 
        sdata_out_s <= (gpio_in_s & 32'h0f) << 20;
        sdata_out_s <= (interrupt << 4);
    // else 
    //     sdata_out_s <= 0;
end


always@(posedge swr) begin
    if(cut_address == 12'h6b0)
        gpio_out_s[3:0] <= sdata_in[11:8];  
    else if (cut_address == 12'hdb0) 
        gpio_out_s[7:4] <= sdata_in[23:20];  
        if (((sdata_in >> 4 ) & 1'b1) == 1)
            counter_s <= 8'h4e;
    // else 
    //     gpio_out_s <= gpio_out;
end

assign sdata_out = sdata_out_s;
assign gpio_out = gpio_out_s;
assign gpio_in_s_insp = gpio_in_s;
assign counter = counter_s;


endmodule
