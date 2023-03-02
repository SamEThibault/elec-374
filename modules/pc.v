module pc #(parameter initQ = 0)( output reg[31:0] pc_out, input clk, input incPC, input enable, input [31:0] inputPC);

initial pc_out = initQ;

always@(posedge clk)
    begin
        if(incPC == 1 && enable == 1)
            pc_out <= pc_out + 1;
        else if(enable == 1)
            pc_out <= inputPC;
    end

endmodule