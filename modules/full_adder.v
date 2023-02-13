module full_adder(output reg c_out, output reg s_out , input wire c_in, input wire x_in, input wire y_in);

always@(*)
begin
    s_out = x_in ^ y_in ^ c_in;
    c_out = (x_in & y_in) | (x_in & c_in) | (y_in & c_in);
end

endmodule