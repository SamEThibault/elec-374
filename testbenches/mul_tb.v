`timescale 1ns/10ps
module mul_tb(input a, output b);
	
    wire[31:0] res_HI;
	 wire[31:0] res_LO;
    reg[31:0] M;
    reg[31:0] Q;

    mul mul_test(res_HI, res_LO, M, Q);

	initial
		begin
            // should be 0000 0000
            M = 32'h00000001;
            Q = 32'h00000000;
            #20
            // should be 1111 1111
            M = 32'h00000001;
            Q = 32'h11111111;
            #20
            // should be 2000 0000
            M = 32'h00000002;
            Q = 32'h10000000;
		end
endmodule