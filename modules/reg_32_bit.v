// Register with posedge async clear and rising clock-edge response, pos-edge enable
module reg_32_bit #(parameter INIT_VAL = 32'h00000000)(
    output reg [31:0] q,
    input wire [31:0] d,
    input wire clk,
    input wire clr,
    input wire enable
    );


initial 
begin
    q = INIT_VAL;
end

always @(posedge clk or posedge clr)
begin

    if (clr == 1)
        q <= 0;
    else if (enable == 1)
        q <= d;
end

endmodule