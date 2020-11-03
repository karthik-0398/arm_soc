module razzle (

        input logic CLOCK_50,
        input logic [3:0] KEY,
        input logic [10:0] x1, x2, y1, y2,
        output logic [9:0] LEDR ;
)

logic nReset;
logic [9:0] L1_detT ;
logic [9:0] L2_detT ;
logic [9:0] detT ;
logic [9:0] L1_positive;
logic [9:0] L2_positive,
logic [9:0] L3_positive ;

assign nReset=KEY[2]; // Keys are active low?

always_comb

          L1_detT   =   ((y2-y3) *  (x-x3)) + ((x3-x2) *  (y-y3)) ;
          L2_detT   =   ((y3-y1) *  (x-x3)) + ((x1-x3) *  (y-y3)) ;
          detT      =   ((y2-y3) * (x1-x3)) + ((x3-x2) * (y1-y3)) ;
          L1_positive = ((L1_detT >= 0) == (detT >= 0)) ;
          L2_positive = ((L2_detT >= 0) == (detT >= 0)) ;
          L3_positive = (((L1_detT + L2_detT) <= detT) == (detT >= 0)) ;
          if(L1_positive && L2_positive && L3_positive)
                write_pix(x,y,1);


endmodule
