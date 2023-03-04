`timescale 1ns/10ps
module encoder_32_to_5_tb(input a, output b);
	
    wire[4:0] enc_output;
    reg [31:0] enc_input;
    encoder_32_to_5 encoder_test(enc_output, enc_input);

initial
		begin
            enc_input = 32'h00000001; 
            #20         
            enc_input = 32'h00000002; 
            #20
            enc_input = 32'h00000004; 
            #20
            enc_input = 32'h00000008;
            #20 
            enc_input = 32'h00000010;
            #20 
            enc_input = 32'h00000020;
            #20 
            enc_input = 32'h00000040;
            #20 
            enc_input = 32'h00000080;
            #20 
            enc_input = 32'h00000100;
            #20 
            enc_input = 32'h00000200;
            #20 
            enc_input = 32'h00000400;
            #20 
            enc_input = 32'h00000800;
            #20 
            enc_input = 32'h00001000;
            #20 
            enc_input = 32'h00002000;
            #20 
            enc_input = 32'h00004000;
            #20 
            enc_input = 32'h00008000;
            #20 
            enc_input = 32'h00010000;
            #20 
            enc_input = 32'h00020000;
            #20 
            enc_input = 32'h00040000;
            #20 
            enc_input = 32'h00080000;
            #20 
            enc_input = 32'h00100000;
            #20 
            enc_input = 32'h00200000;
            #20 
            enc_input = 32'h00400000;
            #20 
            enc_input = 32'h00800000;
            #20 
            enc_input = 32'h01000000;
            #20 
            enc_input = 32'h02000000;
            #20 
            enc_input = 32'h04000000;
            #20 
            enc_input = 32'h08000000;
            #20 
            enc_input = 32'h10000000;
            #20 
            enc_input = 32'h20000000;
            #20 
            enc_input = 32'h40000000;
            #20 
            enc_input = 32'h80000000;
		end
endmodule