// *********************************************************
// Program: control50MHz.sv
// Description: outputs the write signal for the fifo
// Author: Jeffrey Noe
// Due: 6/01/2018
// *********************************************************

module control50MHz(
      input                   clk_50,            //2 MHz input clock
      input                   reset_n,          //reset async active low
      input                   data_ena,         //from outside.  enables serial write
      input                   headerFound,      //from getWord, 1 when a5 or c3 has been found
      output logic            wr                //1 when we must write to the fifo
      );

      enum logic [2:0]{
      	HEADER = 3'b000,
      	BYTE1 = 3'b001,
            BYTE2 = 3'b010,
            BYTE3 = 3'b011,
            BYTE4 = 3'b110
      } presentState, nextState;

      enum logic {
            ALLOW = 1'b0,
            NOTALLOW = 1'b1
      } allowPresentState, allowNextState;

      enum logic {
            TEMPPACKET = 1'b0,
            WAITING = 1'b1
      } waitingPresentState, waitingNextState;

      assign byteAssembled = (!data_ena) && (allowPresentState == ALLOW);

      always_ff @(posedge clk_50, negedge reset_n) begin
            if(!reset_n)
      		waitingPresentState <= WAITING;
      	else
      		waitingPresentState <= waitingNextState;
      end

      //Handle reset and move to next state
      always_ff @(posedge clk_50, negedge reset_n) begin
            if(!reset_n)
      		presentState <= HEADER;
      	else
      		presentState <= nextState;
      end

      //Handle reset and move to next state
      always_ff @(posedge clk_50, negedge reset_n) begin
            if(!reset_n)
      		allowPresentState <= NOTALLOW;
      	else
      		allowPresentState <= allowNextState;
      end

      //Move through the states of the state machine
      always_comb begin
      	unique case (allowPresentState)
      		NOTALLOW: begin
                        if(data_ena) begin
                              allowNextState = ALLOW;
                              wr = 0;
                        end
                        else begin
                              allowNextState = NOTALLOW;
                              wr = 0;
                        end
                  end
                  ALLOW: begin
                        if(!data_ena) begin
                              allowNextState = NOTALLOW;
                              if (!headerFound)
                                    wr = 1;
                              else
                                    wr = 0;
                        end
                        else begin
                              allowNextState = ALLOW;
                              wr = 0;
                        end
                  end
      	endcase
      end

      always_comb begin
      	unique case (presentState)
      		HEADER: begin
                        if(headerFound)
                              nextState = BYTE1;
                        else
                              nextState = presentState;
                  end
                  BYTE1: begin
                        if(byteAssembled)
                              nextState = BYTE2;
                        else
                              nextState = presentState;
                  end
                  BYTE2: begin
                        if(byteAssembled)
                              nextState = BYTE3;
                        else
                              nextState = presentState;
                  end
                  BYTE3: begin
                        if(byteAssembled)
                              nextState = BYTE4;
                        else
                              nextState = presentState;
                  end
                  BYTE4: begin
                        if(byteAssembled)
                              nextState = HEADER;
                        else
                              nextState = presentState;
                  end
      	endcase
      end

      always_comb begin
            unique case (waitingPresentState)
                  WAITING: begin
                        if(presentState == HEADER) begin
                              waitingNextState = TEMPPACKET;
                        end
                        else begin
                              waitingNextState = waitingPresentState;
                        end
                  end
                  TEMPPACKET: begin
                        if(headerFound) begin
                              waitingNextState = WAITING;
                        end
                        else begin
                              waitingNextState = waitingPresentState;
                        end
                  end
            endcase
      end

endmodule
