module Datapath(
input PC_out, ZHigh_out, ZLow_out, HI_out, LO_out, In_port_out, C_out,
input MDR_out,MDR_enable, MAR_enable, Z_enable, Y_enable, PC_enable, CON_enable, LO_enable, 
      HI_enable, clr, clk, InPort, IncPC, Read,
input [4:0] opcode,
// input R0_out, R1_out, R2_out, R3_out, R4_out, R5_out, R6_out, R7_out, R8_out, R9_out, 
//       R10_out, R11_out, R12_out, R13_out, R14_out, R15_out,
// input R0_enable, R1_enable, R2_enable, R3_enable, R4_enable, R5_enable, R6_enable, 
//       R7_enable, R8_enable, R9_enable, R10_enable, R11_enable, R12_enable, R13_enable, 
//       R14_enable, R15_enable,

// Phase 2 Inputs/Outputs
input con_in, in_port_in, out_port_enable, RAM_write_enable, IR_enable,  
input Gra, Grb, Grc, R_in, R_out, BA_out
);




wire[31:0] Mdatain;

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
    wire [31:0] HI_data_out;
    wire [31:0] LO_data_out;
    wire [31:0] MuxOut;
    wire [31:0] Y_data_out;
    wire [31:0] PC_data_out;
    wire [31:0] IR_data_out;
    wire [31:0] MAR_data_out;
    wire [31:0] MDR_data_out;
    wire [31:0] ZLow_data_out;
    wire [31:0] ZHigh_data_out;
    wire [31:0] In_port_data_out;
    wire [31:0] C_sign_extended_data_out;
    

//     PHASE 2
    //MDR
    wire[4:0] enc_out;
    wire [63:0] C_data_out;
    
//  SELECT AND ENCODE
      wire [15:0] R_enables;
      wire [15:0] R_outs;

    // Instantiating the 16 registers
    reg0_32_bit R0(R0_data_out, MuxOut, clk, clr, R_enables[0], BA_out);
    reg_32_bit R1(R1_data_out, MuxOut, clk, clr, R_enables[1]);
    reg_32_bit R2(R2_data_out, MuxOut, clk, clr, R_enables[2]);
    reg_32_bit R3(R3_data_out, MuxOut, clk, clr, R_enables[3]);
    reg_32_bit R4(R4_data_out, MuxOut, clk, clr, R_enables[4]);
    reg_32_bit R5(R5_data_out, MuxOut, clk, clr, R_enables[5]);
    reg_32_bit R6(R6_data_out, MuxOut, clk, clr, R_enables[6]);
    reg_32_bit R7(R7_data_out, MuxOut, clk, clr, R_enables[7]);
    reg_32_bit R8(R8_data_out, MuxOut, clk, clr, R_enables[8]);
    reg_32_bit R9(R9_data_out, MuxOut, clk, clr, R_enables[9]);
    reg_32_bit R10(R10_data_out, MuxOut, clk, clr, R_enables[10]);
    reg_32_bit R11(R11_data_out, MuxOut, clk, clr, R_enables[11]);
    reg_32_bit R12(R12_data_out, MuxOut, clk, clr, R_enables[12]);
    reg_32_bit R13(R13_data_out, MuxOut, clk, clr, R_enables[13]);
    reg_32_bit R14(R14_data_out, MuxOut, clk, clr, R_enables[14]);
    reg_32_bit R15(R15_data_out, MuxOut, clk, clr, R_enables[15]);
    
    // Instantiating special registers
    reg_32_bit HI(HI_data_out,  MuxOut, clk, clr, HI_enable);
    reg_32_bit LO(LO_data_out, MuxOut, clk, clr, LO_enable);
    reg_32_bit RY(Y_data_out, MuxOut, clk, clr, Y_enable);
    reg_32_bit IR(IR_data_out, MuxOut, clk, clr, IR_enable);
    reg_32_bit MAR(MAR_data_out, MuxOut, clk, clr, MAR_enable);
    z Z_reg(ZHigh_data_out, ZLow_data_out, C_data_out, clk, clr, Z_enable);

    
    // PC
    pc PC(PC_data_out, clk, IncPC, PC_enable, MuxOut); //ld R1, $75


    // CON FF cct
    wire con_out;
    con_ff CON_FF(con_out, IR_data_out[20:19], BusMuxOut, con_in);

