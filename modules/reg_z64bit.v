// Register with posedge async clear and rising clock-edge response, pos-edge enable
module ZRegister64(
    input wire [63:0] d,
    input wire clk,
    input wire clr,
    input wire enable,
    output reg [63:0] q
    );

always @ ((posedge clk and posedge enable) or posedge clr)
begin
    if (clr)
        q <= 0;
    else
        q <= d; 
end

endmodule

// to instantiate, we would do:
/*
module <name>;
   [wire clock;
   wire reset;
   wire [31:0] data_in;
   wire [31:0] my_register_out;
   Register32 name_of_register(clock, reset, data_in, my_register_out);
endmodule
*/