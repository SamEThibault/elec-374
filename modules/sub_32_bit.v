module sub_32_bit(
    output wire[31:0] c_out,
    output wire[31:0] s_out,
    input wire[31:0] Ra,
    input wire[31:0] Rb 
);

wire [31:0] neg_out;
negate_32_bit negResult(neg_out, Rb);
add_32_bit addResult(c_out, s_out, Ra, neg_out, 1'b0);
endmodule