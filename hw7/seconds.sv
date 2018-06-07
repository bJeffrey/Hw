// *********************************************************
// Program: seconds.sv
// Description: counts seconds on the clock
// Author: Jeffrey Noe
// Due: 6/8/2018
// *********************************************************

module seconds (
      input             clkMSec,
      input             resetN,
      input             changeSec,
      output reg        changeMin
      );

      logic [5:0] sec = 6'b0;

      enum logic [2:0] {
            IDLE = 3'b000,
            CHECK = 3'b001,
            RESETSECONDS = 3'b010,
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
                        if(changeSec)
                              nextState = CHECK;
                        else
                              nextState = IDLE;
                        changeMin = 1'b0;
                  end
                  CHECK: begin
                        if(sec == 6'd59)
                              nextState = RESETSECONDS;
                        else
                              nextState = INC;
                  end
                  RESETSECONDS: begin
                        sec = 6'b0;
                        changeMin = 1'b1;
                        nextState = IDLE;
                  end
                  RESETCLOCK: begin
                        sec = 6'b0;
                        changeMin = 1'b0;
                        nextState = IDLE;
                  end
                  INC: begin
                        sec = sec + 6'b1;
                        nextState = IDLE;
                  end
            endcase
      end



endmodule
