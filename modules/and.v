module and_32_bit(
    input[31:0] Ra,
    input[31:0] Rb, 
    output reg[31:0] Rz
);

// genvar i;
always@(*) 
begin
            // for(i=0; i<32; i= i+1) begin: loop
            //     assign Rz[i] = ((Ra[i]) & (rb[i]));
            // end
    Rz = Ra & Rb;
end
endmodule