module and_32_bit(
    input wire[31:0] Ra,
    input wire[31:0] Rb, 
    output reg[31:0] Rz
);

always@(*) 
begin
    Rz = Ra & Rb; //Bitwise AND bits 
end
endmodule