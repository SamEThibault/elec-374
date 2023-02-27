// module to generate partial product given multiplicand and i-1, i, and i+1 bits
// each partial product is 64 bits, and will be shifted to properly align it before addition
module get_partial_product( 
    output reg [63:0] res,
    input [31:0] M, 
    input [2:0] code
);
     
    always @(*) begin 
        // M*1 : add a 64-bit sign extended multiplicand
        if (code == 3'b001 || code == 3'b010) begin
            res = $signed(M);
        // M*2 : add 2* 64-bit sign extended multiplicand
        end else if (code == 3'b011) begin
            res = $signed(M) << 1;
        // M*(-2): add (-2)* 64-bit sign extended multiplicand
        end else if (code == 3'b100) begin
            res = $signed(~M+1'b1) << 1;
        // M*(-1): add (-1)* 64-bit sign extended multiplicand
        end else if (code == 3'b101 || code == 3'b110) begin
            res = $signed(~M+1'b1);
        end else begin
        // for 111 or 000 codes, add a row of 64 zeros
            res = 64'b0;
        end
    end 
endmodule


// the actual multiplication module
module mul(
    output [31:0] res_hi,
    output [31:0] res_lo,
    input [31:0] M, 
    input [31:0] Q
);
    // temp register to calculate product
    reg [63:0] res;

    // array to store 16 x 64-bit partial products (32-bit multiplier: 16 partial products)
    wire [63:0] partial_product [15:0]; 
	 
    // base case: add one 0 as LSB for first 2 LSB bits of multiplier
    get_partial_product generate_pp0(partial_product[0], M, {Q[1], Q[0], 1'b0}); 

    genvar i;
    generate
        for (i = 1; i < 16; i = i + 1) 
        begin : get_partial_products
            get_partial_product generate_pp(partial_product[i], M, Q[(i*2+1):(i*2-1)]);
        end
    endgenerate

    // shift and sum up all generated partial products
	integer j;
    always @(*) 
    begin
	    res = 63'b0; // start result @ 0
        for (j = 0; j < 16; j = j + 1) 
        begin
            // shift each partial product by 2 to align them properly
            res = res + (partial_product[j] << (j * 2));
        end
    end

    assign res_hi = res[63:32];
    assign res_lo = res[31:0];
endmodule