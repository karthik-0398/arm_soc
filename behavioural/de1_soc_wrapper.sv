// Example code for an M0 AHBLite System
//  Iain McNally
//  ECS, University of Soutampton
//
// This module is a wrapper allowing the system to be used on the DE1-SoC FPGA board
//

module de1_soc_wrapper(

  input CLOCK_50,
  
  input [9:0] SW, 
  input [3:0] KEY, // de1 keys are active low

  output [9:0] LEDR,
  output [6:0] HEX0,
  output [6:0] HEX1,
  output [6:0] HEX2,
  output [6:0] HEX3,
  output logic [7:0] VGA_R,VGA_G,VGA_B, 
  output logic VGA_HS,VGA_VS, VGA_CLK, VGA_BLANK_N


);

timeunit 1ns;
timeprecision 100ps;

  localparam heartbeat_count_msb = 25; 
  
  
  wire HCLK, HRESETn, LOCKUP;
  wire [1:0] Buttons;
  wire [15:0] Switches;
  logic pixel ;
  logic [9:0] pixel_x ;
  logic [8:0] pixel_y ; 
  logic [10:0] x1,y1,x2,y2,x3,y3 ;
  assign Switches = { 6'd0, SW }; // DE1-SoC has just 10 switches
  
  assign Buttons = ~KEY[1:0];
 
  arm_soc soc_inst(.HCLK, .HRESETn, .Switches, .pixel(pixel), .pixel_x(pixel_x), .pixel_y(pixel_y), .x1(x1), .y1(y1), .x2(x2), .y2(y2), .x3(x3), .y3(y3), .Buttons, .LOCKUP);
  
  razzle raz_inst  (
        .CLOCK_50(CLOCK_50), .KEY(KEY), .pixel_x(pixel_x), .pixel_y(pixel_y), .pixel(pixel), 
        .VGA_R(VGA_R),.VGA_G(VGA_G),.VGA_B(VGA_B), 
        .VGA_HS(VGA_HS),.VGA_VS(VGA_VS), .VGA_CLK(VGA_CLK), 
	.VGA_BLANK_N(VGA_BLANK_N)
	); 


  // Drive HRESETn directly from active low CPU KEY[2] button
  assign HRESETn = KEY[2];

  // Drive HCLK from 50MHz de0 board clock
  assign HCLK = CLOCK_50;



  // This code gives us a heartbeat signal
  //
  logic running, heartbeat;
  logic [heartbeat_count_msb:0] tick_count;
  always_ff @(posedge CLOCK_50, negedge HRESETn )
    if ( ! HRESETn )
      begin
        running <= 0;
        heartbeat <= 0;
        tick_count <= 0;
      end
    else
      begin
        running <= 1;
        heartbeat = tick_count[heartbeat_count_msb] && tick_count[heartbeat_count_msb-2];
        tick_count <= tick_count + 1;
      end

  // seven segment display to indicate system status

  // HEX0 is heartbeat
  assign HEX0 = (heartbeat) ? 7'b0100011 : '1;

  // HEX1 is DataValid
  assign HEX1 = ~{!LOCKUP};

  // running shows as r on HEX2
  assign HEX2 = ~{1'b0,running,1'b0,running, 4'b000 };

  // LOCKUP shows as L on HEX3
  assign HEX3 = ~{1'b0,LOCKUP,LOCKUP,LOCKUP, 3'b000 };


endmodule
