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


module mul (
    output reg[63:0] res,
    input reg[31:0] M,
    input reg[31:0] Q
);
    integer i;
    reg[2:0] code; 
    res = 32'h00000000;

    // used to temporarily store the 16 partial products calculated in the for-loop
    wire[63:0] partial_product;

    // finds each partial product and stores it in partial_products[i-1]
    for (i = 1; i < 17; i = i + 1)
    begin

        // base case where we need to concatenate a 0 to the LSB of the first 2 bits of multiplier
        if (i == 1) begin
            code = {b[1:0], 1'b0};
        end else begin
        // else get the 3 bits we're currently at to determine partial product
            code = b[(i*2) - 1 : (i*2) - 3];
        end

        // determine partial product
        case (code)
            3'b000: partial_product = $signed(31'b0);    // all zeros
            3'b010: partial_product = $signed(M);       // 1 * M
            3'b001: partial_product = $signed(M);       // 1 * M
            3'b011: partial_product = $signed(M)<<<1;   // 2 * M
            3'b111: partial_product = $signed(31'b0)    // all zeros
            3'b100:                                     // -2 * M
            begin
                partial_product = $signed(M);
                partial_product = $signed(~partial_product + 1'b1);
                partial_product = $signed(partial_product) <<< 1;
            end
            3'b101:                                     // -1 * M
            begin
                partial_product = $signed(M);
                partial_product = $signed(~partial_product + 1'b1);
            end
            3'b110:                                     // -1 * M
            begin
                partial_product = $signed(M);
                partial_product = $signed(~partial_product + 1'b1);
            end
        endcase

        res = res + $signed(partial_product <<< ((i*2) - 2));
    end
endmodule