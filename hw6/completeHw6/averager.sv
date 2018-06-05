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

            // always_ff @(posedge clk_2, negedge reset_n) begin
                  // if(!reset_n) begin
                        // accum <= '0;
                  // end
                  // else if (clear) begin
                        // accum <= '0;
                  // end
                  // else begin
                        // accum <= accum + data_in;
                  // end
            // end


            enum logic {
                  IDLE = 1'b0,
                  READ = 1'b1
            } presentState, nextState;

            //Handle reset and move to next state
            always_ff @(posedge clk_2, negedge reset_n) begin
                  if(!reset_n)
                        presentState <= IDLE;
                  else
                        presentState <= nextState;
            end

            //Move through the states of the state machine
            always_comb begin
                  unique case (presentState)
                        IDLE: begin
                              if (clear) begin
                                    nextState = presentState;
                                    accum = 8'b0;
                              end
                              else
                                    nextState = READ;
                        end
                        READ: begin
                              if (clear) begin
                                    nextState = IDLE;
                              end
                              else begin
                                    accum = accum + data_in;
                                    nextState = presentState;
                              end
                        end
                  endcase
            end


endmodule
