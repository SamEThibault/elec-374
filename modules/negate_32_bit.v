
module negate_32_bit(
	output wire [31:0] Rz,
	input wire [31:0] Ra
	);
	
	wire [31:0] not_out;
	wire cout;
	
	not_32_bit notGate(not_out, Ra); //We flip all the bits 
	add_32_bit add32(cout, Rz, 32'h00000000, not_out, 32'h00000001); //Then add 1
	
endmodule