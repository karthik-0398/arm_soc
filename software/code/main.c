#define __MAIN_C__

#include <stdint.h>
#include <stdbool.h>

// Define the raw base address values for the i/o devices

#define AHB_SW_BASE                             0x40000000
#define AHB_OUT_BASE                            0x50000000

// Define pointers with correct type for access to 32-bit i/o devices
//
// The locations in the devices can then be accessed as:
//    SW_REGS[0]
//    SW_REGS[1]
//    SW_REGS[2]
//    OUT_REGS[0]
//    OUT_REGS[1]
//
volatile uint16_t* SW_REGS = (volatile uint16_t*) AHB_SW_BASE;
volatile uint16_t* OUT_REGS = (volatile uint16_t*) AHB_OUT_BASE;

#include <stdint.h>

//////////////////////////////////////////////////////////////////
// Functions provided to access i/o devices
//////////////////////////////////////////////////////////////////

void write_out_0(uint16_t value_0) {

  OUT_REGS[0] = value_0;

}
void write_out_1(uint16_t value_1) {

  OUT_REGS[1] = value_1;

}
void write_out_2(uint16_t value_2) {

  OUT_REGS[2] = value_2;

}
void write_out_3(uint16_t value_3) {

  OUT_REGS[3] = value_3;

}
void set_out_invalid(void) {
	
  OUT_REGS[3] = 0;
  OUT_REGS[2] = 0;
  OUT_REGS[1] = 0;
  OUT_REGS[0] = 0;

}

uint32_t read_out(void) {

  return OUT_REGS[0];
  return OUT_REGS[1];
  return OUT_REGS[2];
  return OUT_REGS[3];  
}

uint32_t read_switches(int addr) {

  return SW_REGS[addr];

}

bool check_switches(int addr) {

  int status, switches_ready;
  
  status = SW_REGS[2];
  
  // use the addr value to select one bit of the status register
  switches_ready = (status >> addr) & 1;
  
  return (switches_ready == 1);

}

void wait_for_any_switch_data(void) {

  // this is a 'busy wait'

  //  ( it should only be used if there is nothing
  //   else for the embedded system to do )

  while ( SW_REGS[2] == 0 );
  
  return;

}


//////////////////////////////////////////////////////////////////
// Main Function
//////////////////////////////////////////////////////////////////

int main(void) {

  int switch_temp;

  write_out_0( 0x00000000 ); 
  write_out_1( 0x00000000 );
  write_out_2( 0x11110000 );
  write_out_3( 0x11110000 );  
	
    


}
