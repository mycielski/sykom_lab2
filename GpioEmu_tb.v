`timescale 1 ns /10 ps

module GpioEmu_tb;

	reg  n_reset = 1;
	reg[15:0] saddress = 0;
	reg[31:0] sdata_in = 0;
	reg[31:0] gpio_in = 0;
	reg gpio_latch = 0;
	reg clk= 0;
	reg srd = 0;
	reg swr = 0;

	wire[31:0] gpio_out_test;
	wire[31:0] sdata_out_test;
	wire[31:0] gpio_in_s_insp_test;
	wire[7:0] counter;

	initial begin
		$dumpfile("GpioEmu.vcd");
		$dumpvars(0,GpioEmu_tb);
	end
	
	always
		#1 clk= ~clk;

    initial begin 

        //reset
        # 5 n_reset = 0;
        # 5 n_reset = 1;

        //zapis 1 oś
        #5 saddress= 16'h6ba0;
		#5 sdata_in = 32'h123fffaa;
		#5 swr= 1;
		#5 swr= 0;

        //zapis 2 oś
        #5 saddress= 16'hdb10;
		#5 sdata_in = 32'h123fffaa;
		#5 swr= 1;
		#5 swr= 0;

        //zły zapis
        #5 saddress= 16'hffff;
		#5 sdata_in = 32'h123fffaa;
		#5 swr= 1;
		#5 swr= 0;

        //reset
        # 5 n_reset = 0;
        # 5 n_reset = 1;

        //odczyt z osi 1
		#5 gpio_in = 32'h123fffaa;
		#5 gpio_latch = 1;
		#5 gpio_latch = 0;
		#5 saddress= 16'h6ba0;
		#5 srd= 1;
		#5 srd= 0;
		
		//odczyt z osi 2
		#5 gpio_in = 32'h123fffaa;
		#5 gpio_latch = 1;
		#5 gpio_latch = 0;
		#5 saddress= 16'hdb10;;
		#5 srd= 1;
		#5 srd= 0;

		//Zły odczyt
		#5 gpio_in = 32'h123fffaa;
		#5 gpio_latch = 1;
		#5 gpio_latch = 0;
		#5 saddress= 16'hffff;
		#5 srd= 1;
		#5 srd= 0;

		//reset
		#5 n_reset = 0;
		#5 n_reset = 1;

		#300 srd= 1;
		#1500 $finish;

	end
	GpioEmu test1(n_reset, saddress, srd, swr, sdata_in, sdata_out_test, gpio_in, gpio_latch, gpio_out_test, clk, gpio_in_s_insp_test, counter);
endmodule