module random_number_generator(
	input clock,
	input resetn,
	
	output reg [7:0] rand_x,
	output reg [6:0] rand_y
	);

	wire temp_x;
	wire temp_y;
	
	initial 
			begin
			rand_x <= 8'b01111111;
			rand_y <= 7'b0111111;
			end
	
	assign temp_x = (rand_x[3] ^ (rand_x[4] ^ (rand_x[5] ^ rand_x[7])));
	assign temp_y = (rand_y[6] ^ rand_y[5]);
	
	always @(posedge clock)
	begin
			rand_x <= {rand_x[6:0], temp_x} % 155 + 3;
			rand_y <= {rand_y[5:0], temp_y} % 115 + 3 ;
			if (rand_x == 0)
				rand_x <= 8'b01111111;
			if (rand_y == 0)
				rand_y <= 7'b0111111;
	end
endmodule
