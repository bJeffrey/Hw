// *********************************************************
// Program: gcd.sv
// Description: Module that finds the greatest common divider
// Author: Jeffrey Noe
// Due: 5/18/2018
// *********************************************************

module gcd(
      input [31:0]      a_in,     //operand_a
      input [31:0]      b_in,     //operand_b
      input             start,    //validates the input data
      input             reset_n,  //reset
      input             clk,      //clock
      output reg [31:0] result,   //output of GCD engine
      output reg      done       //validates output value
      );

      reg [31:0] tempA;       //temporary register for swapping aIn
      reg [31:0] tempB;       //temporary register for swapping bIn
      reg [31:0] aIn;         //calculates gcd
      reg [31:0] bIn;         //calculates gcd
      enum logic [2:0] {      //moves through states in the case statement inside always_comb
            IDLE = 3'b00,
            TEST = 3'b01,
            SUBTRACT = 3'b10,
            SWAP = 3'b11
      } presentState, nextState;

      //Handles reset and move to next state
      always_ff @(posedge clk, negedge reset_n) begin
            if (!reset_n)
                  presentState <= IDLE;
            else
                  presentState <= nextState;
      end

      //Move through each state of the state machine
      always_comb begin
            unique case (presentState)
                  IDLE: begin
                        if (start) begin//start signal detected.  Set registers to input, done to 0, and next state to TEST
                              aIn = a_in;
                              bIn = b_in;
                              done = 1'b0;
                              nextState = TEST;
                        end
                        else//continue to IDLE
                              nextState = IDLE;
                  end
                  TEST: begin
                        if (aIn < bIn) begin//Use a temp registers to swap A and B.
                                            //Done in this state allows the SWAP state (next state) to take 1 cycle
                              tempA = aIn;
                              tempB = bIn;
                              nextState = SWAP;
                        end
                        else if (aIn == 32'd0) begin//Is the gcd bIn?  If so, assign it to output.  Signal done.  Return to IDLE
                              result = bIn;
                              done = 1'b1;
                              nextState = IDLE;
                        end
                        else if (bIn == 32'd0) begin//Is the gcd aIn?  If so, assign it to output.  Signal done.  Return to IDLE
                              result = aIn;
                              done = 1'b1;
                              nextState = IDLE;
                        end
                        else//Not done finding the gcd and do not need to swap a and b.  Continue the algorithm by moving to SUBTRACT
                              nextState = SUBTRACT;
                  end
                  SUBTRACT: begin//subtract aIn and bIn from aIn and move to TEST.  Saves from any division or multiplication
                        aIn = aIn - bIn;
                        nextState = TEST;
                  end
                  SWAP: begin//bIn was found to be greater than aIn.  tempA and tempB assigned last cycle.  swap them and move to SUBTRACT
                        aIn = tempB;
                        bIn = tempA;
                        nextState = SUBTRACT;
                  end
            endcase
      end
endmodule
