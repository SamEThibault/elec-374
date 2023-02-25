//module to get M partial product given the 32-bit multiplicand and the current code
module get_partial_product(
    input [31:0] M,
    input [2:0] code,
    output reg [63:0] res
);

    always @(*) begin
        case (code)
            3'b000: res = 64'b0;                            // M * 0
            3'b111: res = 64'b0;

            3'b001: res = $signed(M);                       // M * 1
            3'b010: res = $signed(M);

            3'b011: res = $signed(M) <<< 1;                 // M * 2

            3'b100:                                         // M * -2
            begin
                res = $signed(M);
                res = $signed(~res + 1'b1);   
                res = $signed(res) <<< 1;                   
				end
            3'b101: res = (~$signed(M)) + 1'b1;             // M * -1
            3'b110: res = (~$signed(M)) + 1'b1;
        endcase
    end
endmodule


// the actual multiplication module
module mul(
    output [63:0] res,
    input signed [31:0] M, 
    input signed [31:0] Q
);
    
    // array of 16 x 64-bit partial products
    wire [63:0] partial_product [15:0];

    // // base case
    // get_partial_product pp_base_call(partial_product[0], M, {Q[1], Q[0], 1'b0});

    // genvar i;
    // generate
    //     for (i = 1; i < 16; i = i + 1) begin : get_partial_products
    //         get_partial_product pp_call(partial_product[i], M, {Q[i+1], Q[i], Q[i-1]});
    //     end
    // endgenerate

    get_partial_product p0(M,{Q[1:0],1'b0},partial_product[0]); 
    get_partial_product p1(M,Q[3:1],partial_product[1]); 
    get_partial_product p2(M,Q[5:3],partial_product[2]); 
    get_partial_product p3(M,Q[7:5],partial_product[3]); 
	 get_partial_product p4(M,Q[9:7],partial_product[4]); 
	 get_partial_product p5(M,Q[11:9],partial_product[5]);
	 get_partial_product p6(M,Q[13:11],partial_product[6]); 
	 get_partial_product p7(M,Q[15:13],partial_product[7]); 
	 get_partial_product p8(M,Q[17:15],partial_product[8]); 
	 get_partial_product p9(M,Q[19:17],partial_product[9]); 
	 get_partial_product p10(M,Q[21:19],partial_product[10]); 
	 get_partial_product p11(M,Q[23:21],partial_product[11]); 
	 get_partial_product p12(M,Q[25:23],partial_product[12]); 
	 get_partial_product p13(M,Q[27:25],partial_product[13]); 
	 get_partial_product p14(M,Q[29:27],partial_product[14]); 
	 get_partial_product p15(M,Q[31:29],partial_product[15]); 


    assign res = partial_product[0] + (partial_product[1] << 2) + (partial_product[2] << 4)
                + (partial_product[3] << 6) + (partial_product[4] << 8) + (partial_product[5] << 10)
                + (partial_product[6] << 12) + (partial_product[7] << 14) + (partial_product[8] << 16)
                + (partial_product[9] << 18) + (partial_product[10] << 20) + (partial_product[11] << 22)
                + (partial_product[12] << 24) + (partial_product[13] << 26) + (partial_product[14] << 28)
                + (partial_product[15] << 30);

endmodule