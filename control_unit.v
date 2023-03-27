`timescale 1ns/10ps
module control_unit (
    output reg PC_out, ZHigh_out, MDR_out, MAR_enable, PC_enable, MDR_enable, IR_enable, Y_enable, IncPC, Read, 
    HI_enable, LO_enable, HI_out, LO_out, Z_enable, C_out, RAM_write_enable, Gra, Grb, Grc, R_in, R_out, BA_out, 
    con_in, in_port_enable, out_port_enable, in_port_out, Run, ZLow_out, 

    input [31:0] IR_data_out,
    input clk, clr, stop
);


parameter reset_state = 8'b00000000, fetch0 = 8'b00000001, fetch1 = 8'b00000010, fetch2 = 8'b00000011,
            add3 = 8'b00000100, add4 = 8'b00000101, add5 = 8'b00000110, sub3 = 8'b00000111, sub4 = 8'b00001000, sub5 = 8'b00001001,
            mul3 = 8'b00001010, mul4 = 8'b00001011, mul5 = 8'b00001100, mul6 = 8'b00001101, div3 = 8'b00001110, div4 = 8'b00001111,
            div5 = 8'b00010000, div6 = 8'b00010001, or3 = 8'b00010010, or4 = 8'b00010011, or5 = 8'b00010100, and3 = 8'b00010101, 
            and4 = 8'b00010110, and5 = 8'b00010111, shl3 = 8'b00011000, shl4 = 8'b00011001, shl5 = 8'b00011010, shr3 = 8'b00011011,
            shr4 = 8'b00011100, shr5 = 8'b00011101, rol3 = 8'b00011110, rol4 = 8'b00011111, rol5 = 8'b00100000, ror3 = 8'b00100001,
            ror4 = 8'b00100010, ror5 = 8'b00100011, neg3 = 8'b00100100, neg4 = 8'b00100101, neg5 = 8'b00100110, not3 = 8'b00100111,
            not4 = 8'b00101000, not5 = 8'b00101001, ld3 = 8'b00101010, ld4 = 8'b00101011, ld5 = 8'b00101100, ld6 = 8'b00101101, 
            ld7 = 8'b00101110, ldi3 = 8'b00101111, ldi4 = 8'b00110000, ldi5 = 8'b00110001, st3 = 8'b00110010, st4 = 8'b00110011,
            st5 = 8'b00110100, st6 = 8'b00110101, st7 = 8'b00110110, addi3 = 8'b00110111, addi4 = 8'b00111000, addi5 = 8'b00111001,
            andi3 = 8'b00111010, andi4 = 8'b00111011, andi5 = 8'b00111100, ori3 = 8'b00111101, ori4 = 8'b00111110, ori5 = 8'b00111111,
            br3 = 8'b01000000, br4 = 8'b01000001, br5 = 8'b01000010, br6 = 8'b01000011, br7 = 8'b11111111, jr3 = 8'b01000100, jal3 = 8'b01000101, 
            jal4 = 8'b01000110, mfhi3 = 8'b01000111, mflo3 = 8'b01001000, in3 = 8'b01001001, out3 = 8'b01001010, nop3 = 8'b01001011, 
            halt3 = 8'b01001100;

reg [7:0] present_state = reset_state;


always @(posedge clk, posedge clr, posedge stop) // finite state machine; if clk or clr rising-edge
begin
    if(clr == 1) present_state = reset_state;
	if (stop == 1) present_state = halt3;
    else 
    case (present_state)
        reset_state : #40 present_state = fetch0;
        fetch0 : #40 present_state = fetch1;
        fetch1 : #40 present_state = fetch2;
        fetch2 : #40

            begin
                case (IR_data_out[31:27]) // inst. decoding based on the opcode to set the next state

					// ALU OPS
                    5'b00011 : present_state = add3;	
                    5'b00100 : present_state = sub3;
                    5'b01111 : present_state = mul3;
                    5'b10000 : present_state = div3;
                    5'b00111 : present_state = shr3;
                    5'b01001 : present_state = shl3;
                    5'b01010 : present_state = ror3;
                    5'b01011 : present_state = rol3;
                    5'b00101 : present_state = and3;
                    5'b00110 : present_state = or3;
                    5'b10001 : present_state = neg3;
                    5'b10010 : present_state = not3;
                    5'b01000 : present_state = shr3; // this is the shra instruction, same sequence as shr
                    5'b01100 : present_state = addi3;
                    5'b01101 : present_state = andi3;
                    5'b01110 : present_state = ori3;

					// MEM OPS
                    5'b00000 : present_state = ld3;
                    5'b00001: present_state = ldi3;
                    5'b00010 : present_state = st3;
                    5'b10011 : present_state = br3;
                    5'b10100 : present_state = jr3; 
                    5'b10101 : present_state = jal3; 
                    5'b11000 : present_state = mfhi3;
                    5'b11001 : present_state = mflo3;
                    5'b10110 : present_state = in3;
                    5'b10111 : present_state = out3;
                    5'b11010 : present_state = nop3;
                    5'b11011 : present_state = halt3;
                endcase
            end

			// Go to the reset state after each instruction completes to de-assert all relevant signals
			// Each state change takes 40ns to allow signals to propagate properly which avoids race condition

			// MEM OPS
			ld3 : #40 present_state = ld4;
			ld4 : #40 present_state = ld5;
			ld5 : #40 present_state = ld6;
			ld6 : #40 present_state = ld7;
			ld7 : #40 present_state = reset_state;
			
			ldi3 : #40 present_state = ldi4;
			ldi4 : #40 present_state = ldi5;
			ldi5 : #60 present_state = reset_state;
			
			st3 : #40 present_state = st4;
			st4 : #40 present_state = st5;
			st5 : #40 present_state = st6;
			st6 : #40 present_state = st7;
			st7 : #40 present_state = reset_state;
			
			jal3 : #40 present_state = jal4;
			jal4 : #40 present_state = reset_state;
			
			jr3 : #40 present_state = reset_state;
			
			br3 : #40 present_state = br4;
			br4 : #40 present_state = br5;
			br5 : #40 present_state = br6;
			br6 : #40 present_state = br7;
			br7 : #40 present_state = reset_state;
			
			out3 : #40 present_state = reset_state;
			
			in3 : #40 present_state = reset_state;
			
			mflo3 : #40 present_state = reset_state;
			
			mfhi3 : #40 present_state = reset_state;

			nop3 : #40 present_state = reset_state;

			// ALU OPS
			add3 : #40 present_state = add4;
			add4 : #40 present_state = add5;
			add5 : #40 present_state = reset_state;
			
			addi3 : #40 present_state = addi4;
			addi4 : #40 present_state = addi5;
			addi5 : #40 present_state = reset_state;
			
			sub3 : #40 present_state = sub4;
			sub4 : #40 present_state = sub5;
			sub5 : #40 present_state = reset_state;
			
			mul3 : #40 present_state = mul4;
			mul4 : #40 present_state = mul5;
			mul5 : #40 present_state = mul6;
			mul6  : #40 present_state = reset_state; 
			
			div3 : #40 present_state = div4;
			div4 : #40 present_state = div5;
			div5 : #40 present_state = div6;
			div6 : #40 present_state = reset_state;
			
			or3 : #40 present_state = or4;
			or4 : #40 present_state = or5;
			or5 : #40 present_state = reset_state;
			
			and3 : #40 present_state = and4;
			and4 : #40 present_state = and5;
			and5 : #40 present_state = reset_state;
			
			shl3 : #40 present_state = shl4;
			shl4 : #40 present_state = shl5;
			shl5 : #40 present_state = reset_state;
			
			shr3 : #40 present_state = shr4;
			shr4 : #40 present_state = shr5;
			shr5 : #40 present_state = reset_state;
			
			rol3 : #40 present_state = rol4;
			rol4 : #40 present_state = rol5;
			rol5 : #40 present_state = reset_state;
			
			ror3 : #40 present_state = ror4;
			ror4 : #40 present_state = ror5;
			ror5 : #40 present_state = reset_state;
			
			neg3 : #40 present_state = neg4;
			neg4 : #40 present_state = reset_state;
			
			not3 : #40 present_state = not4;
			not4 : #40 present_state = reset_state;

			andi3 : #40 present_state = andi4;
			andi4 : #40 present_state = andi5;
			andi5 : #40 present_state = reset_state;
			
			ori3 : #40 present_state = ori4;
			ori4 : #40 present_state = ori5;
			ori5 : #40 present_state = reset_state;
    
    endcase
end

// This block actually does the work that we did in the phase 2 testbenches by asserting signals
// and all that shizzle
always @(present_state) // do the job for each state
begin
    case(present_state)
		reset_state: begin 
			Gra <= 0; Grb <= 0; Grc <= 0; R_in <= 0; R_out <= 0; BA_out <= 0; con_in <= 0; 
			HI_enable <= 0; LO_enable <= 0; HI_out <= 0; LO_out <= 0; 
			Y_enable <= 0; ZHigh_out <= 0; ZLow_out <= 0; Z_enable <= 0; C_out <= 0;  
			MDR_out <= 0; MAR_enable <= 0; PC_enable <= 0; MDR_enable <= 0; PC_out <= 0;
            IR_enable <= 0; IncPC <= 0; Read <= 0; RAM_write_enable <= 0;
            out_port_enable <= 0; in_port_enable <= 0; in_port_out <= 0; 
		end
		fetch0: begin
			PC_out <= 1; MAR_enable <= 1; 
		end 
		fetch1: begin
			PC_out <= 0; MAR_enable <= 0;
			MDR_enable <= 1; Read<=1; 
		end 
		fetch2: begin
			MDR_enable <= 0; Read<=0;

			//Sending the instruction address to IR 
			MDR_out <= 1; IR_enable <= 1;

			// increment PC
			#10 PC_enable <= 1; IncPC <= 1;
			#20 PC_enable <= 0; IncPC <= 0;
		end 
		//**************************************************************
		add3, sub3: begin	
			MDR_out <= 0; IR_enable <= 0; PC_enable <= 0; IncPC <= 0;
			Grb <= 1; R_out <= 1; Y_enable <= 1;
		end
		add4, sub4: begin
				Grb <= 0; R_out <= 0; Y_enable <= 0;
				Grc<=1; R_out <= 1; Z_enable <= 1;  
		end
		add5, sub5: begin
				Grc<=0; R_out <= 0; Z_enable <= 0;  Z_enable <= 0;
				ZLow_out <= 1; Gra<=1; R_in<=1;
		end
		//**************************************************************
		or3, and3, shl3, shr3, rol3, ror3: begin	
			MDR_out <= 0; IR_enable <= 0;PC_enable <= 0; IncPC <= 0;
			Grb<=1; R_out<=1; Y_enable<=1;
		end
		or4, and4, shl4, shr4, rol4, ror4: begin
			Grb<=0; R_out<=0;Y_enable<=0;
			Grc<=1; R_out <= 1;Z_enable <= 1; 
		end
		or5, and5, shl5, shr5, rol5, ror5: begin
			Grc<=0; R_out <= 0; Z_enable <= 0;  Z_enable <= 0;
			ZLow_out <= 1; Gra<=1; R_in <=1;
			#30 ZLow_out <= 0; Gra<=1; R_out<=1; R_in<=0;
		end
		//**************************************************************
		mul3, div3: begin	
			MDR_out <= 0; IR_enable <= 0;
			Gra <= 1 ; R_out <= 1; Y_enable <= 1;  
			
		end
		mul4, div4: begin
			Gra <= 0; R_out <= 0; Y_enable <= 0;
			Grb <=1 ; R_out <= 1; Z_enable <= 1; 
				
		end
		mul5, div5: begin
			Grb <=0; R_out<=0; Z_enable <= 0; 
			ZLow_out<=1; LO_enable <= 1;
				
		end
		mul6, div6: begin
			ZLow_out <= 0; LO_enable <= 0;
			ZHigh_out <= 1; HI_enable <= 1; 
		end
		//**************************************************************
		not3, neg3: begin	
			MDR_out <= 0; IR_enable <= 0;PC_enable <= 0; IncPC <= 0;
			Grb<=1; R_out <= 1;Z_enable <= 1; 
		end
		not4, neg4: begin
			Grb<=0; R_out <= 0; Z_enable <= 0;  Z_enable <= 0;
			ZLow_out <= 1; Gra<=1; R_in <=1;
		end

		//**************************************************************
		andi3: begin
			MDR_out <= 0; IR_enable <= 0; PC_enable <= 0; IncPC <= 0;	
			Grb<=1;R_out<=1;Y_enable<=1;
		end

		andi4: begin
			Grb<=0;R_out<=0;Y_enable<=0;
			C_out<=1;Z_enable <= 1; 
		end

		andi5: begin
			C_out<=0; Z_enable <= 0;  Z_enable <= 0;
			ZLow_out <= 1;Gra<=1; R_in <=1;
			#30 ZLow_out <= 0;Gra<=1;R_out<=1; R_in <=0;
		end
		//**************************************************************
		addi3: begin
			MDR_out <= 0; IR_enable <= 0;
			Grb <= 1; R_out <= 1; Y_enable <=1 ;
		end

		addi4: begin
			Grb<=0;R_out<=0;Y_enable<=0;
			C_out<=1;Z_enable <= 1; 
		end

		addi5: begin
			C_out<=0; Z_enable <= 0;  Z_enable <= 0;
			ZLow_out <= 1;Gra<=1; R_in <=1;
			#30 ZLow_out <= 0;Gra<=1;R_out<=1; R_in<=0;
		end
		//**************************************************************
		ori3: begin
			MDR_out <= 0; IR_enable <= 0; PC_enable <= 0; IncPC <= 0;		
			Grb<=1;R_out<=1;Y_enable<=1;
		end

		ori4: begin
			Grb<=0;R_out<=0;Y_enable<=0;
			C_out<=1;Z_enable <= 1; 
		end

		ori5: begin
			C_out<=0; Z_enable <= 0;  Z_enable <= 0;
			ZLow_out <= 1;Gra<=1; R_in <=1;
			#30 ZLow_out <= 0;Gra<=1;R_out<=1; R_in <=0;
		end
		//**************************************************************
		ld3: begin
			MDR_out <= 0; IR_enable <= 0;	
			Grb<=1; BA_out<=1; Y_enable<=1; R_in <= 1;
		end

		ld4: begin
			#10 Grb<=0; BA_out<=0; Y_enable<=0; R_in <= 0;
			C_out<=1; Z_enable <= 1; 
		end

		ld5: begin
			#10 C_out<=0; Z_enable <= 0;
			ZLow_out <= 1; MAR_enable<=1;
		end

		ld6: begin
			#10 ZLow_out <= 0; MAR_enable <= 0;
			Read <= 1; MDR_enable <= 1;
		end
		ld7: begin
			#10 Read <= 0; MDR_enable <= 0;
			MDR_out <= 1; Gra <= 1; R_in <= 1;
		end
		//**************************************************************

		ldi3: begin
			MDR_out <= 0; IR_enable <=0 ; 		
			Grb <= 1; BA_out <= 1; Y_enable <= 1; 
		end

		ldi4: begin
			#20 Grb<=0; BA_out<=0; Y_enable<=0;

			C_out<=1; Z_enable <= 1;
		end

		ldi5: begin
			C_out<=0; Z_enable <= 0;
			ZLow_out <= 1; Gra<=1; R_in <=1; 
			#20 ZLow_out <= 0; Gra<=0; R_in <=0; 
		end

		//**************************************************************
		st3: begin
			MDR_out <= 0; IR_enable <= 0; PC_enable <= 0; IncPC <= 0;		
			Grb<=1;BA_out<=1;Y_enable<=1;
		end

		st4: begin
			Grb<=0;BA_out<=0;Y_enable<=0;
			C_out<=1;Z_enable <= 1; 
		end

		st5: begin
			C_out<=0; Z_enable <= 0;  Z_enable <= 0;
			ZLow_out <= 1;MAR_enable<=1;
		end

		st6: begin
			ZLow_out <= 0; MAR_enable <= 0;
			Read <= 0; Gra <= 1; R_out <= 1; MDR_enable <= 1;
		end
		st7: begin
			Gra <= 0; R_out <= 0; MDR_enable <= 0;
			MDR_out <= 1; 
			#5 RAM_write_enable <= 1; 
		end
		//**************************************************************
		jr3: begin
			MDR_out <= 0; IR_enable <= 0;	PC_enable <= 0; IncPC <= 0;				
			Gra<=1;R_out<=1; PC_enable <= 1;
			#30 PC_enable <= 0;
		end
		//**************************************************************
		jal3: begin
			MDR_out <= 0; IR_enable <= 0; PC_enable <= 0;IncPC <= 0;	
			PC_out <= 1;  
		end

		jal4: begin
			  PC_out <= 0;
			Gra <= 1; R_out <= 1; PC_enable <= 1;
		end
		//**************************************************************
		mfhi3: begin
			MDR_out <= 0; IR_enable <= 0; PC_enable <= 0; IncPC <= 0;	
			Gra<=1; R_in <=1; HI_out<=1;
			#30 Gra<=0; R_in <=0; HI_out<=0;
		end
		//**************************************************************

		mflo3: begin
			MDR_out <= 0; IR_enable <= 0; PC_enable <= 0; IncPC <= 0;	
			Gra<=1; R_in <=1; LO_out<=1;
			#30 Gra<=0; R_in <=0; LO_out<=0;
		end
		//**************************************************************

		in3: begin
			MDR_out <= 0; IR_enable <= 0; PC_enable <= 0; IncPC <= 0;
			Gra<=1; R_in<=1; in_port_enable <= 1;
		end
		// **************************************************************

		out3: begin
			MDR_out <= 0; IR_enable <= 0; PC_enable <= 0; IncPC <= 0;	
			Gra<=1;R_out<=1;Y_enable<=1; out_port_enable <= 1;
		end

		//**************************************************************
		br3: begin
			MDR_out <= 0; IR_enable <= 0; IncPC <= 0;		
			Gra<=1; R_out<=1; con_in <= 1;
		end

		br4: begin
			#10 Gra<=0;R_out<=0;
				PC_out<=1; Y_enable <= 1;
		end

		br5: begin
			PC_out<=0; Y_enable <= 0;
			   	C_out <= 1; Z_enable <= 1;
		end

		br6: begin
			C_out <= 0; Z_enable <= 0;
			   	ZLow_out<=1; PC_enable<=1; 
		end

		br7: begin
			ZLow_out<=0; PC_enable<=0; con_in <=0;
		end
        
		//**************************************************************
		nop3: begin
			// Do nothing
		end
		//**************************************************************
		halt3: begin
			Run <= 0;
		end
		default: begin 
			// Do nothing
		end
	endcase
end
endmodule