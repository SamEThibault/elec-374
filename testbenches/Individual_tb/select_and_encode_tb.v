`timescale 1ns/10ps
module select_and_encode_tb(input a, output b);
	
wire R_enables; 
wire R_outs; 
reg R_in;
wire C_sign_extended_out; 
reg Gra, Grb, Grc;
reg R_out, BA_out;
reg [31:0] IR;
reg [3:0] decoder_input;

// select_and_encode select_and_encode_test(C_sign_extended_out, 
// R_enables, R_outs, input Gra, Grb, Grc, R_in, R_out, BA_out);
select_and_encode select_and_encode_test(C_sign_extended_out, R_enables, R_outs, Gra, Grb, Grc, R_in, R_out, BA_out, IR);

	initial
		begin
            Gra = 0;
            Grb = 0;
            Grc = 0;
            R_in = 1;
            R_out = 1'b1;
            BA_out = 1'b0;    
            IR = 32'h00000000;
            decoder_input = 4'b0000;
            R_in = 1'b1;
		end
endmodule
 