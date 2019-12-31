module h_obstacle(
	input resetn, 
	input clock, 
	input move,
	input display_h,
	input [3:0] h,
	input [7:0] head_x,
	input [7:0] head_y,
	input [7:0] head_x1,
	input [7:0] head_y1,
	
	output reg endgameh,
	output  [7:0] hout_x,
	output  [6:0] hout_y
	);
	
	wire [6:0] y;
	
	assign y = 100;
	
	reg reg_direction; // direction the snake is travelling in: 0 left, 1 right
		
	reg [7:0] array_x [0:9];
	
	assign hout_x = array_x[h];
	assign hout_y = y;
	integer i;
	
	always @(posedge clock)
	begin
		if (!resetn)
		begin
			
			reg_direction <= 1;

			for(i = 0; i < 10; i = i + 1)
			begin
				array_x[i] <= i;
			end
		end
		else 
		begin
			if(move)
			begin
				for(i = 9; i >= 0; i = i - 1)
				if (reg_direction == 1)
				begin
					array_x[i] <= array_x[i] + 1;
				end
				else
				begin
					array_x[i] <= array_x[i] - 1;
				end
			end
			if (array_x[0] == 0)
				reg_direction <= 1;
			if (array_x[9] == 159)
				reg_direction <= 0;
		end	
	end
	
	always @(posedge clock)
	begin
		if (!resetn)
		begin
			endgameh <= 0;
		end
		else
		begin
			for(i = 0; i < 10; i = i + 1)
			begin
				if ((array_x[i] == head_x & y == head_y) || (array_x[i] == head_x1 & y == head_y1))
				begin
					endgameh <= 1;
				end
			end	
		end
	end
endmodule
