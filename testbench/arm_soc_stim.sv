module arm_soc_stim();
     
timeunit 1ns;
timeprecision 100ps;

  logic HRESETn, HCLK; 
  logic [15:0] Switches;
  logic [1:0] Buttons;
  logic [8:0] x1,x2,y1,y2;
  wire DataValid;
  wire LOCKUP;

  arm_soc dut(.HCLK, .HRESETn, .x1, .y1, .x2, .y2, .DataValid, .Switches, .Buttons, .LOCKUP);

  always
    begin
           HCLK = 0;
      #5ns HCLK = 1;
      #10ns HCLK = 0;
      #5ns HCLK = 0;
    end

  task press_button(input n);
      #1us Buttons[n] = 1;
      #1us Buttons[n] = 0;
  endtask
    

  initial
    begin
            HRESETn = 0;
            Buttons = 0;
            Switches = 1;
      #10.0ns HRESETn = 1;
            
      #10us Switches = 0;
      #5us press_button(0);
      #5us press_button(1);

      #10us Switches = 1;
      #5us press_button(0);
      #5us press_button(1);


      #10us Switches = 2;
      #5us press_button(0);
      #5us press_button(1);


      #10us Switches = 3;
      #5us press_button(0);
      #5us press_button(1);


      #10us Switches = 4;
      #5us press_button(0);
      #5us press_button(1);


      #20us Switches = 5;
      #5us press_button(0);
      #5us press_button(1);


      #20us Switches = 6;
      #5us press_button(0);
      #5us press_button(1);


      #20us Switches = 7;
      #5us press_button(0);
      #5us press_button(1);


      #20us Switches = 8;
      #5us press_button(0);
      #5us press_button(1);

      #30us Switches = 15;
      #5us press_button(0);
      #5us press_button(1);

      #40us Switches = 12;
      #5us press_button(0);
      #5us press_button(1);

      #50us $stop;
            $finish;
    end
       
endmodule
