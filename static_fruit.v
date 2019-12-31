module fruit(
	input clock,
	input resetn,
	input [7:0] head_x,
	input [7:0] head_y,
	input [7:0] head_x1,
	input [7:0] head_y1,
	
	output reg [7:0] fruit_x,
	output reg [7:0] fruit_y,
	output reg increase_size
	);
	
	wire [7:0] rand_x;
	wire [6:0] rand_y;
	
	random_number_generator rand(
	.clock(clock),
	.resetn(resetn),
	.rand_x(rand_x),
	.rand_y(rand_y)
	);
			
	always @(posedge clock)
	begin
		if(!resetn)
		begin
			fruit_x <= rand_x;
			fruit_y <= rand_y;
			increase_size <= 0;
		end
		else
		begin
			if ((head_x == fruit_x & head_y == fruit_y) || (head_x1 == fruit_x & head_y1 == fruit_y))
			begin
				fruit_x <= rand_x;
				fruit_y <= rand_y;
				increase_size <= 1;
			end
			else
			begin
				increase_size <= 0;
			end
		end
	end
endmodule