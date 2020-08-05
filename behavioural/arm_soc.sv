// Example code for an M0 AHBLite System
//  Iain McNally
//  ECS, University of Soutampton

module arm_soc(

  input HCLK, HRESETn,
  
  input [15:0] Switches, 
  input [1:0] Buttons, 
  output logic [8:0] x1, x2, y1, y2,	
  output DataValid,
  output LOCKUP

);
 
timeunit 1ns;
timeprecision 100ps;


  // Global & Master AHB Signals
  wire [31:0] HADDR, HWDATA, HRDATA;
  wire [1:0] HTRANS;
  wire [2:0] HSIZE, HBURST;
  wire [3:0] HPROT;
  wire HWRITE, HMASTLOCK, HRESP, HREADY;

  // Per-Slave AHB Signals
  wire HSEL_RAM, HSEL_SW, HSEL_DOUT;
  wire [31:0] HRDATA_RAM, HRDATA_SW, HRDATA_DOUT;
  wire HREADYOUT_RAM, HREADYOUT_SW, HREADYOUT_DOUT;

  // Non-AHB M0 Signals
  wire TXEV, RXEV, SLEEPING, SYSRESETREQ, NMI;
  wire [15:0] IRQ;
  
  // Set this to zero because simple slaves do not generate errors
  assign HRESP = '0;

  // Set all interrupt and event inputs to zero (unused in this design) 
  assign NMI = '0;
  assign IRQ = {16'b0000_0000_0000_0000};
  assign RXEV = '0;

  // Coretex M0 DesignStart is AHB Master
  CORTEXM0DS m0_1 (

    // AHB Signals
    .HCLK, .HRESETn,
    .HADDR, .HBURST, .HMASTLOCK, .HPROT, .HSIZE, .HTRANS, .HWDATA, .HWRITE,
    .HRDATA, .HREADY, .HRESP,                                   

    // Non-AHB Signals
    .NMI, .IRQ, .TXEV, .RXEV, .LOCKUP, .SYSRESETREQ, .SLEEPING

  );


  // AHB interconnect including address decoder, register and multiplexer
  ahb_interconnect interconnect_1 (

    .HCLK, .HRESETn, .HADDR, .HRDATA, .HREADY,

    .HSEL_SIGNALS({HSEL_DOUT,HSEL_SW,HSEL_RAM}),
    .HRDATA_SIGNALS({HRDATA_DOUT,HRDATA_SW,HRDATA_RAM}),
    .HREADYOUT_SIGNALS({HREADYOUT_DOUT,HREADYOUT_SW,HREADYOUT_RAM})

  );


  // AHBLite Slaves
        
  ahb_ram ram_1 (

    .HCLK, .HRESETn, .HADDR, .HWDATA, .HSIZE, .HTRANS, .HWRITE, .HREADY,
    .HSEL(HSEL_RAM),
    .HRDATA(HRDATA_RAM), .HREADYOUT(HREADYOUT_RAM)

  );

  ahb_switches switches_1 (

    .HCLK, .HRESETn, .HADDR, .HWDATA, .HSIZE, .HTRANS, .HWRITE, .HREADY,
    .HSEL(HSEL_SW),
    .HRDATA(HRDATA_SW), .HREADYOUT(HREADYOUT_SW),

    .Switches(Switches), .Buttons(Buttons)

  );

  ahb_out out_1 (

    .HCLK, .HRESETn, .HADDR, .HWDATA, .HSIZE, .HTRANS, .HWRITE, .HREADY,
    .HSEL(HSEL_DOUT),
    .HRDATA(HRDATA_DOUT), .HREADYOUT(HREADYOUT_DOUT),

    .x1(x1), .x2(x2), .y1(y1), .y2(y2), .DataValid(DataValid)

  );
  

// razzle 
 razzle raz_1( 
	.x1(x1), .x2(x2), .y1(y1), .y2(y2)
	) ;
endmodule
