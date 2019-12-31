module framecounter(clock, resetn, output_s);
	input clock;
	input resetn;
	reg [27:0] frame_ct;
	output output_s;

	wire [27:0] d;
	
	assign d = 50_000_000;
	
	always @(posedge clock)
	begin
		if (!resetn) 
			frame_ct <= d;
		else
			begin 
				if (frame_ct == 0)
					frame_ct <= d;
				else
					frame_ct <= frame_ct - 1;
			end
	end
	assign output_s = (frame_ct == 0) ? 1'b1 : 1'b0;

endmodule