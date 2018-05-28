// *********************************************************
// Program: getWord.sv
// Description: identifies when the header has been received
// Author: Jeffrey Noe
// Due: 6/01/2018
// *********************************************************

module getWord(
      input                   clk_50,           //50 MHz input clock
      input                   reset_n,          //reset async active low
      input                   serial_data,      //serial input data
      input                   data_ena,         //serial data enable
      output logic [7:0]      word,             //write strobe to ram
      output logic            headerFound       //1 when the word is a5 ro c3.  0 Otherwise
      );

      //Indicate when the A5 or C3 header has been headerFound
      //Also will change headerFound to 0 on reset
      always_comb begin
            headerFound = (word == 8'hA5) || (word == 8'hC3);
      end

      always_ff @(posedge clk_50, negedge reset_n) begin
            if (!reset_n)
                  word <= 0;
            else if (data_ena)
                  word <= {serial_data,word[7:1]};
            else begin
                  //Do nothing
            end
      end

endmodule
