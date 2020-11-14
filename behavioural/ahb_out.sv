// Example code for an M0 AHBLite System
//  Iain McNally
//  ECS, University of Soutampton
//
// This module is an AHB-Lite Slave containing two read/write registers
//
// Number of addressable locations : 2
// Size of each addressable location : 16 bits
// Supported transfer sizes : Half Word
// Alignment of base address : Word aligned
//
// Address map :
//   Base addess + 0 : 
//     Read x1 register
//     Write x1 register, Copy NextDataValid to DataValid
//   Base addess + 2 : 
//     Read NextDataValid and DataValid registers
//     Write NextDataValid register
//
// Bits within status register :
//   Bit 1   NextDataValid
//   Bit 0   DataValid


// In order to update the output, the software should update the NextDataValid
// register followed by the x1 register.


module ahb_out(

  // AHB Global Signals
  input HCLK,
  input HRESETn,

  // AHB Signals from Master to Slave
  input [31:0] HADDR, // With this interface only HADDR[1] is used (other bits are ignored)
  input [31:0] HWDATA,
  input [2:0] HSIZE,
  input [1:0] HTRANS,
  input HWRITE,
  input HREADY,
  input HSEL,
  //Non-AHB signals 
  input logic [9:0] pixel_x ,
  input logic [8:0] pixel_y ,

  // AHB Signals from Slave to Master
  output logic [31:0] HRDATA,
  output HREADYOUT,

  //Non-AHB Signals
  output logic pixel, 
  output logic [8:0] x1, x2, y1, y2, x3, y3
);

timeunit 1ns;
timeprecision 100ps;

  // AHB transfer codes needed in this module
  localparam No_Transfer = 2'b0;

  //control signals are stored in registers
  logic write_enable, read_enable;
  logic [2:0] word_address  ;
  logic [18:0] word_address_memory;
  logic [18:0] pixel_address ;

  //memory
  logic [0:0] memory [0:307199] ;
 
  logic NextDataValid;
  logic [15:0] Status;

  //Generate the control signals in the address phase
  always_ff @(posedge HCLK, negedge HRESETn)
    if ( ! HRESETn )
      begin
        write_enable <= '0;
        read_enable <= '0;
        word_address <= '0;
        word_address_memory <= '0;

      end
    else if ( HREADY && HSEL && (HTRANS != No_Transfer) )
      begin
        write_enable <= HWRITE;
        read_enable <= ! HWRITE;
        word_address <= HADDR[4:2];
        word_address_memory <= HADDR[23:5] ;

     end
    else
      begin
        write_enable <= '0;
        read_enable <= '0;
        word_address <= '0;
        word_address_memory <= '0;
     end

  //Act on control signals in the data phase

  // write
  always_ff @(posedge HCLK, negedge HRESETn)
    if ( ! HRESETn )
      begin
        x1 <= '0;
    		x2 <= '0;
        x3 <= '0;
    		y1 <= '0;
    		y2 <= '0;
        y3 <= '0;

      end
    // x1 write     
    else if ( write_enable && (word_address==0))
      x1 <= HWDATA[15:0];

    // y1 write     
    else if ( write_enable && (word_address==1))
      y1 <= HWDATA[15:0];

    // x2 write     
    else if ( write_enable && (word_address==2))
      x2 <= HWDATA[15:0];

    // y2 write     
    else if ( write_enable && (word_address==3))
      y2 <= HWDATA[15:0];

    // x3 write     
    else if ( write_enable && (word_address==4))
      x3 <= HWDATA[15:0];

    // y3 write     
    else if ( write_enable && (word_address==5))
      y3 <= HWDATA[15:0];

 initial 

memory = '{307200{0}};

  //memory 
  always_ff @(posedge HCLK)
    begin 
      if( write_enable )
        memory[word_address_memory] <= HWDATA ; 
    end 
  
  always_comb 
    pixel_address = (pixel_y * 640) + pixel_x  ;
    
   
   always_ff @(posedge HCLK)  
     begin
      pixel <= memory[pixel_address] ;
     end
          


  //read
  always_comb
    if ( ! read_enable )
      // (output of zero when not enabled for read is not necessary
      //  but may help with debugging)
      HRDATA = '0;
    else 
      case (word_address)
        0 : HRDATA = { 23'd0, x1 };
        1 : HRDATA = { 23'd0, y1 };
        2 : HRDATA = { 23'd0, x2 };
        3 : HRDATA = { 23'd0, y2 };   
        4 : HRDATA = { 23'd0, x3 };
        5 : HRDATA = { 23'd0, y3 };                        
        // unused address - returns zero
        default : HRDATA = '0;
      endcase
  //Transfer Response
  assign HREADYOUT = '1; //Single cycle Write & Read. Zero Wait state operations


endmodule

