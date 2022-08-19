module control (instr,sa,sb,dest,alu_b,imm,alu_op,rf_write_en,mem_read,mem_write,mem_or_alu,ex_pass,jump,branch,start);
    input [15:0] instr;
    //output reg [9:0] ctrl;
    output reg [ 2:0] sa,sb,dest;
    output reg [ 1:0] ex_pass,alu_b,imm,jump;
    output reg [ 5:0] alu_op;
    output reg rf_write_en,mem_read,mem_write,mem_or_alu,branch,start;
    //reg [9:0] instr_buffer [1:4];
    //reg [9:0] control;
    wire [ 3:0] opcode;
    wire [ 2:0] ra,rb,rc;
    wire [ 1:0] condition;
	wire [ 5:0] alu_in;
    

    assign opcode = instr[15:12];
    assign ra = instr[11:9];
    assign rb = instr[ 8:6];
    assign rc = instr[ 5:3];
    assign condition = instr[1:0];
	assign alu_in = {opcode,condition};
    //assign control = {alu_b,alu_op,rf_write_en,mem_read,mem_write,mem_or_alu,ex_pass};
    //                 9 8  7 6 5       4         3         2        1          0        
    //assign ctrl = {instr_buffer[2][10:9],instr_buffer[2][7:5],instr_buffer[10:9],instr_buffer[10:9],instr_buffer[10:9],instr_buffer[10:9],instr_buffer[10:9],};

    // always@(posedge clk) begin
    //     instr_buffer[4] = instr_buffer[3];  // Write Back
    //     instr_buffer[3] = instr_buffer[2];  // Memory Access
    //     instr_buffer[2] = instr_buffer[1];  // Execution
    //     instr_buffer[1] = control;          // Register read
    // end
    
    always@(alu_in) begin
        casex(alu_in)
        6'b0000xx: begin        // ADI
            alu_b = 2'b10;
            rf_write_en = 1'b1;
            mem_read = 1'b0;
            mem_write = 1'b0;
            mem_or_alu = 1'b1;
            alu_op = 6'b000011;
            ex_pass = 2'b01;
            sa = ra;
            sb = rb;
            dest = rb;
			imm = 2'b00;
			jump = 2'b00;
			branch = 1'b0;
			start = 1'b0;
        end
        6'b000100: begin        // ADD
            alu_b = 2'b01;
            rf_write_en = 1'b1;
            mem_read = 1'b0;
            mem_write = 1'b0;
            mem_or_alu = 1'b1;
			alu_op = 6'b000011;
            ex_pass = 2'b01;
            sa = ra;
            sb = rb;
            dest = rc;
			imm = 2'b00;
			jump = 2'b00;
			branch = 1'b0;
			start = 1'b0;
        end
        6'b000101: begin        // ADZ
			alu_b = 2'b01;
			rf_write_en = 1'b1;
			mem_read = 1'b0;
			mem_write = 1'b0;
			mem_or_alu = 1'b1;
			alu_op = 6'b010011;
			ex_pass = 2'b01;
			sa = ra;
			sb = rb;
			dest = rc;
			imm = 2'b00;
			jump = 2'b00;
			branch = 1'b0;
			start = 1'b0;
        end
        6'b000110: begin        // ADC
			alu_b = 2'b01;
			rf_write_en = 1'b1;
			mem_read = 1'b0;
			mem_write = 1'b0;
			mem_or_alu = 1'b1;
			alu_op = 6'b100011;
			ex_pass = 2'b01;
			sa = ra;
			sb = rb;
			dest = rc;
			imm = 2'b00;
			jump = 2'b00;
			branch = 1'b0;
			start = 1'b0;
        end
        6'b000111: begin        // ADL
            alu_b = 2'b00;
            rf_write_en = 1'b1;
            mem_read = 1'b0;
            mem_write = 1'b0;
            mem_or_alu = 1'b1;
			alu_op = 6'b000011;
            ex_pass = 2'b01;
            sa = ra;
            sb = rb;
            dest = rc;
			imm = 2'b00;
			jump = 2'b00;
			branch = 1'b0;
			start = 1'b0;
        end
        6'b001000: begin        // NDU
            alu_b = 2'b01;
            rf_write_en = 1'b1;
            mem_read = 1'b0;
            mem_write = 1'b0;
            mem_or_alu = 1'b1;
			alu_op = 6'b000101;
            ex_pass = 2'b01;
            sa = ra;
            sb = rb;
            dest = rc;
			imm = 2'b00;
			jump = 2'b00;
			branch = 1'b0;
			start = 1'b0;
        end
        6'b001010: begin        // NDC
			alu_b = 2'b01;
			rf_write_en = 1'b1;
			mem_read = 1'b0;
			mem_write = 1'b0;
			mem_or_alu = 1'b1;
			alu_op = 6'b100101;
			ex_pass = 2'b01;
			sa = ra;
			sb = rb;
			dest = rc;
			imm = 2'b00;
			jump = 2'b00;
			branch = 1'b0;
			start = 1'b0;
        end
        6'b001001: begin        // NDZ
			alu_b = 2'b01;
			rf_write_en = 1'b1;
			mem_read = 1'b0;
			mem_write = 1'b0;
			mem_or_alu = 1'b1;
			alu_op = 6'b010101;
			ex_pass = 2'b01;
			sa = ra;
			sb = rb;
			dest = rc;
			imm = 2'b00;
			jump = 2'b00;
			branch = 1'b0;
			start = 1'b0;
        end
        6'b0011xx: begin        // LHI
            alu_b = 2'b00;
            rf_write_en = 1'b1;
            mem_read = 1'b0;
            mem_write = 1'b0;
            mem_or_alu = 1'b1;
			alu_op = 6'b000000;
            ex_pass = 2'b10;
            sa = ra;
            sb = rb;
            dest = ra;
			imm = 2'b01;
			jump = 2'b00;
			branch = 1'b0;
			start = 1'b0;
        end
        6'b0100xx: begin        // LW
            alu_b = 2'b10;
            rf_write_en = 1'b1;
            mem_read = 1'b1;
            mem_write = 1'b0;
            mem_or_alu = 1'b0;
			alu_op = 6'b000001;
            ex_pass = 2'b01;
            sa = rb;
            sb = rb;
            dest = ra;
			imm = 2'b00;
			jump = 2'b00;
			branch = 1'b0;
			start = 1'b0;
        end
        6'b0101xx: begin        // SW
            alu_b = 2'b10;
            rf_write_en = 1'b0;
            mem_read = 1'b0;
            mem_write = 1'b1;
            mem_or_alu = 1'b0;
			alu_op = 6'b000000;
            ex_pass = 2'b01;
            sa = rb;
            sb = ra;
            dest = ra;
			imm = 2'b00;
			jump = 2'b00;
			branch = 1'b0;
			start = 1'b0;
        end
        6'b0110xx: begin        // NOT HERE        
            alu_b = 2'b10;
            rf_write_en = 1'b1;
            mem_read = 1'b0;
            mem_write = 1'b0;
            mem_or_alu = 1'b0;
            alu_op = 1'b0;
        end
        6'b0111xx: begin        // NOT HERE 
            alu_b = 2'b10;
            rf_write_en = 1'b1;
            mem_read = 1'b0;
            mem_write = 1'b0;
            mem_or_alu = 1'b0;
            alu_op = 1'b0;
        end
        6'b1000xx: begin        // BEQ
            alu_b = 2'b01;
            rf_write_en = 1'b0;
            mem_read = 1'b0;
            mem_write = 1'b0;
            mem_or_alu = 1'b0;
			alu_op = 6'b001011;
            ex_pass = 2'b01;
            sa = ra;
            sb = rb;
            dest = ra;
			imm = 2'b00;
			jump = 2'b00;
			branch = 1'b1;
        end
        6'b1001xx: begin        // JAL
            alu_b = 2'b10;
            rf_write_en = 1'b1;
            mem_read = 1'b0;
            mem_write = 1'b0;
            mem_or_alu = 1'b1;
			alu_op = 6'b000000;
            ex_pass = 2'b00;
            sa = ra;
            sb = rb;
            dest = ra;
			imm = 2'b10;
			jump = 2'b01;
			branch = 1'b0;
        end
        6'b1010xx: begin        // JLR
            alu_b = 2'b01;
            rf_write_en = 1'b1;
            mem_read = 1'b0;
            mem_write = 1'b0;
            mem_or_alu = 1'b1;
			alu_op = 6'b000000;
            ex_pass = 2'b00;
            sa = ra;
            sb = rb;
            dest = ra;
			imm = 2'b00;
			jump = 2'b10;
			branch = 1'b0;
        end
        6'b1011xx: begin        // JRI
            alu_b = 2'b10;
            rf_write_en = 1'b0;
            mem_read = 1'b0;
            mem_write = 1'b0;
            mem_or_alu = 1'b1;
			alu_op = 6'b000000;
            ex_pass = 2'b01;
            sa = ra;
            sb = rb;
            dest = ra;
			imm = 2'b10;
			jump = 2'b11;
			branch = 1'b0;
        end
        6'b1100xx: begin        // LM
            alu_b = 2'b10;
            rf_write_en = 1'b1;
            mem_read = 1'b0;
            mem_write = 1'b0;
            mem_or_alu = 1'b0;
            alu_op = 1'b0;
        end
        6'b1101xx: begin        // SM
            alu_b = 2'b10;
            rf_write_en = 1'b0;
            mem_read = 1'b0;
            mem_write = 1'b1;
            mem_or_alu = 1'b0;
			alu_op = 6'b000000;
            ex_pass = 2'b01;
            sa = ra;
            sb = rb;
            dest = ra;
			imm = 2'b00;
			jump = 2'b00;
			branch = 1'b0;
			start = 1'b0;
			
        end
        6'b1110xx: begin        // LA
            alu_b = 2'b10;
            rf_write_en = 1'b1;
            mem_read = 1'b0;
            mem_write = 1'b0;
            mem_or_alu = 1'b0;
            alu_op = 1'b0;
        end
        6'b1111xx: begin        // SA
            alu_b = 2'b11;
            rf_write_en = 1'b0;
            mem_read = 1'b0;
            mem_write = 1'b1;
            mem_or_alu = 1'b0;
			alu_op = 6'b000000;
            ex_pass = 2'b01;
            sa = ra;
            sb = 3'b000;
            dest = ra;
			imm = 2'b00;
			jump = 2'b00;
			branch = 1'b0;
			start = 1'b1;
        end
        default: begin
            alu_b = 2'b11;
            rf_write_en = 1'b0;
            mem_read = 1'b0;
            mem_write = 1'b1;
            mem_or_alu = 1'b0;
			alu_op = 6'b000000;
            ex_pass = 2'b01;
            sa = ra;
            sb = 3'b000;
            dest = ra;
			imm = 2'b00;
			jump = 2'b00;
			branch = 1'b0;
			start = 1'b1;
        end
        endcase
    end
endmodule