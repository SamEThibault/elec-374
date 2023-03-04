module half_adder( output wire c_out, output wire s_out, input wire x_in, input wire y_in);

   assign s_out = x_in ^ y_in;
   assign c_out = x_in & y_in;

endmodule