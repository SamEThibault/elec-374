`timescale 1ns/10ps
module not_tb(input a, output b);
	
    wire[31:0] Rz;
    reg[31:0] Ra;

    not_32_bit notGate(Rz, Ra);

	initial
		begin
            // Negate Ra and store it in Rz = h'00000000
            Ra = 32'hFFFFFFFF;

            //Delay 20ns, then negate Ra and output to Rz = h'FFFFFFFFF
            #20 
            Ra = 32'h00000000; 
		end
endmodule