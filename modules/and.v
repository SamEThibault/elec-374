module and_32_bit(
    output reg[31:0] Rz
    input wire[31:0] Ra,
    input wire[31:0] Rb, 
);

always@(*) 
begin
    Rz = Ra & Rb; //Bitwise AND bits 
end
endmodule