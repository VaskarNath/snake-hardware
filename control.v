module control(
    input clock,
	 input up,
	 input down,
	 input right,
	 input left,
	 input w,
	 input a,
	 input s,
	 input d,
	 input endgame,
	 input resetn,
	 input start,

	 output clock_15,
	 output reg keyboard,
	 output reg [1:0] keyboard_arrow,
	 output reg keyboard1,
	 output reg [1:0] keyboard_arrow1,
	 output reg move,
	 output reg move_fruit,
	 output reg output_signal,
	 output reg [7:0] counter_x,
	 output reg [6:0] counter_y,
	 output reg [6:0] counter_j,
	 output reg [6:0] counter_j1,
	 output reg [3:0] counter_h,
	 output reg [3:0] counter_v0,
	 output reg [3:0] counter_v1,
	 output reg [3:0] counter_v2,

	 output reg [3:0] select
    );
	 
	 
	 wire clock60;
	 
	 sixtycounter s0(
	.clock(clock),
	.resetn(resetn),
	.enable(clock_15)
	);
	
	framecounter f0(
	.clock(clock),
	.resetn(resetn),
	.output_s(clock60)
	);
	
	wire [6:0] max_j;
	wire [7:0] max_x;
	wire [6:0] max_y;
	wire [3:0] max_h;
	wire [3:0] max_v;

	assign max_j = 99;
	assign max_h = 9;
	assign max_v = 9;

	assign max_x = 179;
	assign max_y = 119;
	
	always @(posedge clock)
	begin
		if (resetn == 1'b0)
			begin
			counter_h <= max_h;
			end

		else
		begin 
			if(current_state == S_DRAW_H)
			begin 
				if (counter_h == 0)
				begin
					counter_h <= max_h;
				end
				else
					counter_h <= counter_h - 1;
			end
		end
	end
	
	always @(posedge clock)
	begin
		if (resetn == 1'b0)
			begin
			counter_v0 <= max_v;
			end

		else
		begin 
			if(current_state == S_DRAW_V0)
			begin 
				if (counter_v0 == 0)
				begin
					counter_v0 <= max_v;
				end
				else
					counter_v0 <= counter_v0 - 1;
			end
		end
	end
	
		always @(posedge clock)
	begin
		if (resetn == 1'b0)
			begin
			counter_v1 <= max_v;
			end

		else
		begin 
			if(current_state == S_DRAW_V1)
			begin 
				if (counter_v1 == 0)
				begin
					counter_v1 <= max_v;
				end
				else
					counter_v1 <= counter_v1 - 1;
			end
		end
	end
	
		always @(posedge clock)
	begin
		if (resetn == 1'b0)
			begin
			counter_v2 <= max_v;
			end

		else
		begin 
			if(current_state == S_DRAW_V2)
			begin 
				if (counter_v2 == 0)
				begin
					counter_v2 <= max_v;
				end
				else
					counter_v2 <= counter_v2 - 1;
			end
		end
	end
	
	always @(posedge clock)
	begin
		if (resetn == 1'b0)
			begin
			counter_j <= max_j;
			end

		else
		begin 
			if(current_state == S_DRAW)
			begin 
				if (counter_j == 0)
				begin
					counter_j <= max_j;
				end
				else
					counter_j <= counter_j - 1;
			end
		end
	end
	
	always @(posedge clock)
	begin
		if (resetn == 1'b0)
			begin
			counter_j1 <= max_j;
			end

		else
		begin 
			if(current_state == S_DRAW1)
			begin 
				if (counter_j1 == 0)
				begin
					counter_j1 <= max_j;
				end
				else
					counter_j1 <= counter_j1 - 1;
			end
		end
	end
		
	always @(posedge clock)
	begin
		if (resetn == 1'b0)
			begin
			counter_x <= 0;
			counter_y <= 0;
			end

		else
		begin 
			if(current_state == S_ERASE || current_state == S_RESET_ERASE || current_state == S_END_GAME)
			begin 
				if (counter_x == 159 & counter_y == 119)
				begin
					counter_x <= 0;
					counter_y <= 0;
				end
				else
				begin
					if (counter_x == 159)
					begin
						counter_x <= 0;
						counter_y <= counter_y + 1;
					end
					else
					begin
						counter_x <= counter_x + 1;
					end
				end
					
			end
		end
	end
	
		

    reg [3:0] current_state, next_state;
    
    localparam  S_START = 0,
	 				 S_ERASE = 1,
					 S_DRAW_H = 2,
					 S_DRAW_V0 = 3,
					 S_DRAW_V1 = 4,
					 S_DRAW_V2 = 5,
					 S_PRINT_FRUIT = 6,
					 S_PRINT_MOVING_FRUIT = 7,
					 S_DRAW = 8,
					 S_DRAW1 = 9,
					 S_MOVE = 10,
					 S_WAIT = 11,
					 S_RESET_ERASE = 12,
					 S_END_GAME = 13;
    
    // Next state logic
    always@(*)
    begin: state_table 
            case (current_state)
					 S_START: next_state =  start ? S_START : S_ERASE;
					 
					 S_ERASE: 
					  begin
						if (counter_x == 159 & counter_y == 119)
						begin
							next_state = S_DRAW_H;
						end
						else
							next_state = S_ERASE; 
					 end
					 
					 S_DRAW_H:
					 begin
						if (counter_h == 0)
						begin
							next_state = S_DRAW_V0;
						end
						else
							next_state = S_DRAW_H; 
					 end
					 
					 S_DRAW_V0:
					 begin
						if (counter_v0 == 0)
						begin
							next_state = S_DRAW_V1;
						end
						else
							next_state = S_DRAW_V0; 
					 end
					 
					 
					 S_DRAW_V1:
					 begin
						if (counter_v1 == 0)
						begin
							next_state = S_DRAW_V2;
						end
						else
							next_state = S_DRAW_V1; 
					 end
					 
					 S_DRAW_V2:
					 begin
						if (counter_v2 == 0)
						begin
							next_state = S_PRINT_FRUIT;
						end
						else
							next_state = S_DRAW_V2; 
					 end
							 
					 
					 S_PRINT_FRUIT: next_state = S_PRINT_MOVING_FRUIT;
					 
					 S_PRINT_MOVING_FRUIT: next_state = S_DRAW;
					 
					 S_END_GAME: 
					  begin
						if (counter_x == 159 & counter_y == 119)
						begin
							next_state = S_START;
						end
						else
							next_state = S_END_GAME; 
					 end
					 
					 S_RESET_ERASE: 
					  begin
						if (counter_x == 159 & counter_y == 119)
						begin
							next_state = S_START;
						end
						else
							next_state = S_RESET_ERASE; 
					 end
					 
					 S_WAIT: next_state = clock_15 ? S_ERASE : S_WAIT;
					 
					 S_MOVE: next_state = S_WAIT;
					 
					 S_DRAW:
					 begin
						if (counter_j == 0)
						begin
							next_state = S_DRAW1;
						end
						else
							next_state = S_DRAW; 
					 end
					 
					 S_DRAW1:
					 begin
						if (counter_j1 == 0)
						begin
							next_state = S_MOVE;
						end
						else
							next_state = S_DRAW1; 
					 end
					 default: next_state = S_START;
        endcase
    end

    // Output logic
    always @(*)
    begin: enable_signals
			move = 0;
			output_signal = 0;
			select = 0;
			move_fruit = 0;

        case (current_state)
			S_MOVE:
				begin
				move = 1;
				move_fruit = 1;
				end
			S_DRAW:
				begin
				output_signal = 1;
				end
			S_DRAW1:
				begin
				output_signal = 1;
				select = 8;
				end
			S_DRAW_H:
				begin
				output_signal = 1;
				select = 3;
				end
			S_DRAW_V0:
				begin
				output_signal = 1;
				select = 4;
				end
			S_DRAW_V1:
				begin
				output_signal = 1;
				select = 5;
				end
			S_DRAW_V2:
				begin
				output_signal = 1;
				select = 6;
				end
			S_ERASE:
				begin
				output_signal = 1;
				select = 1;
				end
			S_PRINT_FRUIT:
				begin
				output_signal = 1;
				select = 2;
				end
			S_PRINT_MOVING_FRUIT:
				begin
				output_signal = 1;
				select = 7;
				end
			S_RESET_ERASE:
				begin
				output_signal = 1;
				select = 1;
				end
			S_END_GAME:
				begin
				output_signal = 1;
				select = 1;
				end
        endcase
    end
	 
always @(*)
	begin
		keyboard = 0;
		keyboard_arrow = 0;
		
		if(up)
		begin
		keyboard = 1; // Up arrow
		keyboard_arrow = 0;
		end
		if(down)
		begin
		keyboard = 1; // Down arrow
		keyboard_arrow = 3;
		end
		if(right)
		begin
		keyboard = 1; // Right arrow
		keyboard_arrow = 1;
		end
		if(left)
		begin
		keyboard = 1; // Left arrow
		keyboard_arrow = 2;
		end					
    end
	 
always @(*)
	begin
		keyboard1 = 0;
		keyboard_arrow1 = 0;
		
		if(w)
		begin
		keyboard1 = 1; // Up arrow
		keyboard_arrow1 = 0;
		end
		if(s)
		begin
		keyboard1 = 1; // Down arrow
		keyboard_arrow1 = 3;
		end
		if(d)
		begin
		keyboard1 = 1; // Right arrow
		keyboard_arrow1 = 1;
		end
		if(a)
		begin
		keyboard1 = 1; // Left arrow
		keyboard_arrow1 = 2;
		end					
    end
	 
	 // current_state registers
    always @(posedge clock)
    begin: state_FFs
		if (!resetn)
			current_state <= S_RESET_ERASE;
		else
			if (endgame)
				current_state <= S_END_GAME;
			else
				current_state <= next_state;
    end
	    
endmodule