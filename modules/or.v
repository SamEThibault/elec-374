
module not(
    output wire[31:0] RZ
    input wire[31:0] Ra,
    input wire[31:0] Rb, 
	);
	
	integer i;
			assign Rz[i]  = Rb[i] | Ra[i];
endmodule