// *********************************************************
// Program: clkSync.sv
// Description: asynchronous clock control for the two clocks
// Author: Jeffrey Noe
// Due: 6/8/2018
// *********************************************************

module clkSync (
     input              clkSec,
     input              clkMSec,
     input              resetN,
     output logic       changeSec
     );

     logic toggle;

      always_ff @(posedge clkSec) begin
            changeSec <= 1'b1;
      end
      always_ff @(negedge clkMSec) begin
            toggle <= 1'b1;
      end

      always_ff @(posedge clkMSec) begin
            if (toggle) begin
                  toggle <= 1'b0;
                  changeSec <= 1'b0;
            end
            else
                  changeSec <= changeSec;
      end

endmodule
