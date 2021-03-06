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
  output logic [10:0] x1, x2, y1, y2, x3, y3
);

timeunit 1ns;
timeprecision 100ps;

  // AHB transfer codes needed in this module
  localparam No_Transfer = 2'b0;

  //control signals are stored in registers
  logic write_enable, read_enable;
  logic [2:0] word_address  ;
  
  //memory
  logic [0:0] memory [0:307199] ;
  logic [18:0] memory_address;
  logic [18:0] pixel_address ;
  logic [10:0] x,y ;

  
  // Unused registers 
  logic NextDataValid;
  logic [15:0] Status;

  //Generate the control signals in the address phase
  always_ff @(posedge HCLK, negedge HRESETn)
    if ( ! HRESETn )
      begin
        write_enable <= '0;
        read_enable <= '0;
        word_address <= '0;
      end
    else if ( HREADY && HSEL && (HTRANS != No_Transfer) )
      begin
        write_enable <= HWRITE;
        read_enable <= ! HWRITE;
        word_address <= HADDR[4:2];

     end
    else
      begin
        write_enable <= '0;
        read_enable <= '0;
        word_address <= '0;
     end

  // Act on control signals in the data phase
  // Write pixel coordinates 
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
      x1 <= HWDATA;

    // y1 write     
    else if ( write_enable && (word_address==1))
      y1 <= HWDATA;

    // x2 write     
    else if ( write_enable && (word_address==2))
      x2 <= HWDATA;

    // y2 write     
    else if ( write_enable && (word_address==3))
      y2 <= HWDATA;

    // x3 write     
    else if ( write_enable && (word_address==4))
      x3 <= HWDATA;

    // y3 write     
    else if ( write_enable && (word_address==5))
      y3 <= HWDATA[15:0];

 initial 

memory = '{307200{0}};

  //memory 
  always_ff @(posedge HCLK)
    begin 
      if( write_enable )
        memory[memory_address] <= x + (640*y) ; 
    end 
  
  always_comb 
    pixel_address = (pixel_y * 640) + pixel_x   ;
    
   
  always_ff @(posedge HCLK)  
    begin
		pixel <= memory[pixel_address] ;
    end
	
// memory_address increments from 0 to 307199 
  always_ff @(posedge HCLK)
    begin 
		if( !HRESETn )
			memory_address <= '0;
			
		else if(memory_address >= 307200)
			memory_address <= '0;
		
		else 	
			memory_address <= memory_address + 1 ;
	
	end 	
// x increments from 0 to 639 
  always_ff @(posedge HCLK)
    begin 
		if( !HRESETn )
			x <= '0;
			
		else if(x >= 639)
			x <= '0;
		
		else 	
			x <= x + 1 ;
	
	end 	

// y increments from 0 to 479
  always_ff @(posedge HCLK)
    begin 
		if( !HRESETn )
			y <= '0;
			
		else if(y >= 479)
			y <= '0;
		
		else 	
			y <= y + 1 ;
	
	end 	
 
// Read not allowed
assign HRDATA = '0; // read is not permitted mode
   
    
 
//Transfer Response
  assign HREADYOUT = '1; //Single Cycle Wait State for Write


endmodule

