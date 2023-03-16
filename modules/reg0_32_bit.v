// Revised R0
module reg0_32_bit(
    output reg [31:0] q,
    input wire [31:0] BusMuxOut,
    input wire clk,
    input wire clr,
    input wire enable,
    input wire BAout
    );

wire [31:0] BAout_extended;

always @(posedge clk or posedge clr)
begin
    if (BAout == 1)
        BAout_extended = 32'b0;
    else
        BAout_extended = 32'b0;
    
    if (clr)
        q <= 32'b0 & ~(BAout_extended);
    else if (enable)
        q <= BusMuxOut & ~(BAout_extended);
end

endmodule