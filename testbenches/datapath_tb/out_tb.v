`timescale 1ns/10ps
module out_tb; //Add name of test bench here.
    reg PC_out, ZLow_out, ZHigh_out, HI_out, LO_out, C_out, in_port_out; 
    wire [31:0] MDR_data_out;
    reg MDR_out;
    reg MAR_enable, Z_enable, PC_enable, MDR_enable, IR_enable, Y_enable;
    reg IncPC, Read;
    reg [4:0] opcode;
    reg Clock, clr;
    wire [31:0] Mdatain;

    //Phase 2 Shiz
    reg con_in, in_port_in, BA_out,Gra, Grb, Grc, out_port_enable, R_in, R_out;
    reg RAM_write_enable;

    parameter Default = 4'b0000, Reg_load1a = 4'b0001, Reg_load1b = 4'b0010, Reg_load2a = 4'b0011,
    Reg_load2b = 4'b0100, Reg_load3a = 4'b0101, Reg_load3b = 4'b0110, T0 = 4'b0111,
    T1 = 4'b1000, T2 = 4'b1001, T3 = 4'b1010, T4 = 4'b1011, T5 = 4'b1100, T6= 4'b1101, T7= 4'b1110;
    reg [3:0] Present_state = Default;

    Datapath DUT(
.PC_out(PC_out),
     .MDR_data_out(MDR_data_out), 
     .ZHigh_out(ZHigh_out),
	 .ZLow_out(ZLow_out), 
	 .MDR_out(MDR_out),
     .HI_out(HI_out),
     .LO_out(LO_out),
     .C_out(C_out),
     .in_port_out(in_port_out),
	  .MDR_enable(MDR_enable), 
     .MAR_enable(MAR_enable), 
	  .Z_enable(Z_enable), 
	 .Y_enable(Y_enable), 
	 .PC_enable(PC_enable), 
     .Read(Read), 
	 .IncPC(IncPC), 
	 .clk(Clock), 
     .clr(clr),
	 .opcode(opcode), 

     //Phase Two Inputs
     .con_in(con_in),
     .out_port_enable(out_port_enable),
     .RAM_write_enable(RAM_write_enable),
     .Gra(Gra), 
     .Grb(Grb),
     .Grc(Grc),
     .R_in(R_in),
     .R_out(R_out),
     .BA_out(BA_out),
     .IR_enable(IR_enable),
     .Mdatain(Mdatain),
     .in_port_enable(in_port_enable)
    );

    initial
        begin
            Clock = 0;
            forever #10 Clock = ~ Clock;
        end

    always @(posedge Clock) // finite state machine; if clock rising-edge
        begin
            case (Present_state)
                Default : Present_state = T0;
                T0 : Present_state = T1;
                T1 : #40 Present_state = T2;
                T2 : #40 Present_state = T3;
            endcase
        end

always @(Present_state) // do the required job in each state
        begin
            case (Present_state) // assert the required signals in each clock cycle
                Default: begin
                    PC_out <= 0; ZLow_out <= 0; clr<=0;
                    MAR_enable <= 0; Z_enable <= 0;
                    PC_enable <=0; MDR_enable <= 0; IR_enable= 0; Y_enable= 0;
                    IncPC <= 0; Read <= 0; opcode <= 0;
                    ZHigh_out <= 0; HI_out <= 0; LO_out <= 0; C_out <= 0; in_port_out <= 0;
                    MDR_out <= 0;

                    // Phase 2 Initialization process for signals
                    Gra <= 0; Grb<= 0; Grc<=0; BA_out <=0; RAM_write_enable <=0; out_port_enable <=0; 
                    in_port_in <=0; con_in<=0; R_out <= 0; R_in <=0;
                end
                // ----------------------------------- T0 INSTRUCTION FETCH ----------------------------------- // 
                T0: begin
                    PC_out <= 1;  
                end
                // ----------------------------------- T1 INSTRUCTION FETCH ----------------------------------- // 
                T1: begin
                    MAR_enable <= 1; 

                     //Instruction to fetch from RAM to store the data into MDR.
                    Read <= 1;
                    MDR_enable <= 1; 
                end
                // ----------------------------------- T2 INSTRUCTION FETCH ----------------------------------- // 
                T2: begin
                    PC_enable <= 1;
                    IncPC <= 1;
					PC_out <= 0; MAR_enable <= 0; IncPC <= 0; PC_enable <= 0;
                    MDR_enable <= 0;

                    //Puts the RAM memory data into the IR register via the busmuxout
                    MDR_out <= 1; IR_enable <= 1;
                end
            //     // ----------------------------------- T3 CYCLE OPERATION ----------------------------------- // 
                T3: begin
                    MDR_out <= 0; IR_enable <= 0;
                    Gra <= 1; R_out <= 1; 
                    out_port_enable <= 1;
                end 

            endcase
        end
endmodule