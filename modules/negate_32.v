
module negate_32_bit(
	output wire [31:0] Rz
	input reg [31:0] Ra,
	);
	
	wire [31:0] not_out;
	wire cout;
	
	not notGate(Ra,negOutput); //We flip all the bits 
	// full_adder fullAdderGate(temp, 32'd1, 1'd0,Rz, cout); //Then add 1
	full_adder fullAdderGate(Rz, cout, 32'h00000000, not_out, 32'h00000001); //Then add 1
	
endmodule