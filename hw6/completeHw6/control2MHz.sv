// *********************************************************
// Program: control2MHz.sv
// Description: outputs the read signal for the fifo
// Author: Jeffrey Noe
// Due: 6/01/2018
// *********************************************************

module control2MHz(
      input                   clk_2,            //2 MHz input clock
      input                   reset_n,          //reset async active low
      input                   empty,            //from fifo, indicates when the fifo queue is empty
      output logic            rd,               //1 when we have received full signal from the fifo
      output logic	      done,            //1 when we have read 4 bytes from the fifo
      output logic            clear             //Clear the accumulator
      );

		enum logic [2:0] {
			ZERO = 3'b000,
			BYTE1 = 3'b001,
			BYTE2 = 3'b010,
			BYTE3 = 3'b011,
			BYTE4 = 3'b100
		} presentState, nextState;

		//Handle reset and move to next state
		always_ff @(posedge clk_2, negedge reset_n) begin
			if(!reset_n)
				presentState <= ZERO;
			else
				presentState <= nextState;
		end

		//Move through the states of the state machine
      		always_comb begin
			unique case (presentState)
				ZERO: begin
					if(!empty) begin
						nextState <= BYTE1;
                                    // rd <= 1;
					end
					else begin
						nextState <= presentState;
                              end
                              clear <= 1;
                              done <= 0;
                              rd <= 0;
				end
				BYTE1: begin
					if(!empty) begin
                                    rd <= 1;
						nextState <= BYTE2;
					end
					else
						nextState <= presentState;
                              clear = 0;
				end
				BYTE2: begin
					if(!empty) begin
						nextState <= BYTE3;
					end
					else
						nextState <= presentState;
				end
				BYTE3: begin
					if(!empty) begin
						nextState <= BYTE4;
					end
					else
						nextState <= presentState;
				end
				BYTE4: begin
					if(!empty) begin
                                    rd <= 1;
						done <= 1;
						nextState <= ZERO;
					end
					else
						nextState <= presentState;
				end
			endcase
		end
endmodule
