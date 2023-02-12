
module not(
	output wire [31:0] Rz
	input wire [31:0] Ra,
	);
			assign Rz = ~Ra;
endmodule