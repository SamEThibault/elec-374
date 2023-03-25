`timescale 1ns/10ps
module control_unit_tb;

reg clk, reset, stop;
wire[31:0] in_port_data_in, out_port_data_out, MuxOut;
wire [4:0] opcode;

Datapath DUT(
	.clk(clk),
    .stop(stop),
	.reset(reset),

	.in_port_data_in(in_port_data_in),
	.out_port_data_out(out_port_data_out),

	.opcode(opcode),
	.MuxOut(MuxOut)
);

initial
begin
    clk = 0;
    forever #10 clk =~ clk;
end
endmodule