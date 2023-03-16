module select_and_encode (output reg C_sign_extended_out, output reg R_enables, output reg R_outs, input wire [0:0]  Gra, Grb, Grc, R_in_temp, R_out, BA_out, input [31:0] IR);

reg [3:0] Ra, Rb, Rc;

reg [3:0] decoder_input;
reg [15:0] decoder_output;
wire [0:0] BA_or_R_out_or_result;
reg [15:0] BA_or_R_out;
reg [15:0] R_in;
or_32_bit OR(BA_or_R_out_or_result, R_out, BA_out);

always@(R_in_temp)
begin 
    if(R_in_temp == 1)
    begin
        R_in = 16'hFFFF;
    end 
    else
    begin
        R_in = 16'h0000;
    end
end

always@(BA_or_R_out_or_result)
begin
    if(BA_or_R_out_or_result[0:0] == 1)
    begin
        BA_or_R_out = 16'hFFFF;
    end
    else begin
        BA_or_R_out = 16'h0000;
    end
end

always@(IR[26:23], IR[22:19], IR[18:15], Gra, Grb, Grc)
begin
    decoder_input = ((IR[26:23] & Gra) | (IR[22:19] & Grb) | (IR[18:15] & Grc));
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
        case(decoder_output) //Note BA_or_R_out has to be 16 1's
        4'b0000000000000001: R_outs <= 16'b0000000000000001 & BA_or_R_out;
        4'b0000000000000010: R_outs <= 16'b0000000000000010 & BA_or_R_out;
        4'b0000000000000100: R_outs <= 16'b0000000000000100 & BA_or_R_out;
        4'b0000000000001000: R_outs <= 16'b0000000000001000 & BA_or_R_out; 
        4'b0000000000010000: R_outs <= 16'b0000000000010000 & BA_or_R_out; 
        4'b0000000000100000: R_outs <= 16'b0000000000100000 & BA_or_R_out; 
        4'b0000000001000000: R_outs <= 16'b0000000001000000 & BA_or_R_out;  
        4'b0000000010000000: R_outs <= 16'b0000000010000000 & BA_or_R_out;  
        4'b0000000100000000: R_outs <= 16'b0000000100000000 & BA_or_R_out;  
        4'b0000001000000000: R_outs <= 16'b0000001000000000 & BA_or_R_out;  
        4'b0000010000000000: R_outs <= 16'b0000010000000000 & BA_or_R_out;  
        4'b0000100000000000: R_outs <= 16'b0000100000000000 & BA_or_R_out;  
        4'b0001000000000000: R_outs <= 16'b0001000000000000 & BA_or_R_out;  
        4'b0010000000000000: R_outs <= 16'b0010000000000000 & BA_or_R_out;  
        4'b0100000000000000: R_outs <= 16'b0100000000000000 & BA_or_R_out;  
        4'b1000000000000000: R_outs <= 16'b1000000000000000 & BA_or_R_out;  
        default:             R_outs <= 16'b0000000000000000;
        endcase 
    end

endmodule