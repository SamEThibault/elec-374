module select_and_encode #(parameter init_val = 0 )(output reg [31:0] C_sign_extended_out, output reg [15:0] R_enables, output reg [15:0] R_outs, input wire Gra, Grb, Grc, R_in, R_out, BA_out, input [31:0] IR);

reg [3:0] decoder_input = 16'b0000000000000000;
reg [15:0] decoder_output;




initial
begin
    R_enables = 16'h00000000;
    R_outs =    16'h00000000;
end

reg BA_out_or_R_out;
reg [3:0] RA_GRA, RB_GRB, RC_GRC;
always@(*)
begin
 BA_out_or_R_out = (R_out | BA_out); //Needs to be synchronous
end

// always@(IR[26:23], IR[22:19], IR[18:15])
always@(*)
begin
    RA_GRA = (IR[26:23] & (Gra? 4'b1111: 4'b0000));
    RB_GRB = (IR[22:19] & (Grb? 4'b1111: 4'b0000));
    RC_GRC = (IR[18:15] & (Grb? 4'b1111: 4'b0000));
    // decoder_input = ((IR[26:23] & (Gra? 4'b1111: 4'b0000)) | (IR[22:19] & (Grb? 4'b1111: 4'b0000)) | (IR[18:15] & (Grc? 4'b1111: 4'b0000)));
    decoder_input = (RA_GRA | RB_GRB | RC_GRC );
end
    always@(*) 
    begin
		case(decoder_input)
            //0-15 (binary)                //One-hot encoding
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
    always@(*)
    begin
        case(decoder_output) //Note R_in has to be 16 1's
        16'b0000000000000001: R_enables <= 16'b0000000000000001 & (R_in ? 16'hFFFF: 16'h0000); //R0
        16'b0000000000000010: R_enables <= 16'b0000000000000010 & (R_in ? 16'hFFFF: 16'h0000); //R1
        16'b0000000000000100: R_enables <= 16'b0000000000000100 & (R_in ? 16'hFFFF: 16'h0000); //R2
        16'b0000000000001000: R_enables <= 16'b0000000000001000 & (R_in ? 16'hFFFF: 16'h0000); //R3
        16'b0000000000010000: R_enables <= 16'b0000000000010000 & (R_in ? 16'hFFFF: 16'h0000); //R4
        16'b0000000000100000: R_enables <= 16'b0000000000100000 & (R_in ? 16'hFFFF: 16'h0000); //R4
        16'b0000000001000000: R_enables <= 16'b0000000001000000 & (R_in ? 16'hFFFF: 16'h0000); //R6
        16'b0000000010000000: R_enables <= 16'b0000000010000000 & (R_in ? 16'hFFFF: 16'h0000); //R7
        16'b0000000100000000: R_enables <= 16'b0000000100000000 & (R_in ? 16'hFFFF: 16'h0000); //R8
        16'b0000001000000000: R_enables <= 16'b0000001000000000 & (R_in ? 16'hFFFF: 16'h0000); //R9
        16'b0000010000000000: R_enables <= 16'b0000010000000000 & (R_in ? 16'hFFFF: 16'h0000); //R10
        16'b0000100000000000: R_enables <= 16'b0000100000000000 & (R_in ? 16'hFFFF: 16'h0000); //R11
        16'b0001000000000000: R_enables <= 16'b0001000000000000 & (R_in ? 16'hFFFF: 16'h0000); //R12
        16'b0010000000000000: R_enables <= 16'b0010000000000000 & (R_in ? 16'hFFFF: 16'h0000); //R13
        16'b0100000000000000: R_enables <= 16'b0100000000000000 & (R_in ? 16'hFFFF: 16'h0000); //R14
        16'b1000000000000000: R_enables <= 16'b1000000000000000 & (R_in ? 16'hFFFF: 16'h0000); //R15
        default:             R_enables <=  16'b0000000000000000;
        endcase 
    end

    // For R15_out to R0_out
    always@(*)
    begin
        case(decoder_output) //Note (R_out | BA_out) has to be 16 1's
        16'b0000000000000001: R_outs <= 16'b0000000000000001 & (BA_out_or_R_out? 16'hFFFF: 16'h0000);
        16'b0000000000000010: R_outs <= 16'b0000000000000010 & (BA_out_or_R_out? 16'hFFFF: 16'h0000);
        16'b0000000000000100: R_outs <= 16'b0000000000000100 & (BA_out_or_R_out? 16'hFFFF: 16'h0000);
        16'b0000000000001000: R_outs <= 16'b0000000000001000 & (BA_out_or_R_out? 16'hFFFF: 16'h0000); 
        16'b0000000000010000: R_outs <= 16'b0000000000010000 & (BA_out_or_R_out? 16'hFFFF: 16'h0000); 
        16'b0000000000100000: R_outs <= 16'b0000000000100000 & (BA_out_or_R_out? 16'hFFFF: 16'h0000); 
        16'b0000000001000000: R_outs <= 16'b0000000001000000 & (BA_out_or_R_out? 16'hFFFF: 16'h0000);  
        16'b0000000010000000: R_outs <= 16'b0000000010000000 & (BA_out_or_R_out? 16'hFFFF: 16'h0000);  
        16'b0000000100000000: R_outs <= 16'b0000000100000000 & (BA_out_or_R_out? 16'hFFFF: 16'h0000);  
        16'b0000001000000000: R_outs <= 16'b0000001000000000 & (BA_out_or_R_out? 16'hFFFF: 16'h0000);  
        16'b0000010000000000: R_outs <= 16'b0000010000000000 & (BA_out_or_R_out? 16'hFFFF: 16'h0000);  
        16'b0000100000000000: R_outs <= 16'b0000100000000000 & (BA_out_or_R_out? 16'hFFFF: 16'h0000);  
        16'b0001000000000000: R_outs <= 16'b0001000000000000 & (BA_out_or_R_out? 16'hFFFF: 16'h0000);  
        16'b0010000000000000: R_outs <= 16'b0010000000000000 & (BA_out_or_R_out? 16'hFFFF: 16'h0000);  
        16'b0100000000000000: R_outs <= 16'b0100000000000000 & (BA_out_or_R_out? 16'hFFFF: 16'h0000);  
        16'b1000000000000000: R_outs <= 16'b1000000000000000 & (BA_out_or_R_out? 16'hFFFF: 16'h0000);  
        default:              R_outs <= 16'b0000000000000000;
        endcase 
    end

    //For C_sign_extended<31..0>
    always@(IR)
    begin

        C_sign_extended_out = $signed(IR[18:0]);

    end
endmodule