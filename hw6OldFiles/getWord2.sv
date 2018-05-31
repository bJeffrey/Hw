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
      logic [7:0] tempWord = 8'b0;
      logic [2:0] count = 0;
      //Indicate when the A5 or C3 header has been headerFound
      //Also will change headerFound to 0 on reset
      always_comb begin
            headerFound = (word == 8'hA5) || (word == 8'hC3);
      end

      always_ff @(posedge clk_50, negedge reset_n) begin
            if (!reset_n)
                  word <= 0;
            else if ((data_ena == 1) && (count != 3'b111)) begin//data_ena is high and count doesn't equal 7
                  tempWord <= {serial_data,tempWord[7:1]};
                  // tempWord <= (tempWord >> 1);
                  // tempWord[7] <= serial_data;

                  count <= count + 3'b001;
            end
            else if ((data_ena == 1) && (count == 3'b111)) begin //count has been increased 6 times and is now 7.  During this clock cycle, the output is ready
                  // word <= (tempWord >> 1);
                  // word[7] <= serial_data;

                  word <= {serial_data,tempWord[7:1]};
                  count <= 3'b000;
            end
            else begin
                  //do nothing
                  tempWord <= tempWord;
            end
      end

endmodule
