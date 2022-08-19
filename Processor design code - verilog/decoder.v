module decoder(
input clk,
input [16-1:0] instruction,
output reg [4-1:0] opcode,
output reg [2-1:0] func,
output reg [3-1:0] reg_ra,
output reg [3-1:0] reg_rb,
output reg [3-1:0] reg_rc,
output reg [16-1:0] imm_data_se,
output reg [8-1:0] reg_select_word,
output reg [16-1:0] addr_offset
);


always@(posedge clk) begin

opcode  = instruction[15:12];

case (opcode)  
  4'b0000 : begin //ADI
  				reg_ra = instruction[11:10];
				reg_rb = instruction[9:8];
				imm_data_se = {{10{instruction[5]}},instruction[5:0]};
				end
				
  4'b0001 : begin //add, adc, adz, adl
  
				reg_ra = instruction[11:10];
				reg_rb = instruction[9:8];
				reg_rc = instruction[7:6];
				func = instruction[1:0];			
				end
			
  4'b0010 : begin //ndu, ndc. ndz
  
				reg_ra = instruction[11:10];
				reg_rb = instruction[9:8];
				reg_rc = instruction[7:6];
				func = instruction[1:0];
				end
				
  4'b0011 : begin //lhi
				reg_ra = instruction[11:10];
				imm_data_se = {instruction[8:0],{7{1'b0}}}; 
				end
				
  4'b0100 : begin //lw
				reg_ra = instruction[11:10];
				reg_rb = instruction[9:8];
				imm_data_se = {{10{instruction[5]}},instruction[5:0]};
				end
				
  4'b0101 : begin //sw
				reg_ra = instruction[11:10];
				reg_rb = instruction[9:8];
				imm_data_se = {{10{instruction[5]}},instruction[5:0]};
				end
				
  4'b1100 : begin //lm
				reg_ra = instruction[11:10];
				reg_select_word = instruction[7:0]; //R0 to R7 from left to wright
				end
				
  4'b1101 : begin //sm
				reg_ra = instruction[11:10];
				reg_select_word = instruction[7:0]; //R0 to R7 from left to wright
				end

  4'b1110 : begin //la
				reg_ra = instruction[11:10];
				end
				
  4'b1111 : begin //sa
				reg_ra = instruction[11:10];
				end
				
  4'b1000 : begin //beq
  				reg_ra = instruction[11:10];
				reg_rb = instruction[9:8];
				addr_offset = {{10{1'b0}},instruction[5:0]};
				end
				
  4'b1001 : begin //jal
				reg_ra = instruction[11:10];
				addr_offset = {{7{1'b0}},instruction[8:0]};
				end
				
  4'b1010 : begin //jlr
				reg_ra = instruction[11:10];
				reg_rb = instruction[9:8];
				end
				
  4'b1011 : begin //jri
				reg_ra = instruction[11:10];
				addr_offset = {{7{1'b0}},instruction[8:0]};
				end
 
  default : begin
				opcode = 4'b0;
				func = 2'b0;
				reg_ra = 3'b0;
				reg_rb = 3'b0;
				reg_rc = 3'b0;
				 imm_data_se = 16'b0;
				reg_select_word = 8'b0;
				 addr_offset = 16'b0;
				end
  

endcase  

end

endmodule