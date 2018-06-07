// *********************************************************
// Program: hours.sv
// Description: counts hours on the clock
// Author: Jeffrey Noe
// Due: 6/8/2018
// *********************************************************

module hours (
      input                   clkMSec,
      input                   resetN,
      input                   milTime,
      input                   changeHour,
      output logic            amPm,
      output logic [4:0]      hour
      );

            enum logic [3:0] {
                  IDLE = 4'b0000,
                  CHECKFORMAT = 4'b0001,
                  CHECKSTDHOUR = 4'b0010,
                  INC = 4'b0011,
                  SETHOURTO1 = 4'b0100,
                  INCANDFLIPAMPM = 4'b0101,
                  CHECKMILHOUR = 4'b0110,
                  SETHOURTO00 = 4'b0111,
                  RESETCLOCK = 4'b1000
            } presentState, nextState;

                  //Handle reset and move to next state
                  always_ff @(posedge clkMSec, negedge resetN) begin
                        if(!resetN) begin
                              presentState <= RESETCLOCK;
                        end
                        else begin
                              presentState <= nextState;
                        end
                  end

                  //Move through the states of the state machine
                  always_comb begin
                        unique case (presentState)
                              IDLE: begin

                              end
                              CHECKFORMAT: begin

                              end
                              CHECKSTDHOUR: begin

                              end
                              INC: begin

                              end
                              SETHOURTO1: begin

                              end
                              INCANDFLIPAMPM: begin

                              end
                              CHECKMILHOUR: begin

                              end
                              SETHOURTO00: begin

                              end
                              RESETCLOCK: begin

                              end

                        endcase
                  end


endmodule
