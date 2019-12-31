module snake(
	input resetn, 
	input clock, 
	input keyboard, 
	input [1:0] keyboard_arrow, 
	input move,
	input display,
	input [6:0] j,
	input increase_size,
	input moving_increase_size,
	
	output [7:0] head_x,
	output [7:0] head_y,
	output reg endgame,
	output  [7:0] out_x,
	output  [7:0] out_y,
	output out_valid
	);
	
	reg [1:0] reg_direction; // direction the snake is travelling in: 00 up, 01 right, 11 down, 10 left
		
	reg [7:0] array_x [0:99];
	reg [6:0] array_y [0:99];
	reg array_valid   [0:99];
	
	
	assign out_x = array_x[j];
	assign out_y = array_y[j];
	assign out_valid = array_valid[j];
	assign head_x = array_x[0];
	assign head_y = array_y[0];
	integer i;
	
	always @(posedge clock)
	begin
		if (!resetn)
		begin
			
			reg_direction <= 1;

			for(i = 0; i < 100; i = i + 1)
			begin
				array_x[i] <= 80 - i;
				array_y[i] <= 60;
				if (i < 10)
					array_valid[i] <= 1;
				else
					array_valid[i] <= 0;
			end
		end
		else 
		begin
			if (increase_size)
			begin
				for(i = 99; i > 1; i = i - 1)
				begin
					array_valid[i] <= array_valid[i-2];
				end
			array_valid[0] <= 1;
			array_valid[1] <= 1;
			end
			if (moving_increase_size)
			begin
				for(i = 99; i > 4; i = i - 1)
				begin
					array_valid[i] <= array_valid[i-5];
				end
			array_valid[0] <= 1;
			array_valid[1] <= 1;
			array_valid[2] <= 1;
			array_valid[3] <= 1;
			array_valid[4] <= 1;
			end
			
			if(move)
			begin		
				for(i = 99; i > 0; i = i - 1)
					begin
						array_x[i] <= array_x[i-1];
						array_y[i] <= array_y[i-1];
					end
			
				if (keyboard  & (reg_direction != ~keyboard_arrow))
				begin
					reg_direction <= keyboard_arrow;
		
					case (keyboard_arrow)
						0: array_y[0] <= array_y[0] - 1;
						1: array_x[0] <= array_x[0] + 1;
						2: array_x[0] <= array_x[0] - 1;
						3: array_y[0] <= array_y[0] + 1;
					endcase
				end
				else
				begin
					case (reg_direction)
						0: array_y[0] <= array_y[0] - 1;
						1: array_x[0] <= array_x[0] + 1;
						2: array_x[0] <= array_x[0] - 1;
						3: array_y[0] <= array_y[0] + 1;
					endcase
				end
			end
		end	
	end
	
	always @(posedge clock)
	begin
		if (!resetn)
		begin
			endgame <= 0;
		end
		else
		begin
			if (array_x[0] == 0 & reg_direction == 2| array_x[0] == 159 & reg_direction == 1 | array_y[0] == 0 & reg_direction == 0 | array_y[0] == 119 & reg_direction == 3)
				endgame <= 1;
			else
				endgame <= 0;
				for(i = 99; i > 0; i = i - 1)
					begin
					if (array_x[0] == array_x[i] & array_y[0] == array_y[i] & array_valid[i] == 1)
						endgame <= 1;
					end
				
		end
	end
	
endmodule
