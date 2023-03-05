`timescale 1ns/10ps
module not_tb;
    reg PCout, Zlowout, Zhighout, HIout, LOout, C_out, Rout, InPortout; 
    reg R0out, R1out, R2out, R3out, R4out, R5out;
    reg R6out, R7out, R8out, R9out, R10out, R11out;
    reg R12out, R13out, R14out, R15out;
    reg [31:0] MDRout;
    reg MARin, Zin, PCin, MDRin, IRin, Yin;
    reg IncPC, Read;
    reg R0in, R1in, R2in, R3in, R4in, R5in;
    reg R6in, R7in, R8in, R9in, R10in, R11in;
    reg R12in, R13in, R14in, R15in;
    reg [4:0] opcode;
    reg Clock;
    reg [31:0] Mdatain;

    parameter Default = 4'b0000, Reg_load1a = 4'b0001, Reg_load1b = 4'b0010, Reg_load2a = 4'b0011,
    Reg_load2b = 4'b0100, Reg_load3a = 4'b0101, Reg_load3b = 4'b0110, T0 = 4'b0111,
    T1 = 4'b1000, T2 = 4'b1001, T3 = 4'b1010, T4 = 4'b1011, T5 = 4'b1100;
    reg [3:0] Present_state = Default;

    Datapath DUT(
	 .PCout(PCout), 
     .Zhighout(Zhighout),
	 .Zlowout(Zlowout), 
	 .MDRout(MDRout),
     .HIout(HIout),
     .LOout(LOout),
     .C_out(C_out),
     .InPortout(InPortout),
     .Rout(Rout),
     .R0out(R0out),
     .R1out(R1out),
	 .R2out(R2out),
     .R3out(R3out),
     .R4out(R4out),
     .R5out(R5out),
     .R6out(R6out), 
     .R7out(R7out),
     .R8out(R8out),
     .R9out(R9out),
     .R10out(R10out),
     .R11out(R11out),
	 .R12out(R12out), 
     .R13out(R13out), 
     .R14out(R14out), 
     .R15out(R15out), 
     .MARin(MARin), 
	 .Zin(Zin), 
	 .PCin(PCin), 
	 .MDRin(MDRin), 
	 .IRin(IRin), 
	 .Yin(Yin), 
	 .IncPC(IncPC), 
    .Read(Read), 
	 .opcode(opcode), 
     .R0in(R0in), 
	 .R1in(R1in), 
	 .R2in(R2in), 
	 .R3in(R3in), 
     .R4in(R4in), 
	 .R5in(R5in), 
	 .R6in(R6in), 
     .R7in(R7in), 
	 .R8in(R8in), 
	 .R9in(R9in), 
     .R10in(R10in), 
	 .R11in(R11in), 
	 .R12in(R12in), 
     .R13in(R13in), 
	 .R14in(R14in), 
	 .R15in(R15in), 
	 .clk(Clock), 
	 .Mdatain(Mdatain)
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
                    PCout <= 0; Zlowout <= 0; MDRout <= 0; // initialize the signals
                    MARin <= 0; Zin <= 0;
                    PCin <=0; MDRin <= 0; IRin <= 0; Yin <= 0;
                    IncPC <= 0; Read <= 0; opcode <= 0;
                    R0in <= 0; R4in <= 0; R5in <= 0; Mdatain <= 32'h00000000;
                    Zhighout <= 0; HIout <= 0; LOout <= 0; C_out <= 0; InPortout <= 0;
                    
                    //Out Registers
                    R0out <= 0; R1out <= 0; R2out <= 0; R3out <= 0; R4out <= 0; R5out <= 0;
                    R6out <= 0; R7out <= 0; R8out <= 0; R9out <= 0; R10out <= 0; R11out <= 0;
                    R12out <= 0; R13out <= 0; R14out <= 0; R15out <= 0; 
                end
                Reg_load1a: begin
                    Mdatain <= 32'h00000000; 
                    Read = 0; MDRin = 0; // the first zero is there for completeness
                    #10 Read <= 1; MDRin <= 1;
                    #10 Read <= 0; MDRin <= 0;
                end
                Reg_load1b: begin 
                    #10 MDRout <= 1; R4in <= 1;
                    #10 MDRout <= 0; R4in <= 0; 
                end
                T0: begin // see if you need to de-assert these signals
                          #10 PCout <= 1; MARin <= 1; Zin <= 1; IncPC <= 1;
						  #10 PCout <= 0; MARin <= 0; Zin <= 0;
                end
                T1: begin
						Mdatain <= 32'h90080000; // opcode for not R0, R1
						#10 Zlowout <= 1; PCin <= 1; Read <= 1; MDRin <= 1;
						#10 Zlowout <= 0; PCin <= 0; Read <= 0; MDRin <= 0; IncPC <= 0;
                end
                T2: begin
                         #10 MDRout <= 1; IRin <= 1;
						 #10 MDRout <= 0; IRin <= 0;
                end
                T3: begin
						  #10 R4out <= 1; Yin <= 1;
						  #10 R4out <= 0; Yin <= 0;
                end
                T4: begin
                          #10 R5out <= 1; Zin <= 1; opcode <= 5'b10010;  
						  #10 R5out <= 0; Zin <= 0;
                end
                T5: begin
                          #10 Zlowout <= 1; R0in <= 1; //Store first 32 bits of Z in R0
						  #10 Zlowout <= 0; R0in <= 0;
                end
            endcase
        end
endmodule