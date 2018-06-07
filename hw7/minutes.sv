// *********************************************************
// Program: minutes.sv
// Description: counts minutes on the clock
// Author: Jeffrey Noe
// Due: 6/8/2018
// *********************************************************

module minutes (
      input                   clkMSec,
      input                   resetN,
      input                   changeMin,
      output logic            changeHour,
      output logic [5:0]      min
      );

      enum logic [2:0] {
            IDLE = 3'b000,
            CHECK = 3'b001,
            RESETMINUTES = 3'b010,
            RESETCLOCK = 3'b011,
            INC = 3'b100
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
                              if(changeMin)
                                    nextState = CHECK;
                              else
                                    nextState = IDLE;
                              changeHour = 1'b0;
                        end
                        CHECK: begin
                              if(min == 6'd59)
                                    nextState = RESETMINUTES;
                              else
                                    nextState = INC;
                        end
                        RESETMINUTES: begin
                              min = 6'b0;
                              changeHour = 1'b1;
                              nextState = IDLE;
                        end
                        RESETCLOCK: begin
                              min = 6'b0;
                              changeHour = 1'b0;
                              nextState = IDLE;
                        end
                        INC: begin
                              min = min + 6'b1;
                              nextState = IDLE;
                        end
                  endcase
            end




endmodule
