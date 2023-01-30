module bus_mux (parameter word_size = 32) (
    output [word_size-1:0]  BusMuxOut,
    input [word_size-1:0]   BusMuxIn_R0,
    input [word_size-1:0]   BusMuxIn_R1,
    input [word_size-1:0]   BusMuxIn_R2,
    input [word_size-1:0]   BusMuxIn_R3,
    input [word_size-1:0]   BusMuxIn_R4,
    input [word_size-1:0]   BusMuxIn_R5,
    input [word_size-1:0]   BusMuxIn_R6,
    input [word_size-1:0]   BusMuxIn_R7,
    input [word_size-1:0]   BusMuxIn_R8,
    input [word_size-1:0]   BusMuxIn_R9,
    input [word_size-1:0]   BusMuxIn_R10,
    input [word_size-1:0]   BusMuxIn_R11,
    input [word_size-1:0]   BusMuxIn_R12,
    input [word_size-1:0]   BusMuxIn_R13,
    input [word_size-1:0]   BusMuxIn_R14,
    input [word_size-1:0]   BusMuxIn_R15,
    input [word_size-1:0]   BusMuxIn_HI,
    input [word_size-1:0]   BusMuxIn_LO,
    input [word_size-1:0]   BusMuxIn_Z_HI,
    input [word_size-1:0]   BusMuxIn_Z_LO,
    input [word_size-1:0]   BusMuxIn_PC,
    input [word_size-1:0]   BusMuxIn_MDR,
    input [word_size-1:0]   BusMuxIn_IN_PORT,
    input [word_size-1:0]   C_Sign_Extended,

    // 5-bit assertion signal: S0, S1, S2, S3, S4
    input [4:0] select
);

always@(*) 
begin
    case (encoder_in)
        32'h00000001 : select = 5'b0;
        32'h00000002 : select = 5'b00001;
        32'h00000004 : select = 5'b00010;
        32'h00000008 : select = 5'b00011;
        32'h00000010 : select = 5'b00100;
        32'h00000020 : select = 5'b00101;
        32'h00000040 : select = 5'b00110;
        32'h00000080 : select = 5'b00111;
        32'h00000100 : select = 5'b01000;
        32'h00000200 : select = 5'b01001;
        32'h00000400 : select = 5'b01010;
        32'h00000800 : select = 5'b01011;
        32'h00001000 : select = 5'b01100;
        32'h00002000 : select = 5'b01101;
        32'h00004000 : select = 5'b01110;
        32'h00008000 : select = 5'b01111;
        32'h00010000 : select = 5'b10000;
        32'h00020000 : select = 5'b10001;
        32'h00040000 : select = 5'b10010;
        32'h00080000 : select = 5'b10011;
        32'h00100000 : select = 5'b10100;
        32'h00200000 : select = 5'b10101;
        32'h00400000 : select = 5'b10110;
        32'h00800000 : select = 5'b10111;
        32'h01000000 : select = 5'b11000;
        32'h02000000 : select = 5'b11001;
        32'h04000000 : select = 5'b11010;
        32'h08000000 : select = 5'b11011;
        32'h10000000 : select = 5'b11100;
        32'h20000000 : select = 5'b11101;
        32'h40000000 : select = 5'b11110;
        32'h80000000 : select = 5'b11111;
    
    endcase
//case
//32'(value) <= 5'[value]

endmodule