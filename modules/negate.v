
module negate_32_bit(
	input wire [31:0] Ra,
	output wire [31:0] Rz
	);
	
	wire [31:0] negOutput;
	wire cout;
	not notResult(Ra,negOutput);
	add negResult(temp, 32'd1, 1'd0,Rz, cout);
	
endmodule