module datapath(
    input clock,
    input resetn,
    input [7:0] snake_x,
	 input [6:0] snake_y,
	 input [7:0] snake_x1,
	 input [6:0] snake_y1,
	 input [7:0] screen_x,
	 input [6:0] screen_y,
	 input [7:0] fruit_x,
	 input [6:0] fruit_y,
	 input [7:0] moving_fruit_x,
	 input [6:0] moving_fruit_y,
	 input [7:0] hout_x,
	 input [6:0] hout_y,
	 input [7:0] vout_x0,
	 input [6:0] vout_y0,
	 input [7:0] vout_x1,
	 input [6:0] vout_y1,
	 input [7:0] vout_x2,
	 input [6:0] vout_y2,
	 input output_signal,
	 input [3:0] select,
	 input endgame,
	 input out_valid,
	 input out_valid1,
	 
    output reg [7:0] X,
	 output reg [6:0] Y,
	 output reg [2:0] COLOUR,
	 output reg writeEn
    );
	     	 
		
	 always @(*)
	 begin
		case (select)
			0:
			begin 
				if (output_signal & out_valid)
				begin
					X = snake_x;
					Y = snake_y;
					COLOUR = 3'b010;
					writeEn = 1;
				end
				else
				begin
					X = 0;
					Y = 0;
					writeEn = 0;
					COLOUR = 3'b000;
				end
			end
			1:
			begin 
				if (output_signal)
				begin
					X = screen_x;
					Y = screen_y;
					if(endgame)
						COLOUR = 3'b100;
					else
						COLOUR = 3'b000;
					writeEn = 1;
				end
				else
				begin
					X = 0;
					Y = 0;
					writeEn = 0;
					COLOUR = 3'b000;
				end
			end
			2:
			begin
				if(output_signal)
				begin
					X = fruit_x;
					Y = fruit_y;
					COLOUR = 3'b101;
					writeEn = 1;
				end
				else
				begin
					X = 0;
					Y = 0;
					writeEn = 0;
					COLOUR = 3'b000;
				end
			end
			3:
			begin
				if(output_signal)
				begin
					X = hout_x;
					Y = hout_y;
					COLOUR = 3'b001;
					writeEn = 1;
				end
				else
				begin
					X = 0;
					Y = 0;
					writeEn = 0;
					COLOUR = 3'b000;
				end
			end
			4:
			begin
				if(output_signal)
				begin
					X = vout_x0;
					Y = vout_y0;
					COLOUR = 3'b001;
					writeEn = 1;
				end
				else
				begin
					X = 0;
					Y = 0;
					writeEn = 0;
					COLOUR = 3'b000;
				end
			end
			5:
			begin
				if(output_signal)
				begin
					X = vout_x1;
					Y = vout_y1;
					COLOUR = 3'b001;
					writeEn = 1;
				end
				else
				begin
					X = 0;
					Y = 0;
					writeEn = 0;
					COLOUR = 3'b000;
				end
			end
			6:
			begin
				if(output_signal)
				begin
					X = vout_x2;
					Y = vout_y2;
					COLOUR = 3'b001;
					writeEn = 1;
				end
				else
				begin
					X = 0;
					Y = 0;
					writeEn = 0;
					COLOUR = 3'b000;
				end
			end
			7:
			begin
				if(output_signal)
				begin
					X = moving_fruit_x;
					Y = moving_fruit_y;
					COLOUR = 3'b110;
					writeEn = 1;
				end
				else
				begin
					X = 0;
					Y = 0;
					writeEn = 0;
					COLOUR = 3'b000;
				end
			end
			8:
			begin 
				if (output_signal & out_valid1)
				begin
					X = snake_x1;
					Y = snake_y1;
					COLOUR = 3'b011;
					writeEn = 1;
				end
				else
				begin
					X = 0;
					Y = 0;
					writeEn = 0;
					COLOUR = 3'b000;
				end
			end
			default: 
			begin
				X = 0;
				Y = 0;
				writeEn = 0;
				COLOUR = 3'b000;
			end
		endcase
	end
endmodule