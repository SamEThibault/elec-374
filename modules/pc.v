module pc #(parameter INIT_VAL) (output reg[31:0] PC_data_out, input clk, input IncPC, input PC_enable, input [31:0] MuxOut, input con_out);
// add muxout as a final parameter for jump instructions

initial
begin
PC_data_out = INIT_VAL;
end

always@(posedge clk)
    begin

        // if(IncPC == 1)
        // begin
        //     PC_data_out <= PC_data_out + 1;
        // end
        // else if(PC_enable == 1 && con_out  == 1)
        //     PC_data_out <= (MuxOut + 1); //C (sign extended + 1)
        // else if(PC_enable == 1)
        //     PC_data_out <= (MuxOut + 1);

        if(IncPC === 1 && PC_enable === 1)
			PC_data_out = PC_data_out + 1;
		else if (PC_enable == 1 && con_out == 1)
			PC_data_out <= MuxOut;
    end

endmodule