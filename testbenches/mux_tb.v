`timescale 1ns/10ps
module mux_tb(input a, output b);
	
    wire[31:0] out;
    reg[31:0] input_1;
    reg[31:0] input_2;
    reg signal;
    mux_2_to_1 mux_test(out, input_1, input_2, signal);

initial
		begin
            input_1 = 32'hFFFFFFFF;
            input_2 = 32'h88888888;
            signal = 1;
            #20
            signal = 0;
		end
endmodule