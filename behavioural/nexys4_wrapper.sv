// Example code for an M0 AHBLite System
//  Iain McNally
//  ECS, University of Soutampton
//
// This module is a wrapper allowing the system to be used on the Nexsys 4 FPGA board
//

module nexys4_wrapper(

  input Clock, nReset,
  
  input [15:0] Switches, 
  input [1:0] Buttons, // nexys4 buttons are active high

  output [15:0] DataOut,
  output DataValid, DataInvalid,
  output Status_Green, Status_Red

);

timeunit 1ns;
timeprecision 100ps;

  localparam heartbeat_count_msb = 26; 
  localparam heartbeat_dimmer_msb = 5; 
  
  
  wire HCLK, HRESETn, LOCKUP;
 
  arm_soc soc_inst(.HCLK, .HRESETn, .DataOut, .DataValid, .Switches, .Buttons, .LOCKUP);

  assign DataInvalid = ! DataValid;

  // Drive HRESETn directly from active low CPU RESET button
  assign HRESETn = nReset;

  // Drive HCLK from 50MHz signal derived from 100MHz Nexys4 board clock
  logic Clock50;
  always_ff @(posedge Clock, negedge nReset )
    if ( ! nReset )
      Clock50 <= 0;
    else
      Clock50 <= ! Clock50;

  assign HCLK = Clock50;



  // This code gives us a heartbeat signal on the RGB LED
  //
  // The LED is:
  //      steady orange - at reset,
  //      steady red    - in the event of ARM M0 "lockup" and
  //      pulsing green - under normal operation
  //
  logic running, heartbeat;
  logic [heartbeat_count_msb:0] tick_count;
  always_ff @(posedge Clock, negedge nReset )
    if ( ! nReset )
      begin
        running <= 0;
        heartbeat <= 0;
        tick_count <= 0;
      end
    else
      begin
        running <= 1;
        heartbeat = tick_count[heartbeat_count_msb] && tick_count[heartbeat_count_msb-2] && (&tick_count[heartbeat_dimmer_msb:0]);
        tick_count <= tick_count + 1;
      end

  // Single LED with two colours to indicate system status
  assign Status_Green = !running || ( heartbeat && !LOCKUP );
  assign Status_Red   = !running || LOCKUP;




endmodule
