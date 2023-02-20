module ror_32_bit(
    output reg[31:0] Rz,
    input wire[31:0] Ra,
    input wire[31:0] RotateBits
    
);

always@(*) 
    begin
		case(RotateBits)
				5'd31: 	Rz = {Ra[30:0], Ra[31]};
				5'd30: 	Rz = {Ra[29:0], Ra[31:30]};
				5'd29: 	Rz = {Ra[28:0], Ra[31:29]};
				5'd28: 	Rz = {Ra[27:0], Ra[31:28]};
				5'd27: 	Rz = {Ra[26:0], Ra[31:27]};
				5'd26: 	Rz = {Ra[25:0], Ra[31:26]};
				5'd25: 	Rz = {Ra[24:0], Ra[31:25]};
				5'd24: 	Rz = {Ra[23:0], Ra[31:24]};
				5'd23: 	Rz = {Ra[22:0], Ra[31:23]};
				5'd22: 	Rz = {Ra[21:0], Ra[31:22]};
				5'd21: 	Rz = {Ra[20:0], Ra[31:21]};
				5'd20: 	Rz = {Ra[19:0], Ra[31:20]};
				5'd19: 	Rz = {Ra[18:0], Ra[31:19]};
				5'd18: 	Rz = {Ra[17:0], Ra[31:18]};
				5'd17: 	Rz = {Ra[16:0], Ra[31:17]};
				5'd16:  Rz = {Ra[15:0], Ra[31:16]};
				5'd15:  Rz = {Ra[14:0], Ra[31:15]};
				5'd14:  Rz = {Ra[13:0], Ra[31:14]};
				5'd13:  Rz = {Ra[12:0], Ra[31:13]};
				5'd12:  Rz = {Ra[11:0], Ra[31:12]};
				5'd11:  Rz = {Ra[10:0], Ra[31:11]};
				5'd10:  Rz = {Ra[9:0], Ra[31:10]};
				5'd9:   Rz = {Ra[8:0], Ra[31:9]};
				5'd8:   Rz = {Ra[7:0], Ra[31:8]};
				5'd7:   Rz = {Ra[6:0], Ra[31:7]};
				5'd6:   Rz = {Ra[5:0], Ra[31:6]};
				5'd5:   Rz = {Ra[4:0], Ra[31:5]};
				5'd4:   Rz = {Ra[3:0], Ra[31:4]};
				5'd3:   Rz = {Ra[2:0], Ra[31:3]};
				5'd2:	Rz = {Ra[1:0], Ra[31:2]};
				5'd1:	Rz = {Ra[0], Ra[31:1]};
				default: Rz = Ra;
		endcase
	end   
endmodule