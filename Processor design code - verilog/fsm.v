module fsm(clk,start,initial_address,block_fetch,address,address_select,source);
    input clk,start;
    input [15:0] initial_address;
    output reg [2:0] source;
    output reg block_fetch,address_select;
    output reg [15:0] address;
    localparam [3:0] reg0 = 4'b0000, reg1 = 4'b0001, reg2 = 4'b0010, reg3 = 4'b0011;
    localparam [3:0] reg4 = 4'b0100, reg5 = 4'b0101, reg6 = 4'b0110, reg7 = 4'b0111;
    localparam [3:0] stop = 4'b1000;
    reg [3:0] state = reg0, next_state;

    initial begin
        address_select = 1'b1;
        block_fetch = 1'b0;
    end

    always @(posedge clk ) begin
        state = next_state;
    end

    always@(posedge clk) begin
        if(start) begin
            case(state)
            reg0: next_state = reg1;
            reg1: next_state = reg2;
            reg2: next_state = reg3;
            reg3: next_state = reg4;
            reg4: next_state = reg5;
            reg5: next_state = reg6;
            reg6: next_state = reg7;
            reg7: next_state = stop;
			endcase
        end
    end

    always @(posedge clk) begin
        case(state)
        reg0: begin 
            block_fetch = 1'b1;
            source = 3'b000;
            address = initial_address;
            address_select = 1'b1;
        end
        reg1: begin 
            block_fetch = 1'b1;
            source = 3'b001;
            address_select = 1'b0;
            address = address + 3'd1;
        end
        reg2: begin 
            block_fetch = 1'b1;
            source = 3'b010;
            address_select = 1'b0;
            address = address + 3'd1;
        end
        reg3: begin 
            block_fetch = 1'b1;
            source = 3'b011;
            address_select = 1'b0;
            address = address + 3'd1;
        end
        reg4: begin 
            block_fetch = 1'b1;
            source = 3'b100;
            address_select = 1'b0;
            address = address + 3'd1;
        end
        reg5: begin 
            block_fetch = 1'b1;
            source = 3'b101;
            address_select = 1'b0;
            address = address + 3'd1;
        end
        reg6: begin 
            block_fetch = 1'b1;
            source = 3'b101;
            address_select = 1'b0;
            address = address + 3'd1;
        end
        reg7: begin 
            block_fetch = 1'b1;
            source = 3'b110;
            address_select = 1'b0;
            address = address + 3'd1;
        end
        stop: begin 
            block_fetch = 1'b0;
            source = 3'b000;
            address_select = 1'b1;
        end
		endcase
    end

endmodule