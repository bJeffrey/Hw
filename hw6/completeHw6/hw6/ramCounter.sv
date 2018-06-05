// *********************************************************
// Program: ramCounter.sv
// Description: outputs the read signal for the fifo
// Author: Jeffrey Noe
// Due: 6/01/2018
// *********************************************************

module ramCounter(
      input                   clk_2,            //2 MHz input clock
      input                   reset_n,          //reset async active low
      input                   done,             //high when 4 bytes have been read
      output logic [10:0]     ramAddress        //Address to store the temperature reading.  Starts with 0x07FF.  Ends with 0x0000
      );

      logic [10:0] address = 11'h07FF;
      logic flipBit = 1'b0;

      always_ff @(posedge clk_2, negedge reset_n) begin
            if(!reset_n) begin
                  address <= 11'h07FF;
                  flipBit <= 1'b0;
            end
            else if(done) begin
                  ramAddress <= address;
                  flipBit <= 1'b1;
            end
            else if(address == 11'h0000) begin
            address <= 11'h07FF;
            flipBit <= 1'b0;
            end
            else if(flipBit) begin
                  flipBit <= 1'b0;
                  address <= address - 11'h0001;
            end
            else begin

            end
      end

endmodule
