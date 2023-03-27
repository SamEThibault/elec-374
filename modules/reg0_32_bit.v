// Revised R0
module reg0_32_bit #(parameter INIT_VAL = 32'h00000000)(
    output reg [31:0] q,
    input wire [31:0] BusMuxOut,
    input wire clk,
    input wire clr,
    input wire enable,
    input wire BAout
    );

// wire [31:0] BAout_extended;
initial 
begin
    q = INIT_VAL;
end

always @(posedge clk or posedge clr)
begin
    // if (BAout == 1)
    //     BAout_extended = 32'b0;
    // else
    //     BAout_extended = 32'b0;
    
    if (clr == 1)
        q <= 32'h00000000;
    else if (enable == 1)
    begin
        if (BAout == 1)
            q <= BusMuxOut & 32'h00000000;
        else
            q <= BusMuxOut & 32'hFFFFFFFF;

        // BA_result = ~(BAout == 1 ? 32'hFFFFFFFF : 32'h00000000);
        // q <= BusMuxOut & ~(BAout == 1 ? 32'hFFFFFFFF : 32'h00000000);
    end
end

endmodule