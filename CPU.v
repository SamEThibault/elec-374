// `include "modules/reg_32bit.v"
// `include "modules/reg_z64bit.v"
// `include "modules/pc_32bit.v"
// `include "modules/bus_mux.v"
// `include "modules/encoder_32_to_5.v"
// `include "modules/mux_2_to_1.v"
// `include "modules/alu.v"

module cpu(
input [4:0] opcode,
input [31:0] MDRout, 
             HI_data_out, 
             LO_data_out, 
             In_port_data_out, 
input [31:0] Mdatain,
input 
      ZHigh_data_out, 
      ZLow_data_out, 
      PC_data_out, 

input RC_data_out,
input MDRin, 
input MARin,
input Zin, 
input Yin, 
input IRin, 
input PCin,
input CONin,
input LOin, 
input HIin, 
input Read,
input clr, 
input clk, 
input InPort, 
input IncPC,
input R0out, 
      R1out, 
      R2out, 
      R3out, 
      R4out, 
      R5out, 
      R6out, 
      R7out, 
      R8out, 
      R9out, 
      R10out, 
      R11out, 
      R12out, 
      R13out, 
      R14out, 
      R15out,
input R0_enable, 
      R1_enable, 
      R2_enable, 
      R3_enable, 
      R4_enable,
      R5_enable, 
      R6_enable, 
      R7_enable, 
      R8_enable, 
      R9_enable, 
      R10_enable, 
      R11_enable, 
      R12_enable, 
      R13_enable, 
      R14_enable, 
      R15_enable

);
    wire [15:0] enable;

    //Enable Signals
    wire IR_enable;
    wire In_port_enable;
    wire Out_port_enable;

    // General Purpose Registers
    wire [31:0] R0_data_out;
    wire [31:0] R1_data_out;
    wire [31:0] R2_data_out;
    wire [31:0] R3_data_out;
    wire [31:0] R4_data_out;
    wire [31:0] R5_data_out;
    wire [31:0] R6_data_out;
    wire [31:0] R7_data_out;
    wire [31:0] R8_data_out;
    wire [31:0] R9_data_out;
    wire [31:0] R10_data_out;
    wire [31:0] R11_data_out;
    wire [31:0] R12_data_out;
    wire [31:0] R13_data_out;
    wire [31:0] R14_data_out;
    wire [31:0] R15_data_out;

    //Special Registers
    wire [31:0] PC_data_out;
    wire [31:0] IR_data_out;
    wire [31:0] MAR_data_out;
    wire [31:0] MDR_data_out;
    wire [31:0] In_port_data_out;
    wire [31:0] HI_data_out;
    wire [31:0] LO_data_out;

    //ALU Registers
    wire [31:0] RC_data_out;
    wire [31:0] RY_data_out;
    wire [31:0] ZLow_data_out;
    wire [31:0] ZHigh_data_out;

    //Encoder ouput
    wire[4:0] enc_out;

    
    // Instantiating the 16 registers
    reg_32_bit R0(R0_data_out, clk, clr, R0_enable, R0out);
    reg_32_bit R1(R1_data_out, clk, clr, R1_enable, R1out);
    reg_32_bit R2(R2_data_out, clk, clr, R2_enable, R2out);
    reg_32_bit R3(R3_data_out, clk, clr, R3_enable, R3out);
    reg_32_bit R4(R4_data_out, clk, clr, R4_enable, R4out);
    reg_32_bit R5(R5_data_out, clk, clr, R5_enable, R5out);
    reg_32_bit R6(R6_data_out, clk, clr, R6_enable, R6out);
    reg_32_bit R7(R7_data_out, clk, clr, R7_enable, R7out);
    reg_32_bit R8(R8_data_out, clk, clr, R8_enable, R8out);
    reg_32_bit R9(R9_data_out, clk, clr, R9_enable, R9out);
    reg_32_bit R10(R10_data_out, clk, clr, r10_enable, R10out);
    reg_32_bit R11(R11_data_out, clk, clr, r11_enable, R11out);
    reg_32_bit R12(R12_data_out, clk, clr, r12_enable, R12out);
    reg_32_bit R13(R13_data_out, clk, clr, r13_enable, R13out);
    reg_32_bit R14(R14_data_out, clk, clr, r14_enable, R14out);
    reg_32_bit R15(R15_data_out, clk, clr, r15_enable, R15out);
    
    // Instantiating special registers
    pc pc_instance(PC_data_out, clk, PC_increment, PC_enable, );
    reg_32_bit IR(IR_data_out, clk, clr, IR_enable, );
    reg_32_bit MAR(MAR_data_out, clk, clr, MAR_enable, );
    reg_32_bit MDR(MDR_data_out, clk, clr, MDR_enable, );
    reg_32_bit In_Port(In_port_data_out, clk, clr, In_port_enable, );
    reg_32_bit HI(HI_data_out, clk, clr, HI_enable, );
    reg_32_bit LO(LO_data_out, clk, clr, LO_enable, );

    //Instantiating ALU registers
    reg_32_bit RC(RC_data_out, clk, clr, RC_enable, );
    reg_32_bit RY(RY_data_out, clk, clr, RY_enable, );
    reg_32_bit Z_LO(ZLow_data_out, clk, clr, RZHigh_enable, );
    reg_32_bit Z_HI(ZHigh_data_out, clk, clr, RZLow_enable, );
    
    
    //Figure 3: A Typical Bus
    
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

    // 32:5 Encoder
    encoder_32_to_5 BusEncoder(enc_out,
                               {{8{1'b0}},
                                R15_Eout,
                                R14_Eout,
                                R13_Eout, 
                                R12_Eout, 
                                R11_Eout, 
                                R10_Eout, 
                                R9_Eout,
                                R8_Eout, 
                                R7_Eout, 
                                R6_Eout,
                                R5_Eout, 
                                R4_Eout,
                                R3_Eout, 
                                R2_Eout, 
                                R1_Eout, 
                                R0_Eout, 
                                } 
                                );

    //Multiplexer Bus Mux 32:1
    mux_32_to_1 BusMux(BusMuxOut, 
                       R0_data_out, 
                       R1_data_out, 
                       R2_data_out, 
                       R3_data_out, 
                       R4_data_out, 
                       R5_data_out, 
                       R6_data_out, 
                       R7_data_out, 
                       R8_data_out, 
                       R9_data_out, 
                       R10_data_out, 
                       R11_data_out, 
                       R12_data_out, 
                       R13_data_out,
                       R14_data_out, 
                       R15_data_out, 
                       HI_data_out, 
                       LO_data_out, 
                       ZHigh_data_out, 
                       ZLow_data_out, 
                       PC_data_out,
                       MDR_data_out,
                       In_port_data_out,
                       C_sign_extended_out,
                       enc_out
                       );


    reg [63:0] RC;
    wire [31:0] Ra;
    wire [31:0] Rb;
    wire [3:0] opcode;
    alu alu_instance(RC, Ra, rb, opcode);

    Z_HI = RC[63:32];
    Z_LO = RC[31:0];
endmodule