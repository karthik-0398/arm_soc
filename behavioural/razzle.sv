// Description:
// This code generates a VGA output for ARM SoC based on razzle code modified by Iain Mcnally
//
// Maintainer: Karthik Sathyanarayanan <ks6n19@soton.ac.uk>
// Revision : $Revision$

 
module razzle ( 
 
		input logic CLOCK_50, 
		input logic [3:0] KEY,
		input logic [10:0] x1, x2, y1, y2,
    	output logic [7:0] VGA_R,VGA_G,VGA_B, 
    	output logic VGA_HS,VGA_VS, VGA_CLK, VGA_BLANK_N); 
       		 
// Video Display Signals    
logic [10:0] H_count,V_count; 

logic Red_Data; 
logic red_square ;
logic video_on, video_on_H, video_on_V, clock_enable; 



// Map internal signals to external busses

logic nReset;
logic Red,Green,Blue; 

assign nReset=KEY[2]; // Keys are active low?

assign VGA_R = Red ? 255 : 0;
assign VGA_G = Green ? 255 : 0;
assign VGA_B = Blue ? 255 : 0;

assign VGA_CLK = clock_enable;
assign VGA_BLANK_N = video_on;


// Colors for pixel data on video signal 
assign Red_Data = red_square ; 
assign Green_Data = 0; 
assign Blue_Data = 0; 

// turn off color (black) at screen edges and during retrace with video_on 
assign Red =   Red_Data && video_on; 
assign Green = Green_Data && video_on; 
assign Blue =  Blue_Data && video_on; 

// video_on turns off pixel color data when not in the pixel view area 
assign video_on = video_on_H && video_on_V; 

// Red square calculation

always @(posedge CLOCK_50, negedge nReset)
<<<<<<< HEAD
  if ( ! nReset)
    begin
      red_square = 0;
    end
  else
    begin : FRACTAL_COMPUTE 
      if ( video_on )
	begin
	
	  if (( y1 < V_count) && ( V_count < y2 ))
			if ((  x1 < H_count) && ( H_count  < x2 ))
				red_square = 1 ; 
			else 
				red_square = 0 ; 	
	  else 
		 red_square = 0 ;



	end
    end : FRACTAL_COMPUTE
=======
	if ( ! nReset)
		begin
			red_square = 0;
		end
	else
		begin : FRACTAL_COMPUTE 
		if ( video_on )
		begin
			if ( y1 < V_count < y2 )
				if (  x2 < H_count < x1 )
					red_square = 0 ; 
				else 
	    			red_square = 1 ; 	
		end
    	end : FRACTAL_COMPUTE
>>>>>>> 52fff8ef4ad788ad3296edfd3018c758821a3033
     
// Generate Horizontal and Vertical Timing Signals for Video Signal 
//VIDEO_DISPLAY 

always @(posedge CLOCK_50, negedge nReset)
  if ( ! nReset) 
    begin
		clock_enable = 0; 
		H_count = 0; 
		V_count = 0; 
		video_on_H = 0; 
		video_on_V = 0; 
    end
	
	else
	begin : VIDEO_DISPLAY
      // Clock enable used for a 24Mhz video clock rate 
      // 640 by 480 display mode needs close to a 25Mhz pixel clock 
      // 24Mhz should work on most new monitors 

      clock_enable = ! clock_enable; 

      // H_count counts pixels (640 + extra time for sync signals) 
      // 
      //   <-Clock out RGB Pixel Row Data ->   <-H Sync-> 
      //   ------------------------------------__________-------- 
      //   0                           640   659       755    799 
      // 

		if ( clock_enable )
		begin 
			if (H_count >= 799)
				H_count = 0; 
			else 
				H_count = H_count + 1; 

	  // Generate Horizontal Sync Signal 
		if ((H_count <= 755) && (H_count >= 659))
	     VGA_HS = 0; 
		else 
	     VGA_HS = 1; 

	  // V_count counts rows of pixels (480 + extra time for sync signals) 
	  // 
	  //  <---- 480 Horizontal Syncs (pixel rows) -->  ->V Sync<- 
	  //  -----------------------------------------------_______------------ 
	  //  0                                       480    493-494          524 
	  // 
		if ((V_count >= 524) && (H_count >= 699))
			V_count = 0; 
		else if (H_count == 699)
			V_count = V_count + 1; 


	  // Generate Vertical Sync Signal 
		if ((V_count <= 494) && (V_count >= 493))
			VGA_VS = 0; 
		else 
			VGA_VS = 1; 


	  // Generate Video on Screen Signals for Pixel Data 
		if (H_count <= 639) 
			video_on_H = 1; 
		else 
			video_on_H = 0; 


		if (V_count <= 479)
			video_on_V = 1; 
		else 
			video_on_V = 0; 

	end 

	end : VIDEO_DISPLAY



endmodule
 
 

 
