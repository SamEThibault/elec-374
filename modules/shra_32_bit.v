module shra_32_bit(
    output reg signed[31:0] Rz,
    input wire signed[31:0] Ra,
    input wire signed[31:0] ShiftBits
);

always@(*) 
begin
    Rz = (Ra >>> ShiftBits);
end
endmodule