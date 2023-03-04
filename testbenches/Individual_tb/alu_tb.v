`timescale 1ns/10ps  

module alu_tb (input a, input b);
    
    //ALU Inputs
    wire[63:0] Rc;
    reg[31:0] Ra;
    reg[31:0] Rb;
    reg[4:0] opcode;

	parameter Addition = 5'b00011, Subtraction = 5'b00100, Multiplication = 5'b01110, Division = 5'b01111, Shift_right = 5'b00101, Shift_left = 5'b00110, Rotate_right = 5'b00111, Rotate_left = 5'b01000, And = 5'b01001, Or = 5'b01010, Negate = 5'b10000, Not = 5'b10001,  Shift_right_arithmetic=5'b10010;
   
    alu test_unit(Rc, Ra, Rb, opcode);

    initial 
        begin
            Ra = 32'h01111111;
			Rb = 32'b10;
            // opcode = Addition; //Add - Works
			// opcode = Subtraction; //Sub - Works 
			// opcode = And; //And - Works 
			// opcode = Or; //Or - Works
			// opcode = Shift_right; //Shr - Works
			// opcode = Shift_left; //Shl - Works
			// opcode = Shift_right_arithmetic; //Shra - works
			// opcode = Rotate_right; //Ror - Works
			// opcode = Rotate_left; //Rol - Works
			// opcode = Multiplication; //Mul - Works
			// opcode = Division; //Div - Works
			// opcode = Negate; //Neg - Works 
			// opcode = Not; //Not - Works

        end
endmodule
