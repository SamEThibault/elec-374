`timescale 1ns/10ps
module rol_32_bit_tb(input a, output b);
	
    wire[31:0] Rz;
    reg [31:0] Ra;
    

    rol_32_bit rolTest(Rz, Ra, 32'b10);

	initial
		begin
            
            Ra = 32'h1FFFFFFF;
            #20
            Ra = 32'h00000002;
		end
endmodule