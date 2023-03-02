// Register with posedge async clear and rising clock-edge response, pos-edge enable
module reg_32_bit(
    output reg [31:0] q,
    input wire [31:0] d,
    input wire clk,
    input wire clr,
    input wire enable
    );

always @(posedge clk or posedge clr)
begin

    if (clr)
        q <= 0;
    else if (enable)
        q <= d;
end

endmodule