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
    mem[0] = 32'h00800075; // ld R1, $75 => 00800075 =>  0000 0000 1000 0000 0000 0000 0111 0101
    mem[1] = 32'h00080045; // ld R0, $45(R1) 
    mem[2] = 32'h08800075; // ldi R1, $75 => 08800075 =>  0000 1000 1000 0000 0000 0000 0111 0101
    mem[3] = 32'h08080045; // ldi R0, $45(R1) 08080045 => 0000 1000 0000 1000 0000 0000 0100 0101  + 1 = 0000 1000 0000 1000 0000 0000 0100 0110
    mem[4] = 32'h12000090; // st $90, R4
    mem[5] = 32'h12200090; // st $90 (R4), R4
    mem[6] = 32'h611FFFFD; // addi R2, R3, -3
    mem[7] = 32'h9B000019; // ori R2, R3, $25
    mem[8] = 32'h9B000019; //brzr R6, 25
    mem[9] = 32'h9B080019; //brnz R6, 25
    mem[10] = 32'h9B100019; //brpl R6, 25
    mem[11] = 32'h9B180019; //brmi R6, 25
    mem[12] = 32'hA1000000; //jr R2
    mem[13] = 32'hA9000000; //jal R2
    mem[14] = 32'hC2000000; //mfhi R4
    mem[15] = 32'hCB000000; //mflo R6
    mem[16] = 32'hB1800000; //in R3
    mem[17] = 32'h00000000;
    mem[18] = 32'h00000000;
    mem[19] = 32'h69180025; // andi R2, R3, $25 ($25 = 0000000000000100101)
    // DATA VALUES
    mem[70] =  32'hFFFFFFF0; // Value at $45 + 1
    mem[117] = 32'hFFFFFFF0; //Value at $75 (hex) => 117 decimal
    mem[144] = 32'h67;
    mem[247] = 32'h67;

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
