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
    // input [word_size-1:0]   BusMuxIn_IN_PORT,
    // input [word_size-1:0]   C_Sign_Extended,

    // 5-bit assertion signal: S0, S1, S2, S3, S4
    input [4:0] select
);

always@(*)
begin
    case (select)
        5'd0: BusMuxOut <= BusMuxIn_R0;
        5'd1: BusMuxOut <= BusMuxIn_R1;
        5'd2: BusMuxOut <= BusMuxIn_R2;
        5'd3: BusMuxOut <= BusMuxIn_R3;
        5'd4: BusMuxOut <= BusMuxIn_R4;
        5'd5: BusMuxOut <= BusMuxIn_R5;
        5'd6: BusMuxOut <= BusMuxIn_R6;
        5'd7: BusMuxOut <= BusMuxIn_R7;
        5'd8: BusMuxOut <= BusMuxIn_R8;
        5'd9: BusMuxOut <= BusMuxIn_R9; 
        5'd10: BusMuxOut <= BusMuxIn_R10;
        5'd11: BusMuxOut <= BusMuxIn_R11;
        5'd12: BusMuxOut <= BusMuxIn_R12;
        5'd13: BusMuxOut <= BusMuxIn_R13;
        5'd14: BusMuxOut <= BusMuxIn_R14;
        5'd15: BusMuxOut <= BusMuxIn_R15;
        5'd16: BusMuxOut <= BusMuxIn_HI;
        5'd17: BusMuxOut <= BusMuxIn_LO;
        5'd18: BusMuxOut <= BusMuxIn_Z_HI;
        5'd19: BusMuxOut <= BusMuxIn_Z_LO;
        5'd20: BusMuxOut <= BusMuxIn_PC;
        5'd21: BusMuxOut <= BusMuxIn_MDR;
        // 5'd22: BusMuxOut <= BusMuxIn_IN_PORT;
        // 5'd23: BusMuxOut <= C_Sign_Extended;
        default:
            BusMuxOut <= 32'd0;
    endcase
end

endmodule

