module ram #(parameter init_RAM_data_out = 0)(
    output reg [31:0] RAM_data_out,
    input [31:0] RAM_data_in,
    input [8:0] address,
    input wire clk,
    input write_enable, 
          read_enable
);
 
//Note the address will always be log_2(data_in_size). 
//SO 32 bit data size means 5 bit address size because 5^2 addressable locations

reg [31:0] mem [511:0]; //[Size] name [quantity]

initial begin
    // $readmemb("mem_init.mif", mem); //Read the memory contents of MIF file and initialize memory
    // mem[0] = 32'h00800075; // ld R1, $75 =>   00800075 =>  0000 0000 1000 0000 0000 0000 0111 0101
    // mem[1] = 32'h00080045; // ld R0, $45(R1)  00080045 =>  0000 0000 0000 1000 0000 0000 0100 0101
    // mem[2] = 32'h08800075; // ldi R1, $75 =>  08800075 =>  0000 1000 1000 0000 0000 0000 0111 0101
    // mem[3] = 32'h08080045; // ldi R0, $45(R1) 08080045 =>  0000 1000 0000 1000 0000 0000 0100 0101  + 1 = 0000 1000 0000 1000 0000 0000 0100 0110
    // mem[4] = 32'h12000090; // st $90, R4      12000090 =>  0001 0010 0000 0000 0000 0000 1001 0000
    // mem[5] = 32'h12200090; // st $90 (R4), R4 12200090 =>  0001 0010 0010 0000 0000 0000 1001 0000
    // mem[6] = 32'h611FFFFD; // addi R2, R3, -3
    // mem[7] = 32'h71180025; // ori R2, R3, $25
    // mem[8] = 32'h9B000019; //brzr R6, 25      9B000019 =>  1001 1011 0000 0000 0000 0000 0001 1001
    // mem[9] = 32'h9B080019; //brnz R6, 25
    // mem[10] = 32'h9B100019; //brpl R6, 25
    // mem[11] = 32'h9B180019; //brmi R6, 25
    // mem[12] = 32'hA1000000; //jr R2
    // mem[13] = 32'hA9780000; //jal R2                        1010 1001 0 111 1000 0000 0000 0000 0000
    // mem[14] = 32'hC2000000; //mfhi R4
    // mem[15] = 32'hCB000000; //mflo R6
    // mem[16] = 32'hB1800000; //in R3
    // mem[17] = 32'h00000000;
    // mem[18] = 32'h00000000;
    // mem[19] = 32'h69180025; // andi R2, R3, $25 ($25 = 0000000000000100101)
    // mem[20] = 32'hB9000000; // out R2
    // // DATA VALUES
    // mem[70] =  32'hFFFFFFF0; // Value at $45 + 1
    // mem[117] = 32'hFFFFFFF0; //Value at $75 (hex) => 117 decimal
    // mem[144] = 32'h00000000; //Memory address where R4 (contains $67) will store its contents
    // mem[247] = 32'h00000000; //Memory address where $90(R4) (contains $67) will store its contents

    // phase 3 program instructions loading
    mem[0] = 32'h08800002; // ldi R1, 2 ; R1 = 2
    mem[1] = 32'h08080000; // ldi R0, 0(R1) ; R0 = 2
    mem[2] = 32'h01000068; // ld R2, $68 ; R2 = ($68) = $55
    mem[3] = 32'h0917FFFC; // ldi R2, -4(R2) ; R2 = $51
    mem[4] = 32'h00900001; // ld R1, 1(R2) ; R1 = ($52) = $26
    mem[5] = 32'h09800069; // ldi R3, $69 ; R3 = $69
    mem[6] = 32'h99980004; // brmi R3, 4 ; continue with the next instruction (will not branch)
    mem[7] = 32'h09980002; // ldi R3, 2(R3) ; R3 = $6B
    mem[8] = 32'h039FFFFD; // ld R7, -3(R3) ; R7 = ($6B - 3) = $55
    mem[9] = 32'hD0000000; // nop
    mem[10] = 32'h9B900002; // brpl R7, 2 ; continue with the instruction at “target” (will branch)
    mem[11] = 32'h09000005; // (Done manually, might be wrong tho lol) ldi R2, 5(R0) ; this instruction will not execute
    mem[12] = 32'h09880002; // ldi R3, 2(R1) ; this instruction will not execute
    mem[13] = 32'h19918000; // add R3, R2, R3 ; R3 = $BC <------- THIS IS TARGET
    mem[14] = 32'h63B80002; // addi R7, R7, 2 ; R7 = $57
    mem[15] = 32'h8BB80000; // neg R7, R7 ; R7 = $FFFFFFA9
    mem[16] = 32'h93B80000; // not R7, R7 ; R7 = $56
    mem[17] = 32'h6BB8000F; // andi R7, R7, $0F ; R7 = 6
    // mem[18] = 32'h50880000; // ror R1, R1, R0 ; R1 = $80000009
    // mem[19] = 32'h7388001C; // ori R7, R1, $1C ; R7 = $8000001D
    // mem[20] = 32'h43B80000; // shra R7, R7, R0 ; R7 = $E0000007
    // mem[21] = 32'h39180000; // shr R2, R3, R0 ; R2 = $2F
    // mem[22] = 32'h11000052; // st $52, R2 ; ($52) = $2F new value in memory with address $52
    // mem[23] = 32'h59100000; // rol R2, R2, R0 ; R2 = $BC
    // mem[24] = 32'h31180000; // or R2, R3, R0 ; R2 = $BE
    // mem[25] = 32'h28908000; // and R1, R2, R1 ; R1 = $8
    // mem[26] = 32'h11880060; // st $60(R1), R3 ; ($68) = $BC new value in memory with address $68
    // mem[27] = 32'h21918000; // sub R3, R2, R3 ; R3 = 2
    // mem[28] = 32'h48900000; // shl R1, R2, R0 ; R1 = $2F8
    // mem[29] = 32'h0A000006; // ldi R4, 6 ; R4 = 6
    // mem[30] = 32'h0A800032; // ldi R5, $32 ; R5 = $32
    // mem[31] = 32'h7AA00000; // mul R5, R4 ; HI = 0; LO = $12C
    // mem[32] = 32'hC3800000; // mfhi R7 ; R7 = 0
    // mem[33] = 32'hCB000000; // mflo R6 ; R6 = $12C
    // mem[34] = 32'h82A00000; // div R5, R4 ; HI = 2, LO = 8
    // mem[35] = 32'h0C27FFFF; // ldi R8, -1(R4) ; R8 = 5 setting up argument registers
    // mem[36] = 32'h0CAFFFED; // ldi R9, -19(R5) ; R9 = $1F R8, R9, R10, and R11
    // mem[37] = 32'h0D300000; // ldi R10, 0(R6) ; R10 = $12C
    // mem[38] = 32'h0DB80000; // ldi R11, 0(R7) ; R11 = 0
    // mem[39] = 32'hAD000000; // jal R10 ; address of subroutine subA in R10 - return address in R15
    // mem[40] = 32'hD8000000; // halt, upon return, the program halts

    // // subprogram: procedure subA
    // mem[300] = 32'h1EC50000; // add R13, R8, R10 ; R12 and R13 are return value registers
    // mem[301] = 32'h264D8000; // sub R12, R9, R11 ; R13 = $131, R12 = $1F
    // mem[302] = 32'h26EE0000; // sub R13, R13, R12 ; R13 = $112
    // mem[303] = 32'hA7800000; // jr R15 ; return from procedure

    mem[104] = 32'h00000055;
    mem[82] = 32'h00000026;

    RAM_data_out = init_RAM_data_out;

end


always @(posedge clk) begin

    // Write the RAM_data_in to memory only when the write enable signal is on
    if (write_enable == 1) begin
        mem[address] <= RAM_data_in;
    end

    //Write data out if read signal is enabled
    if(read_enable == 1) begin
        RAM_data_out <= mem[address]; //Read data from the memory address on every clock cycle
    end
end

endmodule
