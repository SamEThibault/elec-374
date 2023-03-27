`timescale 1ns/10ps
module control_unit_tb;

reg clk;
reg clr, stop;
wire [31:0] in_port_data_in, out_port_data_out, MuxOut;

Datapath DUT(
	.clk(clk),
    .stop(stop),
	.clr(clr),
	.in_port_data_in(in_port_data_in),
	.out_port_data_out(out_port_data_out),
	.MuxOut(MuxOut)
);

initial
begin
	clr = 0;
    clk = 0;
    forever #10 clk =~ clk;
end
endmodule