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
      input [2:0]             minMSB,
      input [3:0]             minLSB,
      input [1:0]             hourMSB,
      input [3:0]             hourLSB,
      output logic [7:0]      segmentData,
      output logic [2:0]      digitSelect
      );

      //Declare constant for display
	parameter ZERO = 7'b;
	parameter ONE = 7'b;
	parameter TWO = 7'b;
	parameter THREE = 7'b;
	parameter FOUR = 7'b;
	parameter FIVE = 7'b;
	parameter SIX = 7'b;
	parameter SEVEN = 7'b;
	parameter EIGHT = 7'b;
	parameter NINE = 7'b;


endmodule
