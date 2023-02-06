`include "modules/reg_32bit.v"
`include "modules/reg_z64bit.v"
`include "modules/pc_32bit.v"
`include "modules/bus_module.v"
`include "modules/encoder_32_to_5.v"
`include "modules/mux_2_to_1.v"

module top(input wire clk, input wire clr, input wire Mdatain, input wire[31:0] inPort, output wire [31:0] outPort);
    wire clk;
    wire clr;
    wire [15:0] enable;
    wire IR_enable;
    wire RY_enable;
    wire RZLow_enable;
    wire RZHigh_enable;
    wire MDR_enable;
    wire MAR_enable;
    wire LO_enable;
    wire HI_enable;
    wire PC_enable;
    wire PC_increment;
    wire RC_enable;
    wire[32:0] BusMuxOut;

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
    wire [31:0] IR_out;
    wire [31:0] RY_out;
    wire [31:0] ZLow_out;
    wire [31:0] ZHigh_out;
    wire [31:0] MDR_out;
    wire [31:0] MDRMux_out;
    wire [31:0] MAR_out;
    wire [31:0] LO_out;
    wire [31:0] HI_out;
    wire [31:0] PC_out;
    wire [31:0] RC_out;
    wire MD_read;
    
    // Instantiating the 16 registers
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


    Register32 MAR(BusMuxOut, clk, clr, MAR_enable, MAR_out);
    Register32 LO(BusMuxOut, clk, clr, LO_enable, LO_out);
    Register32 HI(BusMuxOut, clk, clr, HI_enable, HI_out);
    Register32 IR(BusMuxOut, clk, clr, IR_enable, IR_out);
    Register32 Z_HI(BusMuxOut, clk, clr, RZLow_enable, ZLow_out);
    Register32 Z_LO(BusMuxOut, clk, clr, RZHigh_enable, ZHigh_out);
    Register32 RY(BusMuxOut, clk, clr, RY_enable, RY_out);
    PCRegister PC(BusMuxOut, clk, PC_increment, PC_enable, PC_out);
    Register32 RC(BusMuxOut, clk, clr, RC_enable, RC_out);


    // MDR Implementation
    mux_2_to_1 MDMux(MDRMux_out, Mdatain, BusMuxOut, MD_read);
    
    Register32 MDR(MDRMux_out, clk, clr, MDR_enable, MDR_out);
    

    bus_mux BusMux(BusMuxOut, R0_out, R1_out, R2_out, R3_out, R4_out, R5_out, R6_out, 
                    R7_out, R8_out, R9_out, R10_out, R11_out, R12_out, R13_out,
                    R14_out, R15_out, HI_out, LO_out, ZHigh_out, ZLow_out, PC_out,
                    MDR_out);

    // encoder input signals
    wire R0_EOut;
    wire R1_EOut;
    wire R2_EOut;
    wire R3_EOut;
    wire R4_EOut;
    wire R5_EOut;
    wire R6_EOut;
    wire R7_EOut;
    wire R8_EOut;
    wire R9_EOut;
    wire R10_EOut;
    wire R11_EOut;
    wire R12_EOut;
    wire R13_EOut;
    wire R14_EOut;
    wire R15_EOut;

    // encoder output
    wire[4:0] enc_out;

    encoder_32to5 BusEncoder({R0_Eout, R1_Eout, R2_Eout, R3_Eout, R4_Eout,
                                R5_Eout, R6_Eout, R7_Eout, R8_Eout, R9_Eout,
                                R10_Eout, R11_Eout, R12_Eout, R13_Eout, R14_Eout,
                                R15_Eout}, enc_out);

endmodule