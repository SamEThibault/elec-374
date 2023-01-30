`include "modules/32bit_reg.v"

module top;
    wire clk;
    wire clr;
    wire enable;
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

    wire [31:0] enable_R0;
    wire [31:0] enable_R1;
    wire [31:0] enable_R2;
    wire [31:0] enable_R3;
    wire [31:0] enable_R4;
    wire [31:0] enable_R5;
    wire [31:0] enable_R6;
    wire [31:0] enable_R7;
    wire [31:0] enable_R8;
    wire [31:0] enable_R9;
    wire [31:0] enable_R10;
    wire [31:0] enable_R11;
    wire [31:0] enable_R12;
    wire [31:0] enable_R13;
    wire [31:0] enable_R14;
    wire [31:0] enable_R15;
    
    // must actually define BusMuxOut in here once bus complete
    Register32 R0(BusMuxOut, clk, clr, enable_R0, R0_out);
    Register32 R1(BusMuxOut, clk, clr, enable_R1, R1_out);
    Register32 R2(BusMuxOut, clk, clr, enable_R2, R2_out);
    Register32 R3(BusMuxOut, clk, clr, enable_R3, R3_out);
    Register32 R4(BusMuxOut, clk, clr, enable_R4, R4_out);
    Register32 R5(BusMuxOut, clk, clr, enable_R5, R5_out);
    Register32 R6(BusMuxOut, clk, clr, enable_R6, R6_out);
    Register32 R7(BusMuxOut, clk, clr, enable_R7, R7_out);
    Register32 R8(BusMuxOut, clk, clr, enable_R8, R8_out);
    Register32 R9(BusMuxOut, clk, clr, enable_R9, R9_out);
    Register32 R10(BusMuxOut, clk, clr, enable_R10, R10_out);
    Register32 R11(BusMuxOut, clk, clr, enable_R11, R11_out);
    Register32 R12(BusMuxOut, clk, clr, enable_R12, R12_out);
    Register32 R13(BusMuxOut, clk, clr, enable_R13, R13_out);
    Register32 R14(BusMuxOut, clk, clr, enable_R14, R14_out);
    Register32 R15(BusMuxOut, clk, clr, enable_R15, R15_out);

endmodule