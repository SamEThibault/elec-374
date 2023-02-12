
module not(
    output wire[31:0] Rz
    input wire[31:0] Ra,
    input wire[31:0] Rb, 
	);
			assign Rz  = Rb | Ra;
endmodule