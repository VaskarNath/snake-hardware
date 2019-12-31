module sixtycounter(clock, resetn, enable);
	input clock;
	input resetn;
	output enable;
	
	reg [27:0] q;
	wire [27:0] d;
	
	assign d = 2000000;
	
	always @(posedge clock)
	begin
		if (resetn == 1'b0)
			q <= d;
		else 
			begin
			if (q == 0)
				q <= d;
			else
				q <= q - 1'b1;
			end
	end
	
	assign enable = (q == 0) ? 1'b1 : 1'b0;
	
endmodule 