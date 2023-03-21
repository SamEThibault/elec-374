module mdr(output [31:0] MDRdataout, input [31:0] BusMuxOut, Mdatain, input read_signal, clk, clr, enable);
    
    wire[31:0] MDMux_out;
    
    mux_2_to_1 mux_out(.out(MDRdataout), .input_0(BusMuxOut), .input_1(Mdatain), .signal(read_signal));
    reg_32_bit mdr_reg(MDRdataout, MDMux_out, clk, clr, enable);
endmodule