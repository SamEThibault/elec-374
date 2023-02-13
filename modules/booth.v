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
);
    integer i;
    integer signed code;

    always @(*) begin
        
        res [31:0] = multiplicand;


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

            // If 1, then add a row with the original multiplicand (sign extend to twice the size of the original multiplicand)
            if (code == 1) begin
                res [31+i:0+i] = res[31:0] + multiplicand;
                res [63:32+i] = res[63:32] + multiplicand[31];
            end
            else if (code == 2) begin
                
            end

        end
    end
    
endmodule