//     ------------------------------------------ PHASE 2 SHIZ ------------------------------------------  //
    
    // In/Out Ports cct
    wire [31:0] in_port_out;
    wire in_port_enable = 1;       // no enable so just always set it to 1. (Note we might not need to set the value here maybe just in test bench)
    reg_32_bit in_port(in_port_out, in_port_in, clk, clr, in_port_enable);

    wire [31:0] out_port_out;       // "to output unit"
    reg_32_bit out_port(out_port_out, BusMuxOut, clk, clr, out_port_enable);  

    
    //ld Case 1:
    //defparam PC.INIT_VAL = 32'b000; //ld instruction
    //defparam PC.INIT_VAL = 32'b000; //ld R1, $75
    
    //ld Case 2: 
//     defparam R1.init_val = 32'b001; // for ld case 2
//     defparam PC.INIT_VAL = 32'b001; //ld instruction case 2


    //ldi Case 3:
    // defparam PC.INIT_VAL = 32'b010; //ldi R1, $75 

    //ldi Case 4:
//     defparam PC.INIT_VAL = 32'b011; //ldi R1, $45(R1) 
    // defparam R1.INIT_VAL = 32'h00000001; //R1 holds value of 1 for $45(R1) = $45+$1 = $46 = 70 decimal => 100 0110
    
    //st Case 1: st $90, R4
    defparam PC.INIT_VAL = 32'b100; //ldi R1, $45(R1) 
    defparam R4.INIT_VAL = 32'h94;

    // RAM
    ram RAM(.RAM_data_out(Mdatain), .RAM_data_in(MDR_data_out), .address(MAR_data_out[8:0]), .clk(clk), .write_enable(RAM_write_enable), .read_enable(Read));

    select_and_encode SELECT_AND_ENCODE(
    .C_sign_extended_out(C_sign_extended_data_out), 
    .R_enables(R_enables), 
    .R_outs(R_outs), 
    .Gra(Gra), 
    .Grb(Grb), 
    .Grc(Grc), 
    .R_in(R_in), 
    .R_out(R_out), 
    .BA_out(BA_out),
    .IR(IR_data_out));
    
    //MDR
    mdr MDR(.MDRdataout(MDR_data_out), .BusMuxOut(MuxOut), .Mdatain(Mdatain), .read_signal(Read), .clk(clk), .clr(clr), .enable(MDR_enable));
    
    // 32:5 Encoder (Goes highest to lowest in descending order) For some reason the the the first three encoders dont work.
    encoder_32_to_5 BusEncoder(.enc_output(enc_out),
                              .enc_input(
                               { 
                                {8{1'b0}},
                                C_out,
                                In_port_out, 
                                MDR_out, 
                                PC_out, 
                                ZLow_out,
                                ZHigh_out,
                                LO_out, 
                                HI_out, 
                                R_outs[15],
                                R_outs[14],
                                R_outs[13],
                                R_outs[12],
                                R_outs[11],
                                R_outs[10],
                                R_outs[9],
                                R_outs[8],
                                R_outs[7],
                                R_outs[6],
                                R_outs[5],
                                R_outs[4],
                                R_outs[3],
                                R_outs[2],
                                R_outs[1],
                                R_outs[0]
                                } 
                              )
                                );

    //Multiplexer Bus Mux 32:1 all of these inputs are the data that will be sent to "MuxOut" based on the "enc_out" selection
    mux_32_to_1 BusMux(MuxOut, 
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
                       C_sign_extended_data_out,
                       enc_out
                       );

    alu alu_instance(C_data_out, Y_data_out, MuxOut, opcode);

              
endmodule
