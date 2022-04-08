module GpioEmu_tb;
initial begin
$dumpfile("GpioEmu.vcd");
$dumpvars(0, GpioEmu_tb);
End
initial begin
# 5 reset = 0;
# 10 sadddress = ...;
# 11 sdata = ...;
# 12 swr=...;
...
# 1000 $finish;
end
...
endmodule