// Example code for an M0 AHBLite System
//  Iain McNally
//  ECS, University of Soutampton
//
// This module is a wrapper allowing the system to be used on the DE0 FPGA board
//

module de0_wrapper(

  input CLOCK_50,
  
  input [9:0] SW, 
  input [2:0] KEY, // de0 keys are active low

  output [9:0] LEDG,
  output [7:0] HEX0,
  output [7:0] HEX1,
  output [7:0] HEX2,
  output [7:0] HEX3

);

timeunit 1ns;
timeprecision 100ps;

  localparam heartbeat_count_msb = 25; 
  
  
  wire HCLK, HRESETn, LOCKUP, DataValid;
  wire [1:0] Buttons;
  wire [15:0] Switches;

  assign Switches = { 6'd0, SW }; // DE0 has just 10 switches
  
  assign Buttons = ~KEY[1:0];
 
  arm_soc soc_inst(.HCLK, .HRESETn, .DataOut(LEDG), .DataValid, .Switches, .Buttons, .LOCKUP);

  assign DataInvalid = ! DataValid;

  // Drive HRESETn directly from active low CPU KEY[2] button
  assign HRESETn = KEY[2];

  // Drive HCLK from 50MHz de0 board clock
  assign HCLK = CLOCK_50;



  // This code gives us a heartbeat signal on the least significant
  //  decimal point of the seven segment display
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
  assign HEX0 = ~{heartbeat, 1'b0,
                  !DataValid&&!LOCKUP,
                  !DataValid&&!LOCKUP,
                  !DataValid&&!LOCKUP,
                   !LOCKUP,
                   !LOCKUP,
                  !DataValid&&!LOCKUP };

  // HEX1 is off
  assign HEX1 = ~{8'b0000_0000 };

  // running shows as r on HEX2
  assign HEX2 = ~{2'b00,running,1'b0,running, 4'b000 };

  // LOCKUP shows as L on HEX3
  assign HEX3 = ~{2'b00,LOCKUP,LOCKUP,LOCKUP, 3'b000 };


endmodule
