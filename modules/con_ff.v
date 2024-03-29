module con_ff #(parameter INIT_VAL = 32'h00000000)(
    output reg con_out,
    // IR[20...19] bits must be passed in only
    input wire [1:0] IR,
    input wire [31:0] bus_in,
    // generated by control unit (P3)
    input wire con_in
);

initial
begin
con_out = INIT_VAL;
end

// 4 bits passed to internal logic cct.
reg [3:0] decoder_out;
reg nor_out, equal_zero, not_equal_zero, greater_equal_zero, less_zero;

always @(*) 
begin
	 if (con_in == 1)
	 begin
		 case(IR)
			  2'b00: decoder_out <= 4'b0001;
			  2'b01: decoder_out <= 4'b0010;
			  2'b10: decoder_out <= 4'b0100;
			  2'b11: decoder_out <= 4'b1000;
			  default: decoder_out <= 4'b0000;
		 endcase

		 nor_out = ~|bus_in;
		 equal_zero <= decoder_out[0] & nor_out;
		 not_equal_zero <= decoder_out[1] & ~(nor_out);
		 greater_equal_zero <= decoder_out[2] & ~(bus_in[31]);
		 less_zero <= decoder_out[3] & bus_in[31];

		 con_out = (equal_zero | not_equal_zero | greater_equal_zero | less_zero);
	 end
end
endmodule