module ram(
    output reg [7:0] data_out
    input [31:0] data_in,
    input [4:0] address,
    input wire clk,
    input write_enable,
    input read_enable,
);

//Note the address will always be log_2(data_in_size). 
//SO 32 bit data size means 5 bit address size because 5^2 addressable locations

reg [31:0] mem [511:0]; //[Size] name [quantity]

initial begin
    $readmemb("mem_init.mif", mem); //Read the memory contents of MIF file and initialize memory
end

always @(posedge clk) begin

    // Write the data_in to memory only when the write enable signal is on
    if (write_enable) begin
        mem[address] <= data_in;
    end

    //Write data out if read signal is enabled
    if(read_enable) begin
        data_out <= mem[address]; //Read data from the memory address on every clock cycle
    end
end

endmodule