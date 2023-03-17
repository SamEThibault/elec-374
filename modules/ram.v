module ram(
    output reg [31:0] RAM_data_out,
    input [31:0] RAM_data_in,
    input [8:0] address,
    input wire clk,
    input write_enable, read_enable
);
 
//Note the address will always be log_2(data_in_size). 
//SO 32 bit data size means 5 bit address size because 5^2 addressable locations

reg [31:0] mem [511:0]; //[Size] name [quantity]

initial begin
    // $readmemb("mem_init.mif", mem); //Read the memory contents of MIF file and initialize memory
    
    mem[0] = 32'h00800075; // ld R1, $75
    mem[1] = 32'h00080045; // ld R0, $45(R1)
    mem[2] = 32'h08800075; // ldi R1, $75
    mem[3] = 32'h08080045; // ldi R0, $45(R1)
    mem[3] = 32'h12000090; // st $90, R4
    mem[4] = 32'h12200090; // st $90 (R4), R4
    mem[5] = 32'h9B000019; // addi R2, R3, -3
    mem[6] = 32'h9B000019; // ori R2, R3, $25
    mem[7] = 32'h9B000019; //brzr R6, 25
    mem[8] = 32'h9B080019; //brnz R6, 25
    mem[9] = 32'h9B100019; //brpl R6, 25
    mem[10] = 32'h9B180019; //brmi R6, 25
    mem[11] = 32'hA1000000; //jr R2
    mem[12] = 32'hA9000000; //jal R2
    mem[13] = 32'hC2000000; //mfhi R4
    mem[14] = 32'hCB000000; //mflo R6
    mem[15] = 32'hB1800000; //in R3
    mem[16] = 32'h00000000;
    mem[17] = 32'h00000000;

end


always @(posedge clk) begin

    // Write the RAM_data_in to memory only when the write enable signal is on
    if (write_enable) begin
        mem[address] <= RAM_data_in;
    end

    //Write data out if read signal is enabled
    if(read_enable) begin
        RAM_data_out <= mem[address]; //Read data from the memory address on every clock cycle
    end
end

endmodule
