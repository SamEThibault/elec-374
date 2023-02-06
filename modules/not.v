
module not(
	output wire [31:0] Rz
	input wire [31:0] Ra,
	);
	
	integer i;
			assign Rz[i] = ~Ra[i];
endmodule