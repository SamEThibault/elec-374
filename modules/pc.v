module pc #(parameter INIT_VAL) (output reg[31:0] PC_data_out, input clk, input incPC, input enable, input MuxOut);
// add muxout as a final parameter for jump instructions

initial
begin
PC_data_out = INIT_VAL;
end


always@(posedge clk)
    begin
        if(incPC == 1 && enable == 1)
            PC_data_out <= PC_data_out + 1;
        else if(enable == 1)
            PC_data_out <= MuxOut;
    end

endmodule