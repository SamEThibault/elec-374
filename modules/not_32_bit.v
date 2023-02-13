
module not_32_bit(
	output reg [31:0] Rz,
	input wire [31:0] Ra
);

always@(*)
begin
	Rz = ~Ra; //Bitwise NOT bits
end
endmodule