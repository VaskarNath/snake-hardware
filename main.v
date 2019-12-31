module main
	(
		CLOCK_50,
		KEY,
		SW,
		// The ports below are for the VGA output.  Do not change.
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK_N,						//	VGA BLANK
		VGA_SYNC_N,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B,   						//	VGA Blue[9:0]
		// Keyboard ports
		PS2_DAT,
		PS2_CLK
	);

	input			CLOCK_50;				//	50 MHz
	inout			PS2_DAT;
	inout 		PS2_CLK;
	input [3:0] KEY;
	input [9:0] SW;
	
	wire [2:0] colour;
	wire [2:0] COLOUR;
	wire [7:0] out_x;
	wire [6:0] out_y;
	wire [7:0] X;
	wire [6:0] Y;
	wire writeEn;
	wire output_signal;
	wire resetn;
	wire ld;
	wire [1:0] increment;
	wire clock_15;
	wire keyboard;
	wire [1:0] keyboard_arrow;

	wire move;
	wire move_fruit;
	wire start;
	
	wire w;
	wire a;
	wire s;
	wire d;
	wire left;
	wire right;
	wire up;
	wire down;
	wire enter;
	wire space;
	wire [7:0] counter_x;
	wire [6:0] counter_y;
	wire [6:0] counter_j;
	wire [3:0] select;
	wire output_size;
	wire out_valid;
	wire [7:0] head_x;
	wire [7:0] head_y;
	wire increase_size;
	wire [7:0] fruit_x;
	wire [6:0] fruit_y;
	wire [7:0] moving_fruit_x;
	wire [6:0] moving_fruit_y;
	wire moving_increase_size;
	wire display_h;
	wire [7:0] hout_x;
	wire [6:0] hout_y;
	wire [3:0] counter_h;
	wire display_v0;
	wire display_v1;
	wire display_v2;
	wire endgamev0;
	wire endgamev1;
	wire endgamev2;
	wire endgameh;
	wire endgame;
	wire endgames;
	wire [7:0] vout_x0;
	wire [6:0] vout_y0;
	wire [3:0] counter_v0;
	wire [7:0] vout_x1;
	wire [6:0] vout_y1;
	wire [3:0] counter_v1;
	wire [7:0] vout_x2;
	wire [6:0] vout_y2;
	wire [3:0] counter_v2;
	wire increase_size1;
	wire moving_increase_size1;
	wire keyboard1;
	wire [1:0] keyboard_arrow1;
	wire [7:0] out_x1;
	wire [7:0] out_y1;
	wire [6:0]counter_j1;
	wire endgames1;
	wire [7:0] head_x1;
	wire [7:0] head_y1;
	wire out_valid1;
	
	
	assign resetn = KEY[0]; //might be not
	assign start = KEY[3];

	// Declare your inputs and outputs here
	// Do not change the following outputs
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK_N;				//	VGA BLANK
	output			VGA_SYNC_N;				//	VGA SYNC
	output	[9:0]	VGA_R;   				//	VGA Red[9:0]
	output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
	output	[9:0]	VGA_B;   				//	VGA Blue[9:0]
	
	
	// Create an Instance of a VGA controller - there can be only one!
	// Define the number of colours as well as the initial background
	// image file (.MIF) for the controller.
	vga_adapter VGA(
			.resetn(resetn),
			.clock(CLOCK_50),
			.colour(COLOUR),
			.x(X),
			.y(Y),
			.plot(writeEn),
			/* Signals for the DAC to drive the monitor. */
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK_N),
			.VGA_SYNC(VGA_SYNC_N),
			.VGA_CLK(VGA_CLK));
		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "black.mif";
			
	// Put your code here. Your code should produce signals x,y,colour and writeEn/plot
	// for the VGA controller, in addition to any other functionality your design may require.
	
 keyboard_tracker k0(
    .clock(CLOCK_50),
	 .reset(resetn), 
	 .PS2_CLK(PS2_CLK),
	 .PS2_DAT(PS2_DAT),
	 .w(w), 
	 .a(a), 
	 .s(s),
	 .d(d),
	 .left(left),
	 .right(right),
	 .up(up),
	 .down(down),
	 .space(space),
	 .enter(enter)
	 );
	 
	moving_fruit f1(
	.resetn(resetn),
	.clock(CLOCK_50),
	.head_x(head_x),
	.head_y(head_y),
	.head_x1(head_x1),
	.head_y1(head_y1),
	.move_fruit(move_fruit),
	
	.moving_fruit_x(moving_fruit_x),
	.moving_fruit_y(moving_fruit_y),
	.moving_increase_size(moving_increase_size)
	);
	 
	fruit f0(
	.clock(CLOCK_50),
	.resetn(resetn),
	.head_x(head_x),
	.head_y(head_y),
	.head_x1(head_x1),
	.head_y1(head_y1),
	.fruit_x(fruit_x),
	.fruit_y(fruit_y),
	.increase_size(increase_size)
	);
	
	v_obstacle v0(
	.resetn(resetn), 
	.clock(CLOCK_50), 
	.move(move),
	.default_x(120),
	.display_v(display_v0),
	.v(counter_v0),
	.head_x(head_x),
	.head_y(head_y),
	.head_x1(head_x1),
	.head_y1(head_y1),
	 
	.endgamev(endgamev0),
	.vout_x(vout_x0),
	.vout_y(vout_y0)
	);
	
	v_obstacle v1(
	.resetn(resetn), 
	.clock(CLOCK_50), 
	.move(move),
	.default_x(30),
	.display_v(display_v1),
	.v(counter_v1),
	.head_x(head_x),
	.head_y(head_y),
	.head_x1(head_x1),
	.head_y1(head_y1),
	 
	.endgamev(endgamev1),
	.vout_x(vout_x1),
	.vout_y(vout_y1)
	);
	
	v_obstacle v2(
	.resetn(resetn), 
	.clock(CLOCK_50), 
	.move(move),
	.default_x(31),
	.display_v(display_v2),
	.v(counter_v2),
	.head_x(head_x),
	.head_y(head_y),
	.head_x1(head_x1),
	.head_y1(head_y1),
	 
	.endgamev(endgamev2),
	.vout_x(vout_x2),
	.vout_y(vout_y2)
	);
	
	h_obstacle(
	.resetn(resetn), 
	.clock(CLOCK_50), 
	.move(move),
	.display_h(display_h),
	.h(counter_h),
	.head_x(head_x),
	.head_y(head_y),
	.head_x1(head_x1),
	.head_y1(head_y1),
	 
	.endgameh(endgameh),
	.hout_x(hout_x),
	.hout_y(hout_y)
	);
	 
	snake s0(
	.resetn(resetn),
	.increase_size(increase_size),
	.moving_increase_size(moving_increase_size),
	.clock(CLOCK_50),
	.keyboard(keyboard),
	.keyboard_arrow(keyboard_arrow),
	.out_x(out_x),
	.out_y(out_y),
	.move(move),
	.j(counter_j),
	.display(output_signal),
	.endgame(endgames),
	.head_x(head_x),
	.head_y(head_y),
	.out_valid(out_valid)
	);
	
	snake s1(
	.resetn(resetn),
	.increase_size(increase_size1),
	.moving_increase_size(moving_increase_size1),
	.clock(CLOCK_50),
	.keyboard(keyboard1),
	.keyboard_arrow(keyboard_arrow1),
	.out_x(out_x1),
	.out_y(out_y1),
	.move(move),
	.j(counter_j1),
	.display(output_signal),
	.endgame(endgames1),
	.head_x(head_x1),
	.head_y(head_y1),
	.out_valid(out_valid1)
	);
		
	control vc0(
	 .clock(CLOCK_50),
	 .endgame(endgame),
	 .up(up),
	 .down(down),
	 .left(left),
	 .right(right),
	 .w(w),
	 .a(a),
	 .s(s),
	 .d(d),
	 .clock_15(clock_15),
    .resetn(resetn),
	 .start(start),
	 .output_signal(output_signal),
	 .counter_x(counter_x),
	 .counter_y(counter_y),
	 .counter_j(counter_j),
	 .counter_j1(counter_j1),
	 .counter_h(counter_h),
	 .counter_v0(counter_v0),
	 .counter_v1(counter_v1),
	 .counter_v2(counter_v2),
	 .select(select),
	 .keyboard(keyboard),
	 .keyboard_arrow(keyboard_arrow),
	 .keyboard1(keyboard1),
	 .keyboard_arrow1(keyboard_arrow1),
	 .move(move),
	 .move_fruit(move_fruit)
	 );
	
	datapath d0(
	 .clock(CLOCK_50),
	 .out_valid(out_valid),
	 .out_valid1(out_valid1),
    .resetn(resetn),
    .snake_x(out_x),
	 .snake_y(out_y),
	 .snake_x1(out_x1),
	 .snake_y1(out_y1),
	 .screen_x(counter_x),
	 .screen_y(counter_y),
	 .fruit_x(fruit_x),
	 .fruit_y(fruit_y),
	 .moving_fruit_x(moving_fruit_x),
	 .moving_fruit_y(moving_fruit_y),
	 .hout_x(hout_x),
	 .hout_y(hout_y),
	 .vout_x0(vout_x0),
	 .vout_y0(vout_y0),
	 .vout_x1(vout_x1),
	 .vout_y1(vout_y1),
	 .vout_x2(vout_x2),
	 .vout_y2(vout_y2),
	 .select(select),
	 .output_signal(output_signal),
	 .X(X),
	 .Y(Y),
	 .COLOUR(COLOUR),
	 .writeEn(writeEn),
	 .endgame(endgame)
	);
	
	assign endgame = endgamev0 || endgamev1 || endgamev2 || endgameh || endgames || endgames1;
	
endmodule