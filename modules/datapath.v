module Datapath(
input PCout, Zhighout, Zlowout, HIout, LOout, InPortout, C_out,
input [31:0] MDRout, Mdatain,
input Rin, Rout, Gra, Grb, Grc, BAout, Cout, MDRin, MARin,
input Zin, Yin, IRin, PCin, CONin, LOin, HIin, Read, clr, clk,
input InPort, IncPC,
input [4:0] opcode,
input R0out, R1out, R2out, R3out, R4out, 
input R5out, R6out, R7out, R8out, R9out, 
input R10out, R11out, R12out, R13out, R14out, R15out,
input R0in, R1in, R2in, R3in, R4in, 
input R5in, R6in, R7in, R8in, R9in, 
input R10in, R11in, R12in, R13in, R14in, R15in
);

	//General wires
	wire [31:0] R0dataout;
	wire [31:0] R1dataout;
	wire [31:0] R2dataout;
	wire [31:0] R3dataout;
	wire [31:0] R4dataout;
	wire [31:0] R5dataout;
	wire [31:0] R6dataout;
	wire [31:0] R7dataout;
	wire [31:0] R8dataout;
	wire [31:0] R9dataout;
	wire [31:0] R10dataout;
	wire [31:0] R11dataout;
	wire [31:0] R12dataout;
	wire [31:0] R13dataout;
	wire [31:0] R14dataout;
	wire [31:0] R15dataout;
	
	//Special wires
    wire [31:0] HIdataout; 
	wire [31:0] LOdataout; 
	wire [31:0] MuxOut;
	wire [31:0] Ydataout;
	wire [31:0] PCdataout;
	wire [31:0] IRdataout;
	wire [31:0] MARdataout;
	wire [31:0] MDRdataout; 	
	wire [31:0] Zlowdataout; 
	wire [31:0] Zhighdataout; 
    wire [31:0] InPortdataout;
    wire [31:0] CSignExtendeddataout;
	wire [31:0] PCdata;
	
	//MDR wires
	wire [31:0] BusMuxOut;
    //wire [31:0] Mdatain; 
	
	//Encoder signal
	wire [4:0] BusEncoderOut;

	wire[63:0] CDataout;
	
	//General registers
	bit32reg R0(clr, clk, R0in, MuxOut, R0dataout);
	bit32reg R1(clr, clk, R1in, MuxOut, R1dataout);
	bit32reg R2(clr, clk, R2in, MuxOut, R2dataout);
	bit32reg R3(clr, clk, R3in, MuxOut, R3dataout);
	bit32reg R4(clr, clk, R4in, MuxOut, R4dataout);
	bit32reg R5(clr, clk, R5in, MuxOut, R5dataout);
	bit32reg R6(clr, clk, R6in, MuxOut, R6dataout);
	bit32reg R7(clr, clk, R7in, MuxOut, R7dataout);
	bit32reg R8(clr, clk, R8in, MuxOut, R8dataout);
	bit32reg R9(clr, clk, R9in, MuxOut, R9dataout);
	bit32reg R10(clr, clk, R10in, MuxOut, R10dataout);
	bit32reg R11(clr, clk, R11in, MuxOut, R11dataout);
	bit32reg R12(clr, clk, R12in, MuxOut, R12dataout);
	bit32reg R13(clr, clk, R13in, MuxOut, R13dataout);
	bit32reg R14(clr, clk, R14in, MuxOut, R14dataout);
	bit32reg R15(clr, clk, R15in, MuxOut, R15dataout);

	// Special registers
    bit32reg HI(clr, clk, HIin, MuxOut, HIdataout);
	bit32reg LO(clr, clk, LOin, MuxOut, LOdataout);
	bit32reg Y(clr, clk, Yin, MuxOut, Ydataout);
	bit32reg IR(clr, clk, IRin, MuxOut, IRdataout);
	bit32reg MAR(clr, clk, MARin, MuxOut, MARdataout);

	pc_reg PC(clk, IncPC, PCin, MuxOut, PCdataout);
	z_reg Z_reg(CDataout, Zlowout, Zhighout, clr, clk, Zin, Zlowdataout, Zhighdataout);
	MDR MDR_reg(MuxOut, Mdatain, Read, clr, clk, MDRin, MDRdataout);

	encoder_32to5 BusEncoder({{8{1'b0}} ,C_out, InPortout,MDRout,PCout,Zlowout,
	Zhighout,LOout,HIout, R15out, R14out, R13out,R12out, R11out, R10out, R9out, 
	R8out, R7out, R6out, R5out, R4out, R3out, R2out, R1out, R0out}, BusEncoderOut);
	mux_32to1 BusMux(
        R0dataout, 
        R1dataout, 
        R2dataout, 
        R3dataout, 
        R4dataout, 
	    R5dataout, 
        R6dataout, 
        R7dataout, 
        R8dataout, 
        R9dataout, 
        R10dataout, 
        R11dataout, 
	    R12dataout, 
        R13dataout, 
        R14dataout, 
        R15dataout, 
        HIdataout, 
        LOdataout, 
        Zhighdataout, 
        Zlowdataout, 
	    PCdataout, 
        MDRdataout, //Output from MDR
        InPortdataout, 
        CSignExtendeddataout, 
		MuxOut, //Output
        BusEncoderOut //Signal from encoder 32to5
        );
	
	ALU alu_path(Ydataout, MuxOut, opcode, CDataout);
endmodule