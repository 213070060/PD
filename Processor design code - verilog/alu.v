module alu(  
	input reset,
	input          [15:0] a,b,
	input          [ 5:0] alu_control,     //function sel  
	output reg     [15:0] result,          //result       
	output reg carry,zero,write_en);  
	
	wire [16:0] temp;
	assign temp = a + b;
	
	always@(*) begin  
	
		if (reset) begin
			zero = 1'b0;
			carry = 1'b0;
		end
	
		if(alu_control[5]) begin
			if(carry) begin
				write_en = 1'b1;
			end
			else begin
				write_en = 1'b0;
			end
		end
		else begin
			write_en = 1'b1;
		end
		
		if(alu_control[4]) begin
			if(zero) begin
				write_en = 1'b1;
			end
			else begin
				write_en = 1'b0;
			end
		end
		
		if ((alu_control[5] | alu_control[4]) == 1'b0) begin
			write_en = 1'b1;
		end
		
		case(alu_control[3:2]) 
			2'b00: result = a + b; 		// add  
			2'b01: result = ~(a & b); 	// nand  
			2'b10: result = a - b;		// subtract
			default:result = a + b; 	// add  
		endcase  

		if(alu_control[1] == 1) begin
			zero = (result == 16'h0000) ? 1'b1 : 1'b0; 
		end

		if(alu_control[0] == 1) begin
			carry = (temp[16] == 1'b1) ? 1'b1 : 1'b0;
		end	
	end  
endmodule  