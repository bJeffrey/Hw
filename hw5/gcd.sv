// *********************************************************
// Program: gcd.sv
// Description: Module that finds the greatest common divider
// Author: Jeffrey Noe
// Due: 5/18/2018
// *********************************************************
//Check out moore type state machine from week 3

module gcd(
      input [31:0]      a_in,     //operand_a
      input [31:0]      b_in,     //operand_b
      input             start,    //validates the input data
      input             reset_n,  //reset
      input             clk,      //clock
      output reg [31:0] result,   //output of GCD engine
      output reg      done       //validates output value
      );

      reg [31:0] tempA;//temporary register for swapping aIn
      reg [31:0] tempB;//temporary register for swapping bIn
      reg [31:0] aIn;
      reg [31:0] bIn;
      enum logic [2:0] {
            IDLE = 3'b00,
            TEST = 3'b01,
            SUBTRACT = 3'b10,
            SWAP = 3'b11
      } presentState, nextState;//moves through states in the case statement inside always_comb

      //Handle reset and move to next state
      always_ff @(posedge clk, negedge reset_n) begin
            if (!reset_n)
                  presentState <= IDLE;
            else
                  presentState <= nextState;
      end

      always_comb begin
            unique case (presentState)
                  IDLE: begin
                        if (start) begin
                              aIn = a_in;
                              bIn = b_in;
                              nextState = TEST;
                        end
                        else
                              nextState = IDLE;
                  end
                  TEST: begin
                        if (aIn < bIn) begin//Use a temp registers to swap A and B.  Done in this state allows the swap state to take 1 cycle
                              tempA = aIn;
                              tempB = bIn;
                              nextState = SWAP;
                        end
                        else if (aIn == 32'd0) begin//Is the gcd aIn?
                              result = bIn;
                              nextState = IDLE;
                        end
                        else if (bIn == 32'd0) begin//Is the gcd bIn?
                              result = aIn;
                              nextState = IDLE;
                        end
                        else//Not done finding the gcd and do not need to swap a and b
                              nextState = SUBTRACT;
                  end
                  SUBTRACT: begin
                        aIn = aIn - bIn;
                        nextState = TEST;
                  end
                  SWAP: begin
                        aIn = tempB;
                        bIn = tempA;
                        nextState = SUBTRACT;
                  end
            endcase
      end
endmodule
