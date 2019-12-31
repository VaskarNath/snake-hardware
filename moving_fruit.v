module moving_fruit(
	input resetn,
	input clock,
	input [7:0] head_x,
	input [7:0] head_y,
	input [7:0] head_x1,
	input [7:0] head_y1,
	input move_fruit,
	
	output reg [7:0] moving_fruit_x,
	output reg [6:0] moving_fruit_y,
	output reg moving_increase_size
);
	
	wire [7:0] rand_x;
	wire [6:0] rand_y;
	reg [1:0] direction_x;
	reg [1:0] direction_y;
	reg [10:0] counter;
	
	random_number_generator rand1(
	.clock(clock),
	.resetn(resetn),
	.rand_x(rand_x),
	.rand_y(rand_y)
	);
	
	
	
	always @(posedge clock)
	begin
		if(!resetn)
		begin
			moving_fruit_x <= rand_x % 150 + 5;
			moving_fruit_y <= rand_y % 110 + 5;
			moving_increase_size <= 0;
			counter <= 0;
			direction_x <= 0;
			direction_y <= 0;
		end
		else
		begin
			if ((head_x == moving_fruit_x & head_y == moving_fruit_y) || (head_x1 == moving_fruit_x & head_y1 == moving_fruit_y))
			begin
				moving_fruit_x <= rand_x % 150 + 5;
				moving_fruit_y <= rand_y % 110 + 5;
				moving_increase_size <= 1;
			end
			else
			begin
				moving_increase_size <= 0;
				if(move_fruit)
				begin
					case (moving_fruit_x)
						5:
						begin
							counter <= 0;
							direction_x <= 3;
							moving_fruit_x <= 6;
						end
						155: 
						begin
							counter <= 0;
							direction_x <= 0;
							moving_fruit_x <= 154;
						end
						default: 
						begin
							if (counter == 15)
							begin
								moving_fruit_x <= moving_fruit_x + rand_x[5] + rand_x[4] - 1;
								direction_x <= rand_x[5:4];
								counter <= 0;
							end
							else
							begin
								moving_fruit_x <= moving_fruit_x + direction_x[1] + direction_x[0] - 1;
								counter <= counter + 1;
							end
						end
					endcase
						
					case (moving_fruit_y)
						5:
						begin
							counter <= 0;
							direction_y <= 3;
							moving_fruit_y <= 6;
						end
						115: 
						begin
							counter <= 0;
							direction_y <= 0;
							moving_fruit_y <= 114;
						end
						default: 
						begin
							if (counter == 15)
							begin
								moving_fruit_y <= moving_fruit_y + rand_y[5] + rand_y[4] - 1;
								direction_y <= rand_y[5:4];
								counter <= 0;
							end
							else
							begin
								moving_fruit_y <= moving_fruit_y + direction_y[1] + direction_y[0] - 1;
								counter <= counter + 1;
							end
						end
					endcase
				end
			end
		end
	end
endmodule