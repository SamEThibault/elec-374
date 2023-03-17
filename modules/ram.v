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
    
    mem[0] = 32'h0983FFFE;
    mem[1] = 32'h0983FFFE;
    mem[2] = 32'h00000000;
    mem[3] = 32'h00000000;
    mem[3] = 32'h00000000;
    mem[4] = 32'h00000000;
    mem[5] = 32'h00000000;
    mem[6] = 32'h00000000;
    mem[7] = 32'h00000000;
    mem[8] = 32'h00000000;
    mem[9] = 32'h00000000;
    mem[10] = 32'h00000000;
    mem[11] = 32'h00000000;
    mem[12] = 32'h00000000;
    mem[13] = 32'h00000000;
    mem[14] = 32'h00000000;
    mem[15] = 32'h00000000;

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