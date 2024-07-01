module semaphore_fsm(
	input clk,
	input reset,
	input enable,
	output reg red,
	output reg red_yellow,
	output reg green,
	output reg yellow,
	output [4:0] state_out);
//declared states as parameters
parameter [4:0] OFF = 5'b00001,
				RED = 5'b00010,
				RED_YELLOW = 5'b00100,
				GREEN = 5'b01000,
				YELLOW = 5'b10000;
//declare logic for state machine
reg [4:0] state;
reg [4:0] next_state;
reg [5:0] timer;
reg timer_clear;
//combinational part
always @ (*) begin
red = 0;
red_yellow = 0;
green = 0;
yellow = 0;
next_state = OFF;
timer_clear = 0;
case (state) 
	OFF : begin
			if(enable) next_state = RED;
		  end
	RED : begin
			red = 1;
			if (timer == 6'd50) begin
				next_state = RED_YELLOW;
				timer_clear = 1;
			end else begin
				next_state = RED;
			end
		  end
	RED_YELLOW : begin
					red_yellow = 1;
					if (timer == 6'd10) begin
						next_state = GREEN;
						timer_clear = 1;
					end else begin
						next_state = RED_YELLOW;
					end
				 end
	GREEN : begin
				green = 1;
				if (timer == 6'd30) begin
					next_state = YELLOW;
					timer_clear = 1;
				end else begin
					next_state = GREEN;
				end
			end
	YELLOW : begin 
				yellow = 1;
				if(timer == 6'd10) begin
					next_state = RED;
					timer_clear = 1;
				end else begin
					next_state = YELLOW;
				end
			 end
	default : next_state = OFF;
endcase
if (!enable) begin
	next_state = OFF;
	red = 0;
	red_yellow = 0;
	green = 0;
	yellow = 0;
end
end
// Sequential part
always @ (posedge clk or negedge reset) begin
	if(!reset) 
		state <= OFF;
	else 
		state <= next_state;
end
assign state_out = state;
// timer logic
always @ (posedge clk or negedge reset) begin
	if(!reset)
		timer <= 6'd0;
	else if ((timer_clear == 1) || (!enable))
		timer <= 6'd0;
	else if (state != OFF)
		timer <= timer + 1'b1;
end
endmodule

`timescale 1us/1ns
module semaphore_fsm_tb;
reg clk = 0;
reg reset;
reg enable;
wire red;
wire red_yellow;
wire green;
wire yellow;
wire [4:0] state_out;
//paramater for testbench flow
parameter [4:0] OFF = 5'b00001,
				RED = 5'b00010,
				RED_YELLOW = 5'b00100,
				GREEN = 5'b01000,
				YELLOW = 5'b10000;
semaphore_fsm FSM2 (
		.clk(clk),
		.reset(reset), 
		.enable(enable),
		.red(red),
		.red_yellow(red_yellow),
		.green(green),
		.yellow(yellow),
		.state_out(state_out)
);
always begin #0.5; clk=~clk; end
initial begin
$monitor($time, " enable=%b, red=%b, red_yellow=%b, green=%b, yellow=%b", enable, red, red_yellow, green, yellow);
reset = 0; #1.5; reset = 1;
enable = 0;
repeat(10) @(posedge clk);
enable = 1;
//wait for 2 semaphore cycle
repeat (2) begin
	wait (state_out === YELLOW);
	@(state_out); // wait for YELLOW to be over
end
// Disable semaphore during RED_YELLOW state
wait (state_out === RED_YELLOW);
@(posedge clk); enable = 0;
// Enable semaphore again
repeat (10) @(posedge clk);
@(posedge clk); enable = 1;
#30; $stop;
end
endmodule