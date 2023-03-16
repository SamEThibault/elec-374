module select_and_encode (output reg [31:0] C_sign_extended_out, output reg [15:0] R_enables, output reg [15:0] R_outs, input wire Gra, Grb, Grc, R_in, R_out, BA_out, input [31:0] IR);

reg [3:0] decoder_input;
reg [15:0] decoder_output;

wire BA_or_R_out;
or_32_bit OR(BA_or_R_out, R_out, BA_out);


always@(IR[26:23], IR[22:19], IR[18:15], Gra, Grb, Grc)
begin
    decoder_input = ((IR[26:23] & (Gra? 4'b1111: 4'b0000)) | (IR[22:19] & (Grb? 4'b1111: 4'b0000)) | (IR[18:15] & (Grc? 4'b1111: 4'b0000)));
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
        16'b0000000000000001: R_enables <= 16'b0000000000000001 & (R_in ? 16'hFFFF: 16'h0000);
        16'b0000000000000010: R_enables <= 16'b0000000000000010 & (R_in ? 16'hFFFF: 16'h0000);
        16'b0000000000000100: R_enables <= 16'b0000000000000100 & (R_in ? 16'hFFFF: 16'h0000);
        16'b0000000000001000: R_enables <= 16'b0000000000001000 & (R_in ? 16'hFFFF: 16'h0000); 
        16'b0000000000010000: R_enables <= 16'b0000000000010000 & (R_in ? 16'hFFFF: 16'h0000); 
        16'b0000000000100000: R_enables <= 16'b0000000000100000 & (R_in ? 16'hFFFF: 16'h0000); 
        16'b0000000001000000: R_enables <= 16'b0000000001000000 & (R_in ? 16'hFFFF: 16'h0000);  
        16'b0000000010000000: R_enables <= 16'b0000000010000000 & (R_in ? 16'hFFFF: 16'h0000);  
        16'b0000000100000000: R_enables <= 16'b0000000100000000 & (R_in ? 16'hFFFF: 16'h0000);  
        16'b0000001000000000: R_enables <= 16'b0000001000000000 & (R_in ? 16'hFFFF: 16'h0000);  
        16'b0000010000000000: R_enables <= 16'b0000010000000000 & (R_in ? 16'hFFFF: 16'h0000);  
        16'b0000100000000000: R_enables <= 16'b0000100000000000 & (R_in ? 16'hFFFF: 16'h0000);  
        16'b0001000000000000: R_enables <= 16'b0001000000000000 & (R_in ? 16'hFFFF: 16'h0000);  
        16'b0010000000000000: R_enables <= 16'b0010000000000000 & (R_in ? 16'hFFFF: 16'h0000);  
        16'b0100000000000000: R_enables <= 16'b0100000000000000 & (R_in ? 16'hFFFF: 16'h0000);  
        16'b1000000000000000: R_enables <= 16'b1000000000000000 & (R_in ? 16'hFFFF: 16'h0000);  
        default:             R_enables <= 16'b0000000000000000;
        endcase 
    end

    // For R15_out to R0_out
    always@(decoder_output)
    begin
        case(decoder_output) //Note BA_or_R_out has to be 16 1's
        16'b0000000000000001: R_outs <= 16'b0000000000000001 & (BA_or_R_out ? 16'hFFFF: 16'h0000);
        16'b0000000000000010: R_outs <= 16'b0000000000000010 & (BA_or_R_out ? 16'hFFFF: 16'h0000);
        16'b0000000000000100: R_outs <= 16'b0000000000000100 & (BA_or_R_out ? 16'hFFFF: 16'h0000);
        16'b0000000000001000: R_outs <= 16'b0000000000001000 & (BA_or_R_out ? 16'hFFFF: 16'h0000); 
        16'b0000000000010000: R_outs <= 16'b0000000000010000 & (BA_or_R_out ? 16'hFFFF: 16'h0000); 
        16'b0000000000100000: R_outs <= 16'b0000000000100000 & (BA_or_R_out ? 16'hFFFF: 16'h0000); 
        16'b0000000001000000: R_outs <= 16'b0000000001000000 & (BA_or_R_out ? 16'hFFFF: 16'h0000);  
        16'b0000000010000000: R_outs <= 16'b0000000010000000 & (BA_or_R_out ? 16'hFFFF: 16'h0000);  
        16'b0000000100000000: R_outs <= 16'b0000000100000000 & (BA_or_R_out ? 16'hFFFF: 16'h0000);  
        16'b0000001000000000: R_outs <= 16'b0000001000000000 & (BA_or_R_out ? 16'hFFFF: 16'h0000);  
        16'b0000010000000000: R_outs <= 16'b0000010000000000 & (BA_or_R_out ? 16'hFFFF: 16'h0000);  
        16'b0000100000000000: R_outs <= 16'b0000100000000000 & (BA_or_R_out ? 16'hFFFF: 16'h0000);  
        16'b0001000000000000: R_outs <= 16'b0001000000000000 & (BA_or_R_out ? 16'hFFFF: 16'h0000);  
        16'b0010000000000000: R_outs <= 16'b0010000000000000 & (BA_or_R_out ? 16'hFFFF: 16'h0000);  
        16'b0100000000000000: R_outs <= 16'b0100000000000000 & (BA_or_R_out ? 16'hFFFF: 16'h0000);  
        16'b1000000000000000: R_outs <= 16'b1000000000000000 & (BA_or_R_out ? 16'hFFFF: 16'h0000);  
        default:             R_outs <= 16'b0000000000000000;
        endcase 
    end

    //For C_sign_extended<31..0>
    always@(IR)
    begin
        if(IR[18:18] == 1)
        begin
            // IR[18:0] = 19'b1111 11111 11111 11111
            // IR_out = {IR[31:19], 19'b1111111111111111111};
            C_sign_extended_out = 32'hFFFFFFFF;
        end
        else 
        begin
            // IR[18:0] = 19'b0000 00000 00000 0000;
            // IR_out = {IR[31:19], 19'b000000000000000000};

            C_sign_extended_out = 32'h00000000;
        end
    end
endmodule