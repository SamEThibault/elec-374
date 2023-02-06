module mux_2_to_1 (input wire [31:0] input_1, input wire [31:0] input_2, input wire signal, output reg [31:0] out);
 
always@(*)begin
		if (signal)
			out[31:0] <= input_2[31:0];
		else 
			out[31:0] <= input_1[31:0];
	end
 
endmodule