module mux2x1 (a,b,sel,y);
	input [15:0] a,b;
	input sel;
	output reg [15:0] y;
	always@(*) begin
		if(~sel) begin 
			y = a;
		end
		else begin 
			y = b; 
		end
	end
endmodule