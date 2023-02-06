module and_32_bit(
    input wire[31:0] Ra,
    input wire[31:0] Rb, 
    output wire[31:0] RZ
)

    genvar i;

    generate
            for(i=0; i<32; i= i+1) begin: loop
                assign Rz[i] = ((Ra[i]) & (rb[i]));
            end
    endgenerate

endmodule