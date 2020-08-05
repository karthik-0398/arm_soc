#define __MAIN_C__

#include <stdint.h>
#include <stdbool.h>

// Define the raw base address values for the i/o devices

#define AHB_SW_BASE                             0x40000000
#define AHB_OUT_BASE                            0x50000000

// Define pointers with correct type for access to 16-bit i/o devices
//
// The locations in the devices can then be accessed as:
//    SW_REGS[0]
//    SW_REGS[1]
//    SW_REGS[2]
//    OUT_REGS[0]
//    OUT_REGS[1]
//
//
volatile uint16_t* SW_REGS = (volatile uint16_t*) AHB_SW_BASE;
volatile uint16_t* OUT_REGS = (volatile uint16_t*) AHB_OUT_BASE;

#include <stdint.h>

//////////////////////////////////////////////////////////////////
// Functions provided to access i/o devices
//////////////////////////////////////////////////////////////////

void write_out(uint16_t value) {

  OUT_REGS[1] = 1;
  OUT_REGS[0] = value;

}

void set_out_invalid(void) {

  OUT_REGS[1] = 0;
  OUT_REGS[0] = 0;

}

uint16_t read_out(void) {

  return OUT_REGS[0];

}

uint16_t read_switches(int addr) {

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
// Other Functions
//////////////////////////////////////////////////////////////////

int factorial(int value) {

  if ( value == 0 ) return 1;
  else return ( value * factorial(value - 1) );

}

//////////////////////////////////////////////////////////////////
// Main Function
//////////////////////////////////////////////////////////////////

int main(void) {

  int switch_temp;

  write_out( 0x5555 );
  write_out( read_out() << 1 );
  write_out( read_out() >> 1 );

  // repeat forever (embedded programs generally do not terminate)
  while(1){

    wait_for_any_switch_data();
    
    if ( check_switches(0) ) {
      write_out( read_switches(0) );
    }

    if ( check_switches(1) ) {
      switch_temp = read_switches(1);
      if ( switch_temp < 8 ) {
        // if the switch value < 8 return the factorial
        write_out( factorial(switch_temp) );
      } else {
        // otherwise flag an error
        set_out_invalid();
      }
    }
  }

}

