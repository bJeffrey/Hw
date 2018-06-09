// *********************************************************
// Program: displayDigits.sv
// Description: displays digits to the clock
// Author: Jeffrey Noe
// Due: 6/8/2018
// *********************************************************

module displayDigits (
      input                   clkMSec,
      input                   resetN,
      input                   amPm,
      input [5:0]             min,
      input [2:0]             minMSB,
      input [3:0]             minLSB,
      input [4:0]             hour,
      output logic [7:0]      segmentData,
      output logic [2:0]      digitSelect
      );


endmodule
