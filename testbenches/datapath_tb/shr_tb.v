`timescale 1ns/10ps
module shr_tb;
    reg PC_out, ZLow_out, ZHigh_out, HI_out, LO_out, C_out, R_out, In_port_out; 
    reg R0_out, R1_out, R2_out, R3_out, R4_out, R5_out;
    reg R6_out, R7_out, R8_out, R9_out, R10_out, R11_out;
    reg R12_out, R13_out, R14_out, R15_out;
    reg [31:0] MDR_out;
    reg MAR_enable, Z_enable, PC_enable, MDR_enable, IR_enable, Y_enable;
    reg IncPC, Read;
    reg R0_enable, R1_enable, R2_enable, R3_enable, R4_enable, R5_enable;
    reg R6_enable, R7_enable, R8_enable, R9_enable, R10_enable, R11_enable;
    reg R12_enable, R13_enable, R14_enable, R15_enable;
    reg [4:0] opcode;
    reg Clock, clr;
    reg [31:0] Mdatain;

    parameter Default = 4'b0000, Reg_load1a = 4'b0001, Reg_load1b = 4'b0010, Reg_load2a = 4'b0011,
    Reg_load2b = 4'b0100, Reg_load3a = 4'b0101, Reg_load3b = 4'b0110, T0 = 4'b0111,
    T1 = 4'b1000, T2 = 4'b1001, T3 = 4'b1010, T4 = 4'b1011, T5 = 4'b1100;
    reg [3:0] Present_state = Default;

    Datapath DUT(
	 .PC_out(PC_out), 
     .ZHigh_out(ZHigh_out),
	 .ZLow_out(ZLow_out), 
	 .MDR_out(MDR_out),
     .HI_out(HI_out),
     .LO_out(LO_out),
     .C_out(C_out),
     .In_port_out(In_port_out),
     .R0_out(R0_out),
     .R1_out(R1_out),
	 .R2_out(R2_out),
     .R3_out(R3_out),
     .R4_out(R4_out),
     .R5_out(R5_out),
     .R6_out(R6_out), 
     .R7_out(R7_out),
     .R8_out(R8_out),
     .R9_out(R9_out),
     .R10_out(R10_out),
     .R11_out(R11_out),
	.R12_out(R12_out), 
     .R13_out(R13_out), 
     .R14_out(R14_out), 
     .R15_out(R15_out), 
	  .Mdatain(Mdatain),
	  .MDR_enable(MDR_enable), 
     .MAR_enable(MAR_enable), 
	  .Z_enable(Z_enable), 
	 .Y_enable(Y_enable), 
	 .IR_enable(IR_enable), 
	 .PC_enable(PC_enable), 
     .Read(Read), 
	 .IncPC(IncPC), 
	 .clk(Clock), 
     .clr(clr),
	 .opcode(opcode), 
     .R0_enable(R0_enable), 
	 .R1_enable(R1_enable), 
	 .R2_enable(R2_enable), 
	 .R3_enable(R3_enable), 
     .R4_enable(R4_enable), 
	 .R5_enable(R5_enable), 
	 .R6_enable(R6_enable), 
     .R7_enable(R7_enable), 
	 .R8_enable(R8_enable), 
	 .R9_enable(R9_enable), 
     .R10_enable(R10_enable), 
	 .R11_enable(R11_enable), 
	 .R12_enable(R12_enable), 
     .R13_enable(R13_enable), 
	 .R14_enable(R14_enable), 
	 .R15_enable(R15_enable) 
    );

    initial
        begin
            Clock = 0;
            forever #10 Clock = ~ Clock;
        end

    always @(posedge Clock) // finite state machine; if clock rising-edge
        begin
            case (Present_state)
                Default : Present_state = Reg_load1a;
                Reg_load1a : Present_state = Reg_load1b;
                Reg_load1b : Present_state = Reg_load2a;
                Reg_load2a : Present_state = Reg_load2b;
                Reg_load2b : Present_state = Reg_load3a;
                Reg_load3a : Present_state = Reg_load3b;
                Reg_load3b : Present_state = T0;
                T0 : Present_state = T1;
                T1 : Present_state = T2;
                T2 : Present_state = T3;
                T3 : Present_state = T4;
                T4 : Present_state = T5;
            endcase
        end

    always @(Present_state) // do the required job in each state
        begin
            case (Present_state) // assert the required signals in each clock cycle
                Default: begin
                    PC_out <= 0; ZLow_out <= 0; MDR_out <= 0; // initialize the signals
                    clr<=0;
                    MAR_enable <= 0; Z_enable <= 0;
                    PC_enable <=0; MDR_enable <= 0; IR_enable= 0; Y_enable= 0;
                    IncPC <= 0; Read <= 0; opcode <= 0;
                    R1_enable <= 0; R2_enable <= 0; R3_enable <= 0; Mdatain <= 32'h00000000;
                    ZHigh_out <= 0; HI_out <= 0; LO_out <= 0; C_out <= 0; In_port_out <= 0;
                    //Out Registers
                    R0_out <= 0; R1_out <= 0; R2_out <= 0; R3_out <= 0; R4_out <= 0; R5_out <= 0;
                    R6_out <= 0; R7_out <= 0; R8_out <= 0; R9_out <= 0; R10_out <= 0; R11_out <= 0;
                    R12_out <= 0; R13_out <= 0; R14_out <= 0; R15_out <= 0; 
                end
                Reg_load1a: begin
                    Mdatain <= 32'h00000012;
                    Read = 0; MDR_enable = 0;
                    #10 Read <= 1; MDR_enable <= 1;
                    #10 Read <= 0; MDR_enable <= 0;
                end
                Reg_load1b: begin 
                    #10 MDR_out <= 1; R2_enable <= 1;
                    #10 MDR_out <= 0; R2_enable <= 0; // initialize R2 with the value 12
                end
                Reg_load2a: begin
                    Mdatain <= 32'h00000014;
                    #10 Read <= 1; MDR_enable <= 1;
                    #10 Read <= 0; MDR_enable <= 0;
                end
                Reg_load2b: begin 
                    #10 MDR_out <= 1; R3_enable <= 1;
                    #10 MDR_out <= 0; R3_enable <= 0; // initialize R3 with the value 14
                end
                Reg_load3a: begin
                    Mdatain <= 32'h00000018;
                    #10 Read <= 1; MDR_enable <= 1;
                    #10 Read <= 0; MDR_enable <= 0;
                end
                Reg_load3b: begin 
                    #10 MDR_out <= 1; R1_enable <= 1;
                    #10 MDR_out <= 0; R1_enable <= 0; // initialize R1 with the value 18
                end
                T0: begin
                    #10 PC_out <= 1; MAR_enable <= 1; Z_enable <= 1; IncPC <= 1; 
					#10 PC_out <= 0; MAR_enable <= 0; Z_enable <= 0;
                end
                T1: begin
					Mdatain <= 32'h38090000; // opcode for shr R0, R1, R2
					#10 ZLow_out <= 1; PC_enable <= 1; Read <= 1; MDR_enable <= 1;
					#10 ZLow_out <= 0; PC_enable <= 0; Read <= 0; MDR_enable <= 0; IncPC <= 0; 
                end
                T2: begin
                    #10 MDR_out <= 1; IR_enable= 1; 
					#10 MDR_out <= 0; IR_enable= 0;
                end
                T3: begin
					#10 R2_out <= 1; Y_enable= 1; 
					// #10 Y_enable = 0; R2_out <= 0; //Y_enable= 0; 
                end
                T4: begin
					#10 Y_enable = 0; R2_out <= 0; //Y_enable= 0;  //This is temp fix

                    #10 R3_out <= 1;  Z_enable <= 1; opcode <= 5'b00111; //shr R3 and Y(R2) then store in Z_enable (10110)
                end
                T5: begin
					//  #10 R3_out <= 0;  Z_enable <= 0;  ZLow_out <= 1; R1_enable <= 1;
					// #10 ZLow_out <= 0; R1_enable <= 0;
                end
            endcase
        end
endmodule