// *********************************************************
// Program: control2MHz.sv
// Description: outputs the read signal for the fifo
// Author: Jeffrey Noe
// Due: 6/01/2018
// *********************************************************

module control2MHz(
      input                   clk_2,            //2 MHz input clock
      input                   reset_n,          //reset async active low
      input                   full,             //from fifo to indicate when 4 bytes have been written
      input                   empty,            //from fifo, indicates when the fifo queue is empty
      output logic            rd                //1 when we have received full signal from the fifo
      );
      reg keepReading = 0;
      always_ff @(posedge clk_2, negedge reset_n) begin
            if(!reset_n)
                  rd <= 0;
            else if (full | keepReading) begin
                  if (empty)
                        keepReading <= 0;
                  else
                        keepReading <= 1;
                  rd <= 1;
            end
            else
                  rd <= 0;
      end

endmodule
