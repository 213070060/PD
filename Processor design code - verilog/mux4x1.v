module mux4x1 (in0,in1,in2,in3,sel,y);
	input [15:0] in0,in1,in2,in3;
	input [1:0] sel;
	output reg [15:0] y;
	always@(*) begin
		case(sel)
		2'b00: y = in0;
		2'b01: y = in1;
		2'b10: y = in2;
		2'b11: y = in3;
		endcase
	end
endmodule