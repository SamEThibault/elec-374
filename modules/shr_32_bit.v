module shr_32_bit(
    output reg[31:0] Rz,
    input wire[31:0] Ra,
    input wire[31:0] ShiftBits
);

always@(*) 
begin
    Rz = Ra >> ShiftBits;
end
endmodule