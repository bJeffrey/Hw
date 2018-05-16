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
      output reg      done,       //validates output value
      );

      reg [31:0] tempA;//temporary register for swapping a_in
      reg [31:0] tempB;//temporary register for swapping b_in
      enum logic [2:0] {
            IDLE = 3'b00;
            TEST = 3'b01;
            SUBTRACT = 3'b10;
            SWAP = 3'b11;
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
                        if (start)
                              nextState = TEST;
                        else
                              nextState = IDLE;
                  end
                  TEST: begin
                        if (a_in < b_in) begin//Use a temp registers to swap A and B.  Done in this state allows the swap state to take 1 cycle
                              tempA = a_in;
                              tempB = b_in;
                              nextState = SWAP;
                        end
                        else if (a_in == 32'd0) begin//Is the gcd a_in?
                              result = b_in;
                              nextState = IDLE;
                        end
                        else if (b_in == 32'd0) begin//Is the gcd b_in?
                              result = a_in;
                              nextState = IDLE;
                        end
                        else//Not done finding the gcd and do not need to swap a and b
                              nextState = SUBTRACT;
                  end
                  SUBTRACT: begin
                        a_in = a_in - b_in;
                        nextState = TEST;
                  end
                  SWAP: begin
                        a_in = tempB;
                        b_in = tempA;
                        nextState = SUBTRACT;
                  end
            endcase
      end
