module div_32_bit(
    output reg[31:0] quotient,
    output reg[31:0] remainder,
    input wire[31:0] dividend,
    input wire[31:0] divisor
);

integer i;
reg [31:0] Q;
reg [31:0] M;
reg [31:0] A;
// wire [31:0] negDivisor;
reg [31:0] subOutput;
// negate_32_bit negRes(negDivisor, Q);

always@(dividend or divisor)
begin
    A = 32'd0;
    Q = dividend;
    M = divisor;

    for(i=0; i<32; i= i + 1)begin
        A={A[30:0], Q[31]}; //Shift left
        subOutput = A - M; //Subtract

        if(subOutput[31] == 1)begin
            Q = {Q[30:0], 1'b0}; //Set q0 && restore
        end
        else begin
            Q = {Q[30:0], 1'b1};//Set q0
            A = subOutput; //Don't restore
        end
    end

    quotient = Q; 
    remainder = A;
end
endmodule