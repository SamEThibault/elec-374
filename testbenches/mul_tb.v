`timescale 1ns/10ps
module mul_tb(input a, input b);
    wire [63:0] res;
    reg [31:0] M;
    reg [31:0] Q;

    mul mul_test(res, M, Q);

    initial begin
        M = 32'h00000002;
        Q = 32'h00000002;
        #20;
        $display("M = %h, Q = %h, res = %h", M, Q, res);

        // should be 0
        M = 32'h00000000;
        Q = 32'h10000000;
        #20;
        $display("M = %h, Q = %h, res = %h", M, Q, res);
    end
endmodule
