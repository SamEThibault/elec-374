`include "modules/32bit_reg.v"

module top;
    wire clk;
    wire clr;
    wire enable;
    wire [31:0] R0_out;
    // must actually define BusMuxOut in here once bus complete
    Register32 R0(BusMuxOut, clk, clr, enable, R0_out);
    
endmodule