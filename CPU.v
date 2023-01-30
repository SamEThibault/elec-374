`include "modules/32bit_reg.v"

module top;
    wire clk;
    wire clr;
    wire [15:0] enable;
    wire [31:0] R0_out;
    wire [31:0] R1_out;
    wire [31:0] R2_out;
    wire [31:0] R3_out;
    wire [31:0] R4_out;
    wire [31:0] R5_out;
    wire [31:0] R6_out;
    wire [31:0] R7_out;
    wire [31:0] R8_out;
    wire [31:0] R9_out;
    wire [31:0] R10_out;
    wire [31:0] R11_out;
    wire [31:0] R12_out;
    wire [31:0] R13_out;
    wire [31:0] R14_out;
    wire [31:0] R15_out;
    
    // must actually define BusMuxOut in here once bus complete
    Register32 R0(BusMuxOut, clk, clr, enable[0], R0_out);
    Register32 R1(BusMuxOut, clk, clr, enable[1], R1_out);
    Register32 R2(BusMuxOut, clk, clr, enable[2], R2_out);
    Register32 R3(BusMuxOut, clk, clr, enable[3], R3_out);
    Register32 R4(BusMuxOut, clk, clr, enable[4], R4_out);
    Register32 R5(BusMuxOut, clk, clr, enable[5], R5_out);
    Register32 R6(BusMuxOut, clk, clr, enable[6], R6_out);
    Register32 R7(BusMuxOut, clk, clr, enable[7], R7_out);
    Register32 R8(BusMuxOut, clk, clr, enable[8], R8_out);
    Register32 R9(BusMuxOut, clk, clr, enable[9], R9_out);
    Register32 R10(BusMuxOut, clk, clr, enable[10], R10_out);
    Register32 R11(BusMuxOut, clk, clr, enable[11], R11_out);
    Register32 R12(BusMuxOut, clk, clr, enable[12], R12_out);
    Register32 R13(BusMuxOut, clk, clr, enable[13], R13_out);
    Register32 R14(BusMuxOut, clk, clr, enable[14], R14_out);
    Register32 R15(BusMuxOut, clk, clr, enable[15], R15_out);

endmodule