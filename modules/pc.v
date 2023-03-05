module pc ( output reg[31:0] PC_data_out, input clk, input incPC, input enable);
// add muxout as a final parameter for jump instructions
initial
begin
PC_data_out = 0;
end
always@(posedge clk)
    begin
        if(incPC == 1 && enable == 1)
            PC_data_out <= PC_data_out + 1;
            // for branch instructions
        // else if(enable == 1)
        //     PC_data_out <= inputPC;
    end

endmodule