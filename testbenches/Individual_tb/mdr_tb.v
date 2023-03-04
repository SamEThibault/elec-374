`timescale 1ns/10ps
module mdr_tb(input a, output b);
	
    wire[31:0] MDRdataout;
    reg[31:0] BusMuxOut;
    reg[31:0] Mdatain;
    reg read_signal, clr, clk, enable;
    mdr mdr_test(MDRdataout, BusMuxOut, Mdatain, read_signal, clk, clr, enable);

initial
		begin
            clk = 1;
            enable = 1;
            clr = 0;
            BusMuxOut = 32'hFFFFFFFF;
            Mdatain = 32'h88888888;
            read_signal = 1'b1;
		end
endmodule