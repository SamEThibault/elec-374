// Register with async clear and rising clock-edge response, pos-edge enable
module Register32(
    input wire [31:0] d,
    input wire clk,
    input wire clr,
    input wire enable,
    output reg [31:0] q
    );

always @ ((posedge clk or posedge clr) and posedge enable)
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