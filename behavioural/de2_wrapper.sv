// Example code for an M0 AHBLite System
//  Iain McNally
//  ECS, University of Soutampton
//
// This module is a wrapper allowing the system to be used on the DE1-SoC FPGA board
//

module de2_wrapper(

  input CLOCK_50,
  
  input [15:0] SW, 
  input [2:0] KEY, // DE2 keys are active low

  output [15:0] LEDR,
  output [6:0] HEX0,
  output [6:0] HEX1,
  output [6:0] HEX2,
  output [6:0] HEX3

);

timeunit 1ns;
timeprecision 100ps;

  localparam heartbeat_count_msb = 25; 
  
  
  wire HCLK, HRESETn, LOCKUP, DataValid;
  wire [1:0] Buttons;
  wire [15:0] Switches;

  assign Switches = SW; // DE2 has nore than 16 switches
  
  assign Buttons = ~KEY[1:0];
 
  arm_soc soc_inst(.HCLK, .HRESETn, .DataOut(LEDR), .DataValid, .Switches, .Buttons, .LOCKUP);

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
  assign HEX1 = ~{!DataValid&&!LOCKUP,
                  !DataValid&&!LOCKUP,
                  !DataValid&&!LOCKUP,
                   !LOCKUP,
                   !LOCKUP,
                  !DataValid&&!LOCKUP };

  // running shows as r on HEX2
  assign HEX2 = ~{1'b0,running,1'b0,running, 4'b000 };

  // LOCKUP shows as L on HEX3
  assign HEX3 = ~{1'b0,LOCKUP,LOCKUP,LOCKUP, 3'b000 };


endmodule
