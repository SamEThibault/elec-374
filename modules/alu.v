module alu(
	output reg [63:0] Rc,
	input wire [31:0] Ra,
	input wire [31:0] Rb,
	input wire [4:0] opcode
);
	parameter 
	Addition = 5'b00011, 
	Subtraction = 5'b00100, 
	Multiplication = 5'b01111, 
	Division = 5'b10000, 
	Shift_right = 5'b00111, 
	Shift_left = 5'b01001, 
	Rotate_right = 5'b01010, 
	Rotate_left = 5'b01011, 
	And = 5'b00101, 
	Or = 5'b00110, 
	Negate = 5'b10001, 
	Not = 5'b10010,  
	Shift_right_arithmetic=5'b11111,
	load = 5'b00000,
    loadi = 5'b00001,
	br = 5'b10011,
    store = 5'b00010,
	addi = 5'b01100,
	andi = 5'b01101,
	ori = 5'b01110;
	
    //Operation Outputs
	wire [31:0] IncPC_out, shr_out, shl_out, shra_out, or_out, and_out, neg_out, not_out, add_sum, add_cout, sub_sum, sub_cout, rol_out, ror_out, mul_out_hi, mul_out_lo;
	wire [63:0] div_out, mul_out;

	//Possible ALU Operations
	or_32_bit or_op(or_out, Ra, Rb);
	and_32_bit and_op(and_out, Ra, Rb);
	negate_32_bit negate_op(neg_out, Rb);
	not_32_bit not_op(not_out, Rb);
	add_32_bit add_op(add_cout, add_sum, Ra, Rb, 32'h00000000);
	sub_32_bit sub_op(sub_cout, sub_sum, Ra, Rb);
	ror_32_bit ror_op(ror_out, Ra, Rb);
	rol_32_bit rol_op(rol_out, Ra, Rb);
	shl_32_bit shl_op(shl_out, Ra, Rb);
	shr_32_bit shr_op(shr_out, Ra, Rb);
	shra_32_bit shra_op(shra_out, Ra, Rb);
	div_32_bit div_op(div_out, Ra, Rb);
	mul mul_op(mul_out_hi, mul_out_lo, Ra, Rb);
	
	always @(*) // do the required job in each state
		begin	
			case (opcode) // assert the required signals in each clock cycle
				
				Addition, addi: begin
					Rc[31:0] = add_sum[31:0];
					Rc[63:32] = 32'd0;
				end
				
				Subtraction: begin
					Rc[31:0] = sub_sum[31:0];	
					Rc[63:32] = 32'd0;
				end
				
				Or, ori: begin
					Rc[31:0] = or_out[31:0];
					Rc[63:32] = 32'd0;
				end
				
				And, andi: begin
					Rc[31:0] = and_out[31:0];
					Rc[63:32] = 32'd0;
				end
				
				Negate: begin
					Rc[31:0] = neg_out[31:0];
					Rc[63:32] = 32'd0;
				end
				
				Not: begin
					Rc[31:0] = not_out[31:0];
					Rc[63:32] = 32'd0;
				end
				
				Shift_right: begin
					Rc[31:0] = shr_out[31:0];
					Rc[63:32] = 32'd0;
				end
				
				Shift_left: begin
					Rc[31:0] = shl_out[31:0];
					Rc[63:32] = 32'd0;
				end
                
				Shift_right_arithmetic: begin
                    Rc[31:0] = shra_out[31:0];
					Rc[63:32] = 32'd0;
                end

				Rotate_right: begin
					Rc[31:0] = ror_out[31:0];
					Rc[63:32] = 32'd0;
				end
				
				Rotate_left: begin
					Rc[31:0] = rol_out[31:0];
					Rc[63:32] = 32'd0;
				end
				
				Multiplication: begin
					Rc[63:32] = mul_out_hi;
					Rc[31:0] = mul_out_lo;
				end
				
				Division: begin
					Rc[63:0] = div_out[63:0];
				end

				loadi,load,store, br: begin
					Rc[31:0] = add_sum[31:0];
					Rc[63:32] = 32'd0;
				end

				default: Rc[63:0] = 0;

			endcase
	end

endmodule