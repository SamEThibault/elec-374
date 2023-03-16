module select_and_encode (output C_sign_extended_out, output R_enables, output R_outs, input Gra, Grb, Grc, r_enable, r_out, ba_out);

wire [3:0] Ra, Rb, Rc;
wire [3:0] decoder_input;
wire [15:0] decoder_output;
always@(Ra, Rb, Rc, Gra,Grb, Grc)
begin
    decoder_input = ((Ra & Gra) | (Rb & Grb) | (Rc & Grc));
end

    always@(decoder_input) 
    begin
		case(decoder_input)
            //0-15 (binary)         //One-hot encoding
            4'b0000 : decoder_output <= 16'b0000000000000001; 
            4'b0001 : decoder_output <= 16'b0000000000000010;
            4'b0010 : decoder_output <= 16'b0000000000000100; 
            4'b0011 : decoder_output <= 16'b0000000000001000; 
            4'b0100 : decoder_output <= 16'b0000000000010000; 
            4'b0101 : decoder_output <= 16'b0000000000100000; 
            4'b0110 : decoder_output <= 16'b0000000001000000;  
            4'b0111 : decoder_output <= 16'b0000000010000000;  
            4'b1000 : decoder_output <= 16'b0000000100000000;  
            4'b1001 : decoder_output <= 16'b0000001000000000;  
            4'b1010 : decoder_output <= 16'b0000010000000000;  
            4'b1011 : decoder_output <= 16'b0000100000000000;  
            4'b1100 : decoder_output <= 16'b0001000000000000;  
            4'b1101 : decoder_output <= 16'b0010000000000000;  
            4'b1110 : decoder_output <= 16'b0100000000000000;  
            4'b1111 : decoder_output <= 16'b1000000000000000;  
            default: decoder_output  <= 16'b0000000000000000;
        endcase
    end

    // For R15_in to R_0_in
    always@(decoder_output)
    begin
        case(decoder_output) //Note R_in has to be 16 1's
        4'b0000000000000001: R_enables <= 16'b0000000000000001 & R_in;
        4'b0000000000000010: R_enables <= 16'b0000000000000010 & R_in;
        4'b0000000000000100: R_enables <= 16'b0000000000000100 & R_in;
        4'b0000000000001000: R_enables <= 16'b0000000000001000 & R_in; 
        4'b0000000000010000: R_enables <= 16'b0000000000010000 & R_in; 
        4'b0000000000100000: R_enables <= 16'b0000000000100000 & R_in; 
        4'b0000000001000000: R_enables <= 16'b0000000001000000 & R_in;  
        4'b0000000010000000: R_enables <= 16'b0000000010000000 & R_in;  
        4'b0000000100000000: R_enables <= 16'b0000000100000000 & R_in;  
        4'b0000001000000000: R_enables <= 16'b0000001000000000 & R_in;  
        4'b0000010000000000: R_enables <= 16'b0000010000000000 & R_in;  
        4'b0000100000000000: R_enables <= 16'b0000100000000000 & R_in;  
        4'b0001000000000000: R_enables <= 16'b0001000000000000 & R_in;  
        4'b0010000000000000: R_enables <= 16'b0010000000000000 & R_in;  
        4'b0100000000000000: R_enables <= 16'b0100000000000000 & R_in;  
        4'b1000000000000000: R_enables <= 16'b1000000000000000 & R_in;  
        default:             R_enables <= 16'b0000000000000000;
        endcase 
    end

    // For R15_out to R0_out
    always@(decoder_output)
    begin
        case(decoder_output) //Note Ba_or_r_out has to be 16 1's
        4'b0000000000000001: R_outs <= 16'b0000000000000001 & Ba_or_r_out;
        4'b0000000000000010: R_outs <= 16'b0000000000000010 & Ba_or_r_out;
        4'b0000000000000100: R_outs <= 16'b0000000000000100 & Ba_or_r_out;
        4'b0000000000001000: R_outs <= 16'b0000000000001000 & Ba_or_r_out; 
        4'b0000000000010000: R_outs <= 16'b0000000000010000 & Ba_or_r_out; 
        4'b0000000000100000: R_outs <= 16'b0000000000100000 & Ba_or_r_out; 
        4'b0000000001000000: R_outs <= 16'b0000000001000000 & Ba_or_r_out;  
        4'b0000000010000000: R_outs <= 16'b0000000010000000 & Ba_or_r_out;  
        4'b0000000100000000: R_outs <= 16'b0000000100000000 & Ba_or_r_out;  
        4'b0000001000000000: R_outs <= 16'b0000001000000000 & Ba_or_r_out;  
        4'b0000010000000000: R_outs <= 16'b0000010000000000 & Ba_or_r_out;  
        4'b0000100000000000: R_outs <= 16'b0000100000000000 & Ba_or_r_out;  
        4'b0001000000000000: R_outs <= 16'b0001000000000000 & Ba_or_r_out;  
        4'b0010000000000000: R_outs <= 16'b0010000000000000 & Ba_or_r_out;  
        4'b0100000000000000: R_outs <= 16'b0100000000000000 & Ba_or_r_out;  
        4'b1000000000000000: R_outs <= 16'b1000000000000000 & Ba_or_r_out;  
        default:             R_outs <= 16'b0000000000000000;
        endcase 
    end

endmodule