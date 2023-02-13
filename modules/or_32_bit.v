module or_32_bit(
    output reg[31:0] Rz,
    input wire[31:0] Ra,
    input wire[31:0] Rb
);

always@(*)
begin
    Rz = Rb | Ra; //Bitwise OR bits
end
endmodule