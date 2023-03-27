// Revised R0: OBSOLETE, NOT IN USE
module reg0_32_bit #(parameter INIT_VAL = 32'h00000000)(
    output reg [31:0] q,
    input wire [31:0] BusMuxOut,
    input wire clk,
    input wire clr,
    input wire enable,
    input wire BAout
    );


initial 
begin
    q = INIT_VAL;
end

always @(posedge clk or posedge clr)
begin
    
    if (clr == 1)
        q <= 32'h00000000;
    else if (enable == 1)
    begin
        if (BAout == 1)
            q <= BusMuxOut & 32'h00000000;
        else
            q <= BusMuxOut & 32'hFFFFFFFF;
    end
end

assign out = {32{BAout}} & q;

endmodule