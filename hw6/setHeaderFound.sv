// *********************************************************
// Program: setHeaderFound.sv
// Description: identifies when the header has been received
// Author: Jeffrey Noe
// Due: 6/01/2018
// *********************************************************

module setHeaderFound(
      input [7:0]       word,               //write strobe to ram
      output logic      headerFound
      );

      always_comb begin
            headerFound = (word == 8'hA5) || (word == 8'hC3);
      end


endmodule
