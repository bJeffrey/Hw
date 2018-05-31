// *********************************************************
// Program: averager.sv
// Description: averages 4 temperature readings
// Author: Jeffrey Noe
// Due: 6/01/2018
// *********************************************************

module averager(
            input                   clk_2,                  //read clock
            input                   reset_n,                //reset active low
            input                   rd,                     //read enable
            input [7:0]             data_in,                //data in
            input                   clear,                  //clear the accumulator
            output logic [7:0]      averagedTempReading     //1 averaged temperature reading
            );

            logic [7:0] accum = '0;

            assign averagedTempReading = accum >> 2;

            always_ff @(posedge clk_2, negedge reset_n) begin
                  if(!reset_n) begin
                        accum <= '0;
                  end
                  else if (clear) begin
                        accum <= '0;
                  end
                  else begin
                        accum <= accum + data_in;
                  end
            end

endmodule
