module v_obstacle(
	input resetn, 
	input clock, 
	input move,
	input display_v,
	input [7:0] default_x,
	input [3:0] v,
	input [7:0] head_x,
	input [7:0] head_y,
	input [7:0] head_x1,
	input [7:0] head_y1,
	
	output reg endgamev,
	output  [7:0] vout_x,
	output  [6:0] vout_y
	);
	
	wire [7:0] x;
	
	assign x = default_x;
	
	reg reg_direction; // direction the snake is travelling in: 0 up, 1 down
		
	reg [6:0] array_y [0:9];
	
	assign vout_y = array_y[v];
	assign vout_x = x;
	integer i;
	
	always @(posedge clock)
	begin
		if (!resetn)
		begin
			
			reg_direction <= 1;

			for(i = 0; i < 10; i = i + 1)
			begin
				array_y[i] <= i;
			end
		end
		else 
		begin
			if(move)
			begin
				for(i = 9; i >= 0; i = i - 1)
				if (reg_direction == 1)
				begin
					array_y[i] <= array_y[i] + 1;
				end
				else
				begin
					array_y[i] <= array_y[i] - 1;
				end
			end
			if (array_y[0] == 0)
				reg_direction <= 1;
			if (array_y[9] == 119)
				reg_direction <= 0;
		end	
	end
	
	always @(posedge clock)
	begin
		if (!resetn)
		begin
			endgamev <= 0;
		end
		else
		begin
			for(i = 0; i < 10; i = i + 1)
			begin
				if ((array_y[i] == head_y & x == head_x) || (array_y[i] == head_y1 & x == head_x1))
				begin
					endgamev <= 1;
				end
			end	
		end
	end
endmodule