module processor(
	input clk,
	input reset,
	output [15:0] pc_out, alu_result);

    // reg [] data_forward_ex_ra;
    // reg [] data_forward_ma_ra;
    // reg [] data_forward_wb_ra;
    // reg [] data_forward_ex_rb;
    // reg [] data_forward_ma_rb;
    // reg [] data_forward_wb_rb;
    
    reg  [15:0] if_id,if_id_pc2;
    reg  [ 2:0] id_rr_sa;
	reg  [ 2:0] id_rr_sb;
	reg  [ 2:0] id_rr_dest;
	reg  [15:0] id_rr_imm,id_rr_pc2;
	reg  [ 1:0] id_rr_ex_pass,id_rr_alu_b,id_rr_jump;
	reg  [ 5:0] id_rr_alu_op;
	reg  		id_rr_rf_write_en,id_rr_mem_read,id_rr_mem_write,id_rr_mem_or_alu,id_rr_branch;
	reg  [ 2:0] rr_ex_dest;
	reg  [15:0] rr_ex_data_a,rr_ex_data_b,rr_ex_imm,rr_ex_pc2;
    reg  [ 1:0] rr_ex_alu_b,rr_ex_ex_pass,rr_ex_jump;
    reg  [ 5:0] rr_ex_alu_op;
	reg  		rr_ex_rf_write_en,rr_ex_mem_read,rr_ex_mem_write,rr_ex_mem_or_alu,rr_ex_branch;
    reg  [15:0] ex_ma_alu_result,ex_ma_imm,ex_ma_data_b;
	reg  [ 2:0] ex_ma_dest;
	reg  		ex_ma_rf_write_en,ex_ma_mem_read,ex_ma_mem_write,ex_ma_alu_or_mem;
    reg  [15:0] ma_wb_data,ma_wb_mem_data;
	reg  [ 2:0] ma_wb_dest;
	reg 		ma_wb_rf_write_en,ex_ma_mem_or_alu;

	reg  [15:0] pc;
	wire [15:0] instruction;
	wire [15:0] imm_data;
	wire [15:0] signed_extended,zero_extended,signed_extended_6;

	wire [15:0] ALU_out,ex_data,data_b;  
	reg  [15:0] execute_result; 

	wire [ 2:0] sa,sb,dest;
    wire [ 1:0] jump,ex_pass,alu_b,imm_ctrl;
    wire [ 5:0] alu_op;
    wire 		rf_write_en,mem_read,mem_write,mem_or_alu,write_en_alu,carry,zero,branch;
	wire [15:0] read_data_a,read_data_b,mem_read_data;
	wire [15:0] write_data;
	wire [15:0] pc_next;
	wire [15:0] pc2;
	assign signed_extended = {{10{if_id[5]}},if_id[5:0]};
	assign zero_extended = {if_id[8:0],{7{1'b0}}};
	assign signed_extended_6 = {{6{if_id[8]}},if_id[8:0]};
	
	// Fetch stage-------------------------------------------------------------------------------------
	instr_mem instruction_mem (pc,instruction);
	assign pc2 = pc + 16'd2;
	//-------------------------------------------------------------------------------------------------
	// Decode Stage------------------------------------------------------------------------------------
	control control_unit (if_id,sa,sb,dest,alu_b,imm_ctrl,alu_op,rf_write_en,mem_read,mem_write,mem_or_alu,ex_pass,jump,branch);
	
	mux4x1 immediate_data_mux (signed_extended,zero_extended,signed_extended_6,16'd0,imm_ctrl,imm_data);
	//-------------------------------------------------------------------------------------------------
	// Register read stage-----------------------------------------------------------------------------
	register_file register (ma_wb_rf_write_en,ma_wb_dest,write_data,id_rr_sa,read_data_a,id_rr_sb,read_data_b);
	//-------------------------------------------------------------------------------------------------
	// Execute stage-----------------------------------------------------------------------------------
	mux4x1 execute_mux ({rr_ex_data_b[14:0],1'b0},rr_ex_data_b,rr_ex_imm,16'd0,rr_ex_alu_b,data_b);
	
	alu alu_unit(reset,rr_ex_data_a,data_b,rr_ex_alu_op,ALU_out,carry,zero,write_en_alu);  

	mux4x1 execution_direct_mux (rr_ex_pc2,ALU_out,rr_ex_imm,16'd0,rr_ex_ex_pass,ex_data);
	
	wire [15:0] pc_imm,pc_temp;
	assign pc_imm = rr_ex_pc2 + {rr_ex_imm[14:0],1'b0};
	wire sel;
	assign sel = rr_ex_branch & zero;
	mux2x1 branch_mux (pc2,pc_imm,sel,pc_temp);
	mux4x1 jump_mux (pc_temp,pc_imm,rr_ex_data_b,ALU_out,({~reset,~reset} & rr_ex_jump),pc_next);
	
	
	
	//-------------------------------------------------------------------------------------------------
	// Memory Access stage-----------------------------------------------------------------------------
	data_memory data_mem_unit (clk,ex_ma_alu_result,ex_ma_data_b,ex_ma_mem_write,ex_ma_mem_read,mem_read_data);
	//-------------------------------------------------------------------------------------------------
	// Write Back stage--------------------------------------------------------------------------------
	mux2x1 write_back_mux (ma_wb_mem_data,ma_wb_data,ex_ma_mem_or_alu,write_data);
	
	always@(posedge clk) begin
		if(reset) begin
			pc = 16'd0;
			//sel = 1'b0;
		end
		else begin
			//pc <= pc + 16'd2;
			//pc2 = pc + 16'd2;
			pc = pc_next;
			if_id <= instruction;				// Instruction to pipelined architecture
			if_id_pc2 <= pc2;		
			//---------------------------------------------------------------------------------------------
			id_rr_sa <= sa; 					// source A
			id_rr_sb <= sb;						// source B
			id_rr_dest <= dest;					// destination
			id_rr_imm <= imm_data;
			id_rr_alu_b <= alu_b;				// alu mux for source B
			id_rr_alu_op <= alu_op;				// alu operations
			id_rr_rf_write_en <= rf_write_en;	// write enable for RF
			id_rr_mem_read <= mem_read;			
			id_rr_mem_write <= mem_write;
			id_rr_mem_or_alu <= mem_or_alu;		// Sabse last wala mux
			id_rr_ex_pass <= ex_pass;			// Direct pass in execution state.
			id_rr_jump <= jump;
			id_rr_branch <= branch;
			id_rr_pc2 <= if_id_pc2;
			//---------------------------------------------------------------------------------------------
			rr_ex_data_a <= read_data_a;
			rr_ex_data_b <= read_data_b;
			rr_ex_dest <= id_rr_dest;
			rr_ex_imm <= id_rr_imm;
			rr_ex_alu_b <= id_rr_alu_b;
			rr_ex_alu_op <= id_rr_alu_op;
			rr_ex_rf_write_en <= id_rr_rf_write_en;
			rr_ex_mem_read <= id_rr_mem_read;
			rr_ex_mem_write <= id_rr_mem_write;
			rr_ex_mem_or_alu <= id_rr_mem_or_alu;
			rr_ex_ex_pass <= id_rr_ex_pass;
			rr_ex_jump <= id_rr_jump;
			rr_ex_branch <= id_rr_branch;
			rr_ex_pc2 <= id_rr_pc2;
			//---------------------------------------------------------------------------------------------
			ex_ma_data_b <= rr_ex_data_b;
			ex_ma_alu_result <= ex_data;
			ex_ma_imm <= rr_ex_imm;
			ex_ma_dest <= rr_ex_dest;
			ex_ma_rf_write_en <= rr_ex_rf_write_en & write_en_alu;
			ex_ma_mem_read <= rr_ex_mem_read;
			ex_ma_mem_write <= rr_ex_mem_write;
			ex_ma_alu_or_mem <= rr_ex_mem_or_alu;
			//---------------------------------------------------------------------------------------------
			ma_wb_data <= ex_ma_alu_result;
			ma_wb_mem_data <= mem_read_data;
			ma_wb_dest <= ex_ma_dest;
			ma_wb_rf_write_en <= ex_ma_rf_write_en;
			ex_ma_mem_or_alu <= ex_ma_alu_or_mem;
			//---------------------------------------------------------------------------------------------
		end
	end

	//decoder decoder1 ( clk,
	//input [16-1:0] instruction,
	//output reg [4-1:0] opcode,
	//output reg [2-1:0] func,
	//output reg [3-1:0] reg_ra,
	//output reg [3-1:0] reg_rb,
	//output reg [3-1:0] reg_rc,
	//output reg [16-1:0] imm_data_se,
	//output reg [8-1:0] reg_select_word,
	//output reg [16-1:0] addr_offset
	//);

	// if (/*immediate control signal*/) begin
	// 	execute_result = imm_data_se;
	// end
	// else begin
	// 	execute_result = ALU_out;
	// end

	// //data hazarding part
	// if(
endmodule