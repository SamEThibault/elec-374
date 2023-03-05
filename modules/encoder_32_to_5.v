// module encoder_32_to_5 (output reg [4:0] enc_output, input wire [31:0] enc_input);
//     always@(*) 
//     begin
//         case (enc_input)
//             32'h00000001 : enc_output <= 5'b00000;
//             32'h00000002 : enc_output <= 5'b00001;
//             32'h00000004 : enc_output <= 5'b00010;
//             32'h00000008 : enc_output <= 5'b00011;
//             32'h00000010 : enc_output <= 5'b00100;
//             32'h00000020 : enc_output <= 5'b00101;
//             32'h00000040 : enc_output <= 5'b00110;
//             32'h00000080 : enc_output <= 5'b00111;
//             32'h00000100 : enc_output <= 5'b01000;
//             32'h00000200 : enc_output <= 5'b01001;
//             32'h00000400 : enc_output <= 5'b01010;
//             32'h00000800 : enc_output <= 5'b01011;
//             32'h00001000 : enc_output <= 5'b01100;
//             32'h00002000 : enc_output <= 5'b01101;
//             32'h00004000 : enc_output <= 5'b01110;
//             32'h00008000 : enc_output <= 5'b01111;
//             32'h00010000 : enc_output <= 5'b10000;
//             32'h00020000 : enc_output <= 5'b10001;
//             32'h00040000 : enc_output <= 5'b10010;
//             32'h00080000 : enc_output <= 5'b10011;
//             32'h00100000 : enc_output <= 5'b10100;
//             32'h00200000 : enc_output <= 5'b10101;
//             32'h00400000 : enc_output <= 5'b10110;
//             32'h00800000 : enc_output <= 5'b10111;
//             32'h01000000 : enc_output <= 5'b11000;
//             32'h02000000 : enc_output <= 5'b11001;
//             32'h04000000 : enc_output <= 5'b11010;
//             32'h08000000 : enc_output <= 5'b11011;
//             32'h10000000 : enc_output <= 5'b11100;
//             32'h20000000 : enc_output <= 5'b11101;
//             32'h40000000 : enc_output <= 5'b11110;
//             32'h80000000 : enc_output <= 5'b11111;
//             default: enc_output <= 5'b00000;
//         endcase
//     end
// endmodule

module encoder_32_to_5 (output reg [4:0] enc_output, input wire [31:0] enc_input);

    always@(*) 
    begin
		case(enc_input)
            32'b00000000000000000000000000000001 : enc_output <= 5'b00000; //0
            32'b00000000000000000000000000000010 : enc_output <= 5'b00001; //1
            32'b00000000000000000000000000000100 : enc_output <= 5'b00010; //2
            32'b00000000000000000000000000001000 : enc_output <= 5'b00011; //3
            32'b00000000000000000000000000010000 : enc_output <= 5'b00100; //4
            32'b00000000000000000000000000100000 : enc_output <= 5'b00101; //5
            32'b00000000000000000000000001000000 : enc_output <= 5'b00110; //6
            32'b00000000000000000000000010000000 : enc_output <= 5'b00111; //7
            32'b00000000000000000000000100000000 : enc_output <= 5'b01000; //8
            32'b00000000000000000000001000000000 : enc_output <= 5'b01001; //9
            32'b00000000000000000000010000000000 : enc_output <= 5'b01010; //10
            32'b00000000000000000000100000000000 : enc_output <= 5'b01011; //11
            32'b00000000000000000001000000000000 : enc_output <= 5'b01100; //12
            32'b00000000000000000010000000000000 : enc_output <= 5'b01101; //13
            32'b00000000000000000100000000000000 : enc_output <= 5'b01110; //14
            32'b00000000000000001000000000000000 : enc_output <= 5'b01111; //15
            32'b00000000000000010000000000000000 : enc_output <= 5'b10000; //16
            32'b00000000000000100000000000000000 : enc_output <= 5'b10001; //17
            32'b00000000000001000000000000000000 : enc_output <= 5'b10010; //18
            32'b00000000000010000000000000000000 : enc_output <= 5'b10011; //19
            32'b00000000000100000000000000000000 : enc_output <= 5'b10100; //20
            32'b00000000001000000000000000000000 : enc_output <= 5'b10101; //21
            32'b00000000010000000000000000000000 : enc_output <= 5'b10110; //22
            32'b00000000100000000000000000000000 : enc_output <= 5'b10111; //23
            32'b00000001000000000000000000000000 : enc_output <= 5'b11000; //24
            32'b00000010000000000000000000000000 : enc_output <= 5'b11001; //25
            32'b00000100000000000000000000000000 : enc_output <= 5'b11010; //26
            32'b00001000000000000000000000000000 : enc_output <= 5'b11011; //27
            32'b00010000000000000000000000000000 : enc_output <= 5'b11100; //28
            32'b00100000000000000000000000000000 : enc_output <= 5'b11101; //29
            32'b01000000000000000000000000000000 : enc_output <= 5'b11110; //30
            32'b10000000000000000000000000000000 : enc_output <= 5'b11111; //31
            default: enc_output <= 5'b11111;
        endcase
    end
endmodule