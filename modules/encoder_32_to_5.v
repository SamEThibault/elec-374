module encoder_32_to_5 (output reg [4:0] enc_output, input wire [31:0] enc_input);
    always@(*) 
    begin
        case (enc_input)
            32'h00000001 : enc_output <= 5'b00000;
            32'h00000002 : enc_output <= 5'b00001;
            32'h00000004 : enc_output <= 5'b00010;
            32'h00000008 : enc_output <= 5'b00011;
            32'h00000010 : enc_output <= 5'b00100;
            32'h00000020 : enc_output <= 5'b00101;
            32'h00000040 : enc_output <= 5'b00110;
            32'h00000080 : enc_output <= 5'b00111;
            32'h00000100 : enc_output <= 5'b01000;
            32'h00000200 : enc_output <= 5'b01001;
            32'h00000400 : enc_output <= 5'b01010;
            32'h00000800 : enc_output <= 5'b01011;
            32'h00001000 : enc_output <= 5'b01100;
            32'h00002000 : enc_output <= 5'b01101;
            32'h00004000 : enc_output <= 5'b01110;
            32'h00008000 : enc_output <= 5'b01111;
            32'h00010000 : enc_output <= 5'b10000;
            32'h00020000 : enc_output <= 5'b10001;
            32'h00040000 : enc_output <= 5'b10010;
            32'h00080000 : enc_output <= 5'b10011;
            32'h00100000 : enc_output <= 5'b10100;
            32'h00200000 : enc_output <= 5'b10101;
            32'h00400000 : enc_output <= 5'b10110;
            32'h00800000 : enc_output <= 5'b10111;
            32'h01000000 : enc_output <= 5'b11000;
            32'h02000000 : enc_output <= 5'b11001;
            32'h04000000 : enc_output <= 5'b11010;
            32'h08000000 : enc_output <= 5'b11011;
            32'h10000000 : enc_output <= 5'b11100;
            32'h20000000 : enc_output <= 5'b11101;
            32'h40000000 : enc_output <= 5'b11110;
            32'h80000000 : enc_output <= 5'b11111;
        endcase
    end
endmodule