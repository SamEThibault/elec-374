module full_adder(output wire c_out, output wire s_out , input wire c_in, input wire x_in, input wire y_in);

    assign s_out = x_in ^ y_in ^ c_in;
    assign c_out = (x_in & y_in) | (x_in & c_in) | (y_in & c_in);

endmodule