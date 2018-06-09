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
      output logic [1:0]      hourMSB,
      output logic [3:0]      hourLSB
      );

      logic [4:0] hour;
      enum logic [3:0] {
            IDLE = 4'b0000,
            CHECKFORMAT = 4'b0001,
            CHECKSTDHOUR = 4'b0010,
            INC = 4'b0011,
            SETHOURTO01 = 4'b0100,
            INCANDFLIPAMPM = 4'b0101,
            CHECKMILHOUR = 4'b0110,
            SETHOURTO00 = 4'b0111,
            RESETCLOCK = 4'b1000
      } presentState, nextState;

      //Handle reset and move to next state
      always_ff @(posedge clkMSec, negedge resetN) begin
            if(!resetN)
                  presentState <= RESETCLOCK;
            else
                  presentState <= nextState;
      end

      //Move through the states of the state machine
      always_comb begin
            unique case (presentState)
                  IDLE: begin
                        if(changeHour)
                              nextState = CHECKFORMAT;
                        else
                              nextState = IDLE;
                  end
                  CHECKFORMAT: begin
                        if(milTime)
                              nextState = CHECKMILHOUR;
                        else
                              nextState = CHECKSTDHOUR;
                        end
                  CHECKSTDHOUR: begin
                        if(hour < 4'd11)
                              nextState = INC;
                        else if(hour == 4'd11)
                              nextState = INCANDFLIPAMPM;
                        else//hour == 12
                              nextState = SETHOURTO01;
                  end
                  INC: begin
                        if(milTime == 1'b0 && hour == 5'd12) begin
                              hourMSB = 2'd0;
                              hourLSB = 4'd1;
                        end
                        else if(hourLSB == 4'd9) begin
                              hourMSB = hourMSB + 2'd1;
                              hourLSB = 4'd0;
                        end
                        else
                              hourLSB = hourLSB + 4'd1;
                        hour = hour + 5'd1;
                        nextState = IDLE;
                  end
                  SETHOURTO01: begin
                        hourMSB = 2'd0;
                        hourLSB = 4'd1;
                        hour = 5'd1;
                        nextState = IDLE;
                  end
                  INCANDFLIPAMPM: begin
                  if(hour == 5'd12) begin
                        hourMSB = 2'd0;
                        hourLSB = 4'd1;
                  end
                  else if(hourLSB == 4'd9) begin
                        hourMSB = hourMSB + 2'd1;
                        hourLSB = 4'd0;
                  end
                  else
                        hourLSB = hourLSB + 4'd1;
                  hour = hour + 5'd1;
                  amPm = ~amPm;
                  nextState = IDLE;
                  end
                  CHECKMILHOUR: begin
                        if(hour == 5'd23)
                              nextState = SETHOURTO00;
                        else
                              nextState = INC;
                  end
                  SETHOURTO00: begin
                        hour = 5'd0;
                        hourMSB = 2'd0;
                        hourLSB = 4'd0;
                        nextState = IDLE;
                  end
                  RESETCLOCK: begin
                        amPm = 1'b0;
                        if(milTime) begin
                              hourMSB = 2'd0;
                              hourLSB = 4'd0;
                              hour = 5'd0;
                        end
                        else begin
                              hourMSB = 2'd1;
                              hourLSB = 4'd2;
                              hour = 5'd12;
                        end
                        nextState = IDLE;
                  end
            endcase
      end
endmodule
