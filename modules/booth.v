/*
- Booth recoding
- Start a for-loop (number of multiplicand bits)
- Have a variable that adds to a global variable
- A switch-case to see what operation to do (add M, add -M, or add 0)
*/

module mul (
    input [31:0] multiplier;
    input [31:0] multiplicand;
    output reg [63:0] res;
    // split answer into high and low results
);
    integer i;
    integer signed code;

    always @(*) begin
        
        // initialize to all zeros
        res [31:0] = 32'h00000000;

        // sign-extend the multiplicand
        reg [63:0] mutliplicand_ext = $signed(multiplicand);  
        reg [63:0] twos_complement;

        for (i = 0; i < 15; i = i + 1) 
        begin
            // base case with implied 0 @ LSB
            if (i == 0) 
            begin
                if (multiplier[i] == 0 && multiplier[i+1] == 0)
                    code = 0;
                else if (multiplier[i] == 1 && multiplier[i+1] == 0)
                    code = 1;
                else if (multiplier[i] == 0 && multiplier[i+1] == 1)
                    code = -2;
                else if (multiplier[i] == 1 && multiplier[i+1] == 1)
                    code = -1;
            end

            // bit-pair code generated
            if ((multiplier[i-1] == 0 && multiplier[i] == 0 && multiplier[i+1] == 0) || 
                (multiplier[i-1] == 1 && multiplier[i] == 1 && multiplier[i+1] == 1))
                code = 0;
            else if ((multiplier[i-1] == 1 && multiplier[i] == 0 && multiplier[i+1] == 0) || 
                    (multiplier[i-1] == 0 && multiplier[i] == 1 && multiplier[i+1] == 0))
                code = 1;
            else if (multiplier[i-1] == 1 && multiplier[i] == 1 && multiplier[i+1] == 0)
                code = 2;
            else if (multiplier[i-1] == 0 && multiplier[i] == 0 && multiplier[i+1] == 1)
                code = -2;
            else if ((multiplier[i-1] == 1 && multiplier[i] == 0 && multiplier[i+1] == 1) || 
                    (multiplier[i-1] == 0 && multiplier[i] == 1 && multiplier[i+1] == 1))
                code = -1;
            
            // here use the code to operate on the multiplicand
            // mostly pseudocode now until we test it:

            // shift left twice, add multiplicand
            if (code == 1) begin
                res = res + (mutliplicand_ext << i*2);
            end
            // shift left 3 times, add multiplicand
            else if (code == 2) begin
                res = res + (multiplicand_ext << i*2 + 1);
            end
            // shift left twice, add 2's complement
            else if (code == -1) begin
                twos_complement[31:0] = (multiplicand << i*2);
                twos_complement = $signed(twos_complement);
                // then actually get two's complement of first [31:0]
                res = res + twos_complement;
            end
            // shift left 3 times, add 2's complement
            else if (code == -2) begin
                twos_complement[31:0] = (multiplicand << i*2 + 1);
                twos_complement = $signed(twos_complement);
                // then actually get two's complement of first [31:0]
                res = res + twos_complement;
            end
        end
    end
    
endmodule