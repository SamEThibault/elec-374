module sub_32_bit(
    output wire[31:0] Rz,
    input wire[31:0] Ra,
    input wire[31:0] Rb 
);

wire [31:0] neg_out;
wire [31:0] c_out;
negate_32_bit negResult(neg_out, Rb);
add_32_bit addResult(c_out, Rz, Ra, neg_out, 1'b0);
endmodule