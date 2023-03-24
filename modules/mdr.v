module mdr(output [31:0] MDRdataout, input [31:0] MuxOut, Mdatain, input read_signal, clk, clr, enable);
    
    wire[31:0] MDMux_out;
    
    mux_2_to_1 mux_out(.out(MDMux_out), .input_0(MuxOut), .input_1(Mdatain), .signal(read_signal));
    reg_32_bit mdr_reg(.q(MDRdataout), .d(MDMux_out), .clk(clk), .clr(clr), .enable(enable));
endmodule