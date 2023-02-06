module PCRegister #(parameter init = 0)(
    input [31:0] in,
    input clk, increment, enable,
    output reg[31:0] new
);

initial new = init;

always @ (posedge clk && enable == 1)
begin
    if (increment == 1)
        new <= new + 1;
    else
        new <= in;
end

endmodule