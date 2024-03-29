module Datapath(
    input clk, stop, clr, 
    input wire [31:0] in_port_data_in,
    output wire [31:0] out_port_data_out, MuxOut
);

    wire [31:0] Mdatain, MDR_data_out;

    wire PC_out, ZHigh_out, ZLow_out, HI_out, LO_out, C_out, MDR_out,
        MDR_enable, MAR_enable, Z_enable, Y_enable, PC_enable, LO_enable,
        con_in, out_port_enable, RAM_write_enable, IR_enable, Gra, Grb, 
        Grc, R_in, R_out, BA_out, in_port_out, in_port_enable,
        HI_enable, InPort, Read, Run, IncPC;


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
    wire [31:0] Y_data_out;
    wire [31:0] PC_data_out;
    wire [31:0] IR_data_out;
    wire [31:0] MAR_data_out;
    wire [31:0] ZLow_data_out;
    wire [31:0] ZHigh_data_out;
    wire [31:0] in_port_data_out;
    wire [31:0] C_sign_extended_data_out;
    

//     PHASE 2
    //MDR
    wire[4:0] enc_out;
    wire [63:0] C_data_out;
    
//  SELECT AND ENCODE
      wire [15:0] R_enables;
      wire [15:0] R_outs;

    // Instantiating the 16 registers
    wire [31:0] R0_og_data;
    wire R0_actual_enable;

    // To enable R0 to hold its previous value all while being able to send out zeros when needed
    reg_32_bit R0(R0_og_data, MuxOut, clk, clr, R0_actual_enable);
    // If BA_out == 1, send out zeros, else send out q
    assign R0_data_out = R0_og_data & ~{32{BA_out}};
    // If BA_out == 1, don't send bus data to R0, else, send original signal
    assign R0_actual_enable = (R_enables[0] == 1 && BA_out == 1) ? 0 : R_enables[0]; 

    
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
    
    defparam R15.INIT_VAL = 32'h00000028;

    // Instantiating special registers
    reg_32_bit HI(HI_data_out,  MuxOut, clk, clr, HI_enable);
    reg_32_bit LO(LO_data_out, MuxOut, clk, clr, LO_enable);
    reg_32_bit RY(Y_data_out, MuxOut, clk, clr, Y_enable);
    reg_32_bit IR(IR_data_out, MuxOut, clk, clr, IR_enable);
    reg_32_bit MAR(MAR_data_out, MuxOut, clk, clr, MAR_enable);
    z Z_reg(ZHigh_data_out, ZLow_data_out, C_data_out, clk, clr, Z_enable);

    // PC
    pc #(32'h00000000) PC (.PC_data_out(PC_data_out), .clk(clk), .IncPC(IncPC), .PC_enable(PC_enable), .MuxOut(MuxOut), .con_out(con_out)); 

//     ------------------------------------------ PHASE 2 SHIZZLE ------------------------------------------  //

    // CON FF 
    wire con_out;
    con_ff CON_FF(con_out, IR_data_out[20:19], MuxOut, con_in);

    // In/Out port cct
    reg_32_bit in_port(in_port_data_out, in_port_data_in, clk, clr, in_port_enable);
    reg_32_bit out_port(out_port_data_out, MuxOut, clk, clr, out_port_enable);  

    // Hard Coded PC values for P2 tests: (Not needed for P3)

    //ld Case 1:
    // defparam PC.INIT_VAL = 32'b000; //ld instruction
    // defparam PC.INIT_VAL = 32'b000; //ld R1, $75
    
    //ld Case 2: 
    // defparam R1.INIT_VAL = 32'b001; // for ld case 2
    // defparam PC.INIT_VAL = 32'b001; //ld instruction case 2


    // ldi Case 3:
    // defparam PC.INIT_VAL = 32'b010; //ldi R1, $75 

    //ldi Case 4:
    // defparam PC.INIT_VAL = 32'b011; //ldi R1, $45(R1) 
    // defparam R1.INIT_VAL = 32'h00000001; //R1 holds value of 1 for $45(R1) = $45+$1 = $46 = 70 decimal => 100 0110
    
    //st Case 1: st $90, R4
    // defparam PC.INIT_VAL = 32'b100; 
    // defparam R4.INIT_VAL = 32'h67;

    //st Case 2: st $90(R4), R4
    // defparam PC.INIT_VAL = 32'b101;  
    // defparam R4.INIT_VAL = 32'h67;

    //Case 1: brzr R6, 25
    // defparam PC.INIT_VAL = 32'b1000; 
    // defparam R6.INIT_VAL = 32'h0;

    //Case 2: brnz R6, 25
    // defparam PC.INIT_VAL = 32'b1001; 
    // defparam R6.INIT_VAL = 32'h1;

    // //Case 3: brpl R6, 25
    // defparam PC.INIT_VAL = 32'b1010; 
    // defparam R6.INIT_VAL = 32'h1;

    // //Case 4: brmi R6, 25
    // defparam PC.INIT_VAL = 32'b1011; 
    // defparam R6.INIT_VAL = 32'h80000000;

    //jr R2
    // defparam PC.INIT_VAL = 32'b1100; 
    // defparam R2.INIT_VAL = 32'hF;

    //jal
    // defparam PC.INIT_VAL = 32'b1101; 
    // defparam R2.INIT_VAL = 32'hF;

    // addi R2, R3, -3
    // defparam PC.INIT_VAL = 32'b110;

    //andi R2, R3, $25
    // defparam PC.INIT_VAL = 32'b10011;
    // defparam R3.INIT_VAL = 32'b1;

    //ori R2, R3, $25
    // defparam PC.INIT_VAL = 32'b00111;
    // defparam R3.INIT_VAL = 32'b1;

    // in
    // defparam PC.INIT_VAL = 32'b10000;

    //out
    // defparam R2.INIT_VAL = 32'hFFFFFFFF;
    // defparam PC.INIT_VAL = 32'b10100;

    //mfhi
    // defparam PC.INIT_VAL = 32'b01110;
    // defparam HI.INIT_VAL = 32'hFFFFFFFF;

    //mflo 
    // defparam PC.INIT_VAL = 32'b01111;
    // defparam LO.INIT_VAL = 32'hFFFFFFFF;
 

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
    mdr MDR(.MDRdataout(MDR_data_out), .MuxOut(MuxOut), .Mdatain(Mdatain), .read_signal(Read), .clk(clk), .clr(clr), .enable(MDR_enable));
    
    // 32:5 Encoder (Goes highest to lowest in descending order) For some reason the the the first three encoders dont work.
    encoder_32_to_5 BusEncoder(.enc_output(enc_out),
                              .enc_input(
                               { 
                                {8{1'b0}},
                                C_out,
                                in_port_out, 
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
                       in_port_data_out,
                       C_sign_extended_data_out,
                       enc_out
                       );

    alu alu_instance(C_data_out, Y_data_out, MuxOut, IR_data_out[31:27]);

    // Phase 3 shizzle
    control_unit CU(
        .PC_out(PC_out),
        .ZHigh_out(ZHigh_out),
        .ZLow_out(ZLow_out),
        .MDR_out(MDR_out),
        .MAR_enable(MAR_enable),
        .PC_enable(PC_enable),
        .MDR_enable(MDR_enable),
        .IR_enable(IR_enable),
        .Y_enable(Y_enable),
        .IncPC(IncPC),
        .Read(Read),
        .HI_enable(HI_enable),
        .LO_enable(LO_enable),
        .HI_out(HI_out),
        .LO_out(LO_out),
        .Z_enable(Z_enable),
        .C_out(C_out),
        .RAM_write_enable(RAM_write_enable),
        .Gra(Gra),
        .Grb(Grb),
        .Grc(Grc),
        .R_out(R_out),
        .BA_out(BA_out),
        .con_in(con_in),
        .in_port_enable(in_port_enable),
        .out_port_enable(out_port_enable),
        .in_port_out(in_port_out),
        .Run(Run),
        .R_in(R_in),
        //.R_enables(R_enables),
        .IR_data_out(IR_data_out),
        .clk(clk),
        .clr(cl),
        .stop(stop)
    );

endmodule
