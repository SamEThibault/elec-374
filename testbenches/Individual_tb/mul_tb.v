`timescale 1ns/10ps
module mul_tb(input a, input b);
    wire [31:0] res_hi;
	 wire [31:0] res_lo;
    reg [31:0] M;
    reg [31:0] Q;

    mul mul_test(res_hi, res_lo, M, Q);

    initial begin
		  // should be 4
        M = 32'h00000002;
        Q = 32'h00000002;
        #20;

		  // should be 2
        M = 32'hFFFFFFFF;
        Q = 32'hFFFFFFFE;
        #20;
    end
endmodule
