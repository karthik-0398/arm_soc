// Example code for an M0 AHBLite System
//  Iain McNally
//  ECS, University of Soutampton
//
// This module is an AHB-Lite Slave containing a RAM
// Since this loads a program it is for FPGA use only
//
// Number of addressable locations : 307200
// Size of each addressable location : bits_per_pixel bits
// Supported transfer sizes : Word
// Alignment of base address : Word aligned
//

// Memory is synchronous which should suit block memory types
//   Read takes 1 cycle
//   Write takes 2 cycles (single wait state)
//
// Note this is not the most efficient design but works with
//  Xilinx and Altera(Intel) FPGAs
//


`define STRINGIFY(x) `"x`"

module ahb_pixel_memory #(
  parameter MEMWIDTH = 22
)(
  //AHBLITE INTERFACE

    //Slave Select Signal
    input HSEL,
    //Global Signals
    input HCLK,
    input HRESETn,
    //Address, Control & Write Data
    input HREADY,
    input [31:0] HADDR,
    input [1:0] HTRANS,
    input HWRITE,
    input [2:0] HSIZE,
    input [31:0] HWDATA,
    // Transfer Response & Read Data
    output HREADYOUT,
    output [31:0] HRDATA

);

timeunit 1ns;
timeprecision 100ps;

localparam No_Transfer = 2'b0;
localparam bits_per_pixel = 1;

// Memory Array
  logic [bits_per_pixel-1:0] memory[0:307199];

// other declarations
  logic [31:0] data_from_memory, data_to_memory;
  logic write_cycle, read_cycle;
  logic [MEMWIDTH-2:0] word_address, saved_word_address;
  logic [3:0] byte_select;


//Generate the control signals here:

  always_ff @(posedge HCLK, negedge HRESETn)
    if (! HRESETn )
      begin
        write_cycle <= '0;
        read_cycle <= '0;
        saved_word_address <= '0;
      end
    else
      begin
        if ( HREADY && HSEL && (HTRANS != No_Transfer) )
          begin
            write_cycle <= HWRITE;
            read_cycle <= ! HWRITE;
            saved_word_address <= HADDR[MEMWIDTH:2];
         end
        else
          begin
            write_cycle <= '0;
            read_cycle <= '0;
         end
      end

  // the word address is available in the address phase
  always_comb
    if ( HREADY && HSEL && (HTRANS != No_Transfer) && ! write_cycle )
      word_address = HADDR[MEMWIDTH:2];
    else
      word_address = saved_word_address;

// model the memory here:

  // read and write are both synchronous
  // the code uses a simple format to ensure easy identification of RAM for synthesis
  always_ff @(posedge HCLK)
    begin
      data_from_memory <= memory[word_address];
      if ( write_cycle )
        memory[word_address] <= data_to_memory;
    end

// deal with byte access here:

  always_comb
    if (write_cycle)
      data_to_memory= HWDATA;
    else
      data_to_memory = '0;

  // (output of zero when not enabled for read is not necessary but may help with debugging)
  assign HRDATA = read_cycle ? data_from_memory : '0;


//Transfer Response
  assign HREADYOUT = ! write_cycle; //Single Cycle Wait State for Write


endmodule
