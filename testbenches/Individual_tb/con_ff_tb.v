`timescale 1ns/10ps
module con_ff_tb(input a, output b);
	
    reg [31:0] bus_in;
    reg [1:0] IR;
    reg con_in;
    wire con_out;

    con_ff con_test(con_out, IR, bus_in, con_in);

	initial
		begin
            // shouldn't do anything since con_in = 0
            con_in = 1'b0;
            IR = 2'b00;
            bus_in = 32'h00000000;
            
            #20
            con_in = 1'b1;      // = 0, D = 1

            #20
            IR = 2'b01;         // != 0, D = 0

            #20
            bus_in = 32'hFFFFFFFF; // != 0, D = 1

            #20
            IR = 2'b10;
            bus_in = 32'h00000000; // >= 0, D = 1

            #20
            IR = 2'b11;
            bus_in = 32'hFFFFFFFF; // < 0, D = 1

            #20
            con_in = 1'b0;

            #20
            bus_in = 32'h00000000;
            IR = 2'b01;     // D should be 0, but since con_in = 0, D = 1

		end
endmodule