// Register with posedge async clear and rising clock-edge response, pos-edge enable
module reg_32_bit #(parameter init_val = 0)(
    output reg [31:0] q,
    input wire [31:0] d,
    input wire clk,
    input wire clr,
    input wire enable
    );

initial 
begin
    q = init_val;
end

always @(posedge clk or posedge clr)
begin

    if (clr)
        q <= 0;
    else if (enable)
        q <= d;
end

endmodule