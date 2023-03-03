// /*
// - Booth recoding
// - Start a for-loop (number of multiplicand bits)
// - Have a variable that adds to a global variable
// - A switch-case to see what operation to do (add M, add -M, or add 0)
// */

// module mul (
//     output reg [31:0] res_hi,
//     output reg [31:0] res_lo,
//     input [31:0] multiplicand,
//     input [31:0] multiplier
    
// );
//     integer i;
//     integer code;
//     reg [63:0] res; 
//     reg [63:0] mutliplicand_ext 
//     reg [63:0] twos_complement;

//     always @(*) begin
        
//         // initialize to all zeros
//         res = 32'h00000000;

//         // sign-extend the multiplicand
//         mutliplicand_ext = $signed(multiplicand);  

//         for (i = 0; i < 15; i = i + 1) 
//         begin
//             // base case with implied 0 @ LSB
//             if (i == 0) 
//             begin
//                 if (multiplier[i] == 0 && multiplier[i+1] == 0)
//                     code = 0;
//                 else if (multiplier[i] == 1 && multiplier[i+1] == 0)
//                     code = 1;
//                 else if (multiplier[i] == 0 && multiplier[i+1] == 1)
//                     code = -2;
//                 else if (multiplier[i] == 1 && multiplier[i+1] == 1)
//                     code = -1;
//             end

//             // bit-pair code generated
//             if ((multiplier[i-1] == 0 && multiplier[i] == 0 && multiplier[i+1] == 0) || 
//                 (multiplier[i-1] == 1 && multiplier[i] == 1 && multiplier[i+1] == 1))
//                 code = 0;
//             else if ((multiplier[i-1] == 1 && multiplier[i] == 0 && multiplier[i+1] == 0) || 
//                     (multiplier[i-1] == 0 && multiplier[i] == 1 && multiplier[i+1] == 0))
//                 code = 1;
//             else if (multiplier[i-1] == 1 && multiplier[i] == 1 && multiplier[i+1] == 0)
//                 code = 2;
//             else if (multiplier[i-1] == 0 && multiplier[i] == 0 && multiplier[i+1] == 1)
//                 code = -2;
//             else if ((multiplier[i-1] == 1 && multiplier[i] == 0 && multiplier[i+1] == 1) || 
//                     (multiplier[i-1] == 0 && multiplier[i] == 1 && multiplier[i+1] == 1))
//                 code = -1;
            
//             // here use the code to operate on the multiplicand
//             // mostly pseudocode now until we test it:

//             // shift left twice, add multiplicand
//             if (code == 1) begin
//                 res = res + (mutliplicand_ext << i*2);
//             end
//             // shift left 3 times, add multiplicand
//             else if (code == 2) begin
//                 res = res + (multiplicand_ext << i*2 + 1);
//             end
//             // shift left twice, add 2's complement
//             else if (code == -1) begin
//                 twos_complement[31:0] = (multiplicand << i*2);
//                 twos_complement = $signed(twos_complement);
//                 negate_32_bit negate(twos_complement[31:0], multiplicand);
//                 res = res + twos_complement;
//             end
//             // shift left 3 times, add 2's complement
//             else if (code == -2) begin
//                 twos_complement[31:0] = (multiplicand << i*2 + 1);
//                 twos_complement = $signed(twos_complement);
//                 negate_32_bit negate(twos_complement[31:0], multiplicand);
//                 res = res + twos_complement;
//             end
//         end

//         res_hi = res[63:32];
//         res_lo = res[31:0];
//     end
// endmodule

// -------------------------------------------------
// Try 2:


// module mul (
//     output reg[63:0] res,
//     input[31:0] M,
//     input[31:0] Q
// );
//     integer i;
//     reg[2:0] code; 

//     // used to temporarily store the 16 partial products calculated in the for-loop
//     reg[63:0] partial_product;
	
// 	always @* begin
//     // finds each partial product and stores it in partial_products[i-1]
//     for (i = 1; i < 17; i = i + 1)
//     begin

//         // base case where we need to concatenate a 0 to the LSB of the first 2 bits of multiplier
//         if (i == 1) begin
//             assign code = {Q[1:0], 1'b0};
//         end else begin
//         // else get the 3 bits we're currently at to determine partial product
//             code = {Q[i*2-1], Q[i*2-2], Q[i*2-3]};
//         end

//         // determine partial product
//         case (code)
//             3'b000: partial_product = $signed(31'b0);    // all zeros
//             3'b010: partial_product = $signed(M);       // 1 * M
//             3'b001: partial_product = $signed(M);       // 1 * M
//             3'b011: partial_product = $signed(M)<<<1;   // 2 * M
//             3'b111: partial_product = $signed(31'b0);   // all zeros
//             3'b100:                                     // -2 * M
//             begin
//                 partial_product = $signed(M);
//                 partial_product = $signed(~partial_product + 1'b1);
//                 partial_product = $signed(partial_product) <<< 1;
//             end
//             3'b101:                                     // -1 * M
//             begin
//                 partial_product = $signed(M);
//                 partial_product = $signed(~partial_product + 1'b1);
//             end
//             3'b110:                                     // -1 * M
//             begin
//                 partial_product = $signed(M);
//                 partial_product = $signed(~partial_product + 1'b1);
//             end
//         endcase

//         res = res + $signed(partial_product <<< ((i*2) - 2));
//     end
// end
// endmodule


// -------------------------------------------
// ------------------------------------------------
// Try 4
// // the actual multiplication module
// module mul(
//     output reg [63:0] res,
//     input [31:0] M, 
//     input [31:0] Q
// );
    
//     // array of 16 x 64-bit partial products
//     wire [63:0] partial_product [15:0];
    
//     genvar i;
//     generate
//         // base case where we concatenate a 0 to the LSB of the first 2 Q bits
//         get_partial_product pp_call_base(.res(partial_product[0]), .M(M), .code({Q[1], Q[0], 1'b0}));

//         // generate 15 other partial products by calling the partialproduct() module
//         for (i = 1; i < 16; i = i + 1) begin : get_partial_products
//             get_partial_product pp_call(.res(partial_product[i]), .M(M), .code({Q[i+1], Q[i], Q[i-1]}));
//         end
//     endgenerate
    
//     always @* begin
//         res = partial_product[0] + (partial_product[1] << 2) + (partial_product[2] << 4) 
//                 + (partial_product[3] << 6) + (partial_product[4] << 8) + (partial_product[5] << 10) 
//                 + (partial_product[6] << 12) + (partial_product[7] << 14) + (partial_product[8] << 16) 
//                 + (partial_product[9] << 18) + (partial_product[10] << 20) + (partial_product[11] << 22) 
//                 + (partial_product[12] << 24) + (partial_product[13] << 26) + (partial_product[14] << 28) 
//                 + (partial_product[15] << 30);
//     end

// endmodule

// // get_partial_product module
// module get_partial_product(
//     output reg [63:0] res,
//     input [31:0] M,
//     input [2:0] code
// );

//     always @(*) begin
//         case (code)
//             3'b000: res = 64'b0;                            // M * 0
//             3'b111: res = 64'b0;

//             3'b001: res = M;                                // M * 1
//             3'b010: res = M;                                

//             3'b011: res = {M, 32'b0} << 1;                  // M * 2

//             3'b101: res = (~M) + 1'b1;                      // M * (-1)
//             3'b110: res = (~M) + 1'b1;                      
//             3'b100: 
//             begin 
//                     res = M;
//                     res = (~res) + 1'b1;                      // M * (-2)
//                     res = {res, 32'b0} << 1;
// 			end
//         endcase
//     end
// endmodule


// Try 5:
// module booth_multiplier(
//     input signed [31:0] a,
//     input signed [31:0] b,
//     output signed [63:0] result
// );

//     // Create registers for A and S
//     reg signed [31:0] A_reg;
//     reg signed [31:0] S_reg;

//     // Create a register for the count
//     reg [5:0] count;

//     // Create a register for the product
//     reg signed [63:0] product_reg;

//     // Initialize registers
//     initial begin
//         A_reg = {32{1'b0}};
//         S_reg = {32{1'b0}};
//         count = 0;
//         product_reg = {64{1'b0}};
//     end

//     // Assign inputs to registers
//     always @(*) begin
//         A_reg <= a;
//         S_reg <= b;
//     end

//     // Booth algorithm with bit-pair encoding
//     always @(*) begin
//         if (count < 32) begin

//             // Check if the LSB and the next bit of S are different
//             if ((S_reg[1] ^ S_reg[0]) == 1'b1) begin
//                 if (S_reg[0] == 1'b1) begin
//                     product_reg <= product_reg + (A_reg << count);
//                 end else begin
//                     product_reg <= product_reg - (A_reg << count);
//                 end
//             end else if (S_reg[0] == 1'b1) begin
//                 product_reg <= product_reg - (A_reg << count);
//             end else begin
//                 product_reg <= product_reg + (A_reg << count);
//             end

//             // Shift S to the right by 1 bit
//             S_reg <= {S_reg[31], S_reg[31:1]};

//             // Increment count
//             count <= count + 1;
//         end
//     end

//     // Assign output to product_reg
//     assign result = product_reg;
    
// endmodule

