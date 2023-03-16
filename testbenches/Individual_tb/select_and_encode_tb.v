`timescale 1ns/10ps
module select_and_encode_tb(input a, output b);
	
wire [15:0] R_enables; 
wire [15:0] R_outs; 
reg R_in;
wire [31:0] C_sign_extended_out; 
reg Gra, Grb, Grc;
reg R_out, BA_out;
reg [31:0] IR;

// select_and_encode select_and_encode_test(C_sign_extended_out, 
// R_enables, R_outs, input Gra, Grb, Grc, R_in, R_out, BA_out);
select_and_encode select_and_encode_test(C_sign_extended_out, R_enables, R_outs, Gra, Grb, Grc, R_in, R_out, BA_out, IR);

	initial
		begin
            Gra = 1'b1;
            Grb = 0;
            Grc = 0;
            R_in = 1;
            R_out = 1'b0;
            BA_out = 1'b0;    
            R_in = 1'b1;
            IR = 32'b00000101000000000000000000000000;
            // IR = 32'b0000 1000 0000 0000 0000 0000 0000 0000;
		end
endmodule
 