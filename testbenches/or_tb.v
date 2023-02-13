`timescale 1ns/10ps
module or_tb(input a, output b);
	
    reg[31:0] Ra;
    reg[31:0] Rb;
    wire[31:0] Rz;

    or_32_bit orGate(Rz, Ra, Rb);

	initial
		begin
            // OR Ra and Rb and store it in Rz = h'00000000
            Ra = 32'hFFFFFFFF;
            Rb = 32'h00000000;

            //Delay 20ns, then negate Ra and output to Rz = h'88888889
            #20 
            Ra = 32'h88888888;
            Rb = 32'h00000001;
		end
endmodule