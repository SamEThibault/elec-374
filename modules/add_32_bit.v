module add_32_bit(output wire[31:0] c_out, output wire[31:0] s_out, input wire[31:0] x_in, input wire[31:0] y_in, input wire c_in);

full_adder full_adder_bit0(c_out[0], s_out[0], x_in[0], y_in[0], c_in);
full_adder full_adder_bit1(c_out[1], s_out[1], x_in[1], y_in[1], c_out[0]);
full_adder full_adder_bit2(c_out[2], s_out[2], x_in[2], y_in[2], c_out[1]);
full_adder full_adder_bit3(c_out[3], s_out[3], x_in[3], y_in[3], c_out[2]);
full_adder full_adder_bit4(c_out[4], s_out[4], x_in[4], y_in[4], c_out[3]);
full_adder full_adder_bit5(c_out[5], s_out[5], x_in[5], y_in[5], c_out[4]);
full_adder full_adder_bit6(c_out[6], s_out[6], x_in[6], y_in[6], c_out[5]);
full_adder full_adder_bit7(c_out[7], s_out[7], x_in[7], y_in[7], c_out[6]);
full_adder full_adder_bit8(c_out[8], s_out[8], x_in[8], y_in[8], c_out[7]);
full_adder full_adder_bit9(c_out[9], s_out[9], x_in[9], y_in[9], c_out[8]);
full_adder full_adder_bit10(c_out[10], s_out[10], x_in[10], y_in[10], c_out[9]);
full_adder full_adder_bit11(c_out[11], s_out[11], x_in[11], y_in[11], c_out[10]);
full_adder full_adder_bit12(c_out[12], s_out[12], x_in[12], y_in[12], c_out[11]);
full_adder full_adder_bit13(c_out[13], s_out[13], x_in[13], y_in[13], c_out[12]);
full_adder full_adder_bit14(c_out[14], s_out[14], x_in[14], y_in[14], c_out[13]);
full_adder full_adder_bit15(c_out[15], s_out[15], x_in[15], y_in[15], c_out[14]);
full_adder full_adder_bit16(c_out[16], s_out[16], x_in[16], y_in[16], c_out[15]);
full_adder full_adder_bit17(c_out[17], s_out[17], x_in[17], y_in[17], c_out[16]);
full_adder full_adder_bit18(c_out[18], s_out[18], x_in[18], y_in[18], c_out[17]);
full_adder full_adder_bit19(c_out[19], s_out[19], x_in[19], y_in[19], c_out[18]);
full_adder full_adder_bit20(c_out[20], s_out[20], x_in[20], y_in[20], c_out[19]);
full_adder full_adder_bit21(c_out[21], s_out[21], x_in[21], y_in[21], c_out[20]);
full_adder full_adder_bit22(c_out[22], s_out[22], x_in[22], y_in[22], c_out[21]);
full_adder full_adder_bit23(c_out[23], s_out[23], x_in[23], y_in[23], c_out[22]);
full_adder full_adder_bit24(c_out[24], s_out[24], x_in[24], y_in[24], c_out[23]);
full_adder full_adder_bit25(c_out[25], s_out[25], x_in[25], y_in[25], c_out[24]);
full_adder full_adder_bit26(c_out[26], s_out[26], x_in[26], y_in[26], c_out[25]);
full_adder full_adder_bit27(c_out[27], s_out[27], x_in[27], y_in[27], c_out[26]);
full_adder full_adder_bit28(c_out[28], s_out[28], x_in[28], y_in[28], c_out[27]);
full_adder full_adder_bit29(c_out[29], s_out[29], x_in[29], y_in[29], c_out[28]);
full_adder full_adder_bit30(c_out[30], s_out[30], x_in[30], y_in[30], c_out[29]);
full_adder full_adder_bit31(c_out[31], s_out[31], x_in[31], y_in[31], c_out[30]);

endmodule