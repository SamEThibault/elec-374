`timescale 1ns/10ps
module mul_tb(input a, input b);
    wire [63:0] res;
    reg [31:0] M;
    reg [31:0] Q;

    mul mul_test(res, M, Q);

    initial begin
        // should be 1111 1111
        M = 32'h00000001;
        Q = 32'hFFFFFFFF;
        #20;
        $display("M = %h, Q = %h, res = %h", M, Q, res);

        // should be 0
        M = 32'h00000000;
        Q = 32'h10000000;
        #20;
        $display("M = %h, Q = %h, res = %h", M, Q, res);

        // should be 0000 0002
        M = 32'h00000002;
        Q = 32'h00000001;
        #20;
        $display("M = %h, Q = %h, res = %h", M, Q, res);
    end
endmodule
