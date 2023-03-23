`timescale 1ns/10ps
module load_immediate_tb; //Add name of test bench here.
    reg PC_out, ZLow_out, ZHigh_out, HI_out, LO_out, C_out, In_port_out; 
    reg [31:0] MDR_out;
    reg MAR_enable, Z_enable, PC_enable, MDR_enable, IR_enable, Y_enable;
    reg IncPC, Read;
    reg [4:0] opcode;
    reg Clock, clr;
    reg [31:0] Mdatain;

    //Phase 2 Shiz
    reg con_in, in_port_in, BA_out,Gra, Grb, Grc, out_port_enable, R_in, R_out;
    reg RAM_write_enable;

    parameter Default = 4'b0000, Reg_load1a = 4'b0001, Reg_load1b = 4'b0010, Reg_load2a = 4'b0011,
    Reg_load2b = 4'b0100, Reg_load3a = 4'b0101, Reg_load3b = 4'b0110, T0 = 4'b0111,
    T1 = 4'b1000, T2 = 4'b1001, T3 = 4'b1010, T4 = 4'b1011, T5 = 4'b1100, T6= 4'b1101, T7= 4'b1110;
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
     .in_port_in(in_port_in),
     .out_port_enable(out_port_enable),
     .RAM_write_enable(RAM_write_enable),
     .Gra(Gra), 
     .Grb(Grb),
     .Grc(Grc),
     .R_in(R_in),
     .R_out(R_out),
     .BA_out(BA_out),
     .IR_enable(IR_enable)
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
                    PC_out <= 0; ZLow_out <= 0; MDR_out <= 0; clr<=0;
                    MAR_enable <= 0; Z_enable <= 0;
                    PC_enable <=0; MDR_enable <= 0; IR_enable= 0; Y_enable= 0;
                    IncPC <= 0; Read <= 0; opcode <= 0;
                     Mdatain <= 32'h00000000;
                    ZHigh_out <= 0; HI_out <= 0; LO_out <= 0; C_out <= 0; In_port_out <= 0;

                    // Phase 2 Initialization process for signals
                    Gra <= 0; Grb<= 0; Grc<=0; BA_out <=0; RAM_write_enable <=0; out_port_enable <=0; in_port_in <=0; con_in<=0; R_out <= 0; R_in <=0;
                end
                // ----------------------------------- LOADING DATA INTO REGISTER R2 ----------------------------------- // 
                Reg_load1a: begin 
                    // Mdatain <= 32'h00000000; //INPUT
                    Read = 0; MDR_enable = 0;
                    #10 Read <= 1; MDR_enable <= 1;
                    #10 Read <= 0; MDR_enable <= 0;
                end
                Reg_load1b: begin 
                    #10 MDR_out <= 1; 
                    #10 MDR_out <= 0; 
                end
                // ----------------------------------- LOADING DATA INTO REGISTER R3 ----------------------------------- // 
                Reg_load2a: begin
                    // Mdatain <= 32'h00000000; //INPUT
                    #10 Read <= 1; MDR_enable <= 1;
                    #10 Read <= 0; MDR_enable <= 0;
                end
                Reg_load2b: begin 
                    #10 MDR_out <= 1; 
                    #10 MDR_out <= 0; 
                end
                // ----------------------------------- LOADING DATA INTO REGISTER R1 ----------------------------------- // 
                Reg_load3a: begin
                    // Mdatain <= 32'h00000000; //INPUT
                    #10 Read <= 1; MDR_enable <= 1;
                    #10 Read <= 0; MDR_enable <= 0;
                end
                Reg_load3b: begin 
                    #10 MDR_out <= 1; 
                    #10 MDR_out <= 0; 
                end 
                // ----------------------------------- T0 INSTRUCTION FETCH ----------------------------------- // 
                T0: begin
                    #10 PC_out <= 1; MAR_enable <= 1; IncPC <= 1; PC_enable <= 1;  
					#10 PC_out <= 0; MAR_enable <= 0; IncPC <= 0; PC_enable <= 0;
                end
                // ----------------------------------- T1 INSTRUCTION FETCH ----------------------------------- // 
                T1: begin
                     //Instruction to fetch from RAM to store the data into MDR.
                    #10 Read <= 1;
                    #10 MDR_enable <= 1; 
                    // #10 MDR_enable <= 0; //Keep this commented out 
                end
                // ----------------------------------- T2 INSTRUCTION FETCH ----------------------------------- // 
                T2: begin
                    //Puts the RAM memory data into the IR register via the busmuxout
                    #10 MDR_out <= 1; IR_enable <= 1;
                    #10 MDR_out <= 0; IR_enable <= 0;
                end
                // ----------------------------------- T3 CYCLE OPERATION ----------------------------------- // 
                T3: begin
                    //Disecting the IR register to grab the Rb register as well as triggering the corresponding register (eg R_out register to send data to the bus)
                    //Where register Y of the alu would store that value.
                    #10 Grb <= 1; BA_out <= 1; Y_enable <= 1; 
                    #10 Grb <= 0; BA_out <= 0; Y_enable <= 0;
                end
                // ----------------------------------- T4 CYCLE OPERATION ----------------------------------- // 
                T4: begin
                    //Here is where the immediate value is loaded onto the bus to be ready for the ALU add operation to find the effective address
                    #10 C_out<= 1; Z_enable <= 1; opcode <= 5'b00011; //ADD OPCODE
                    #10 C_out<= 0; Z_enable <= 0; 

                end
                 // ----------------------------------- T5 CYCLE OPERATION ----------------------------------- // 
                T5: begin

                    // Notes ZLow out is the effective address we are looking into the ram for the data.
                    //Storing the immediate value/effective address(case3) into Ra register by enabling R_in and enabling Gra in the select and encode logic
                    #10 ZLow_out <= 1; Gra<= 1; R_in <=1; //Sending it back to MAR to get the effective memory address
                    #10 ZLow_out <= 0; Gra<= 0; R_in <=0;

                end

            endcase
        end
endmodule
