// *********************************************************
// Program: control50MHz.sv
// Description: controls the write strobe for the 50 MHz clock
// Author: Jeffrey Noe
// Due: 6/01/2018
// *********************************************************

module control50MHz(

	input	clk_50,
	input	reset_n,
	input	data_ena,
	input	headerFound,
	output	reg wr
	);

	enum reg {
		WAITING = 1'b0,
		WORKING  = 1'b1
  	} serialPresentState, serialNextState;

  	reg byteFlag;
	//controls the serial state (working v. waiting)
  	always_ff @(posedge clk_50, negedge reset_n) begin
      	if(!reset_n) begin
	  		serialPresentState <= WAITING;
		end
      	else if (data_ena) begin
	  		serialPresentState <= WORKING;
		end
      	else begin
	  		serialPresentState <= WAITING;
		end
   	end

	enum reg [2:0]{
  		HEADER = 3'b000,
  		BYTE1	= 3'b001,
		BYTE2	= 3'b010,
		BYTE3	= 3'b011,
  		BYTE4	= 3'b100
  	} bytePresentState, byteNextState;

	//Once a header is recieved, move from one byte to the next for 4 bytes
  	always_ff @(posedge clk_50, negedge reset_n) begin
      	if(!reset_n) begin
			bytePresentState <= HEADER;
		end
      	else begin
	  		bytePresentState <= byteNextState;
		end
  	end

	enum logic {
		INVALIDTYPE	= 1'b0,
		VALIDTYPE	= 1'b1
  	}validTypePresentState, validTypeNextState;

	//check the validity of the state
  	always_ff @(posedge clk_50, negedge reset_n) begin
      	if(!reset_n) begin
	  		validTypePresentState	<= INVALIDTYPE;
		end
      	else begin
	  		validTypePresentState	<= validTypeNextState;
		end
    	end

	enum logic {
  		DONTWRITE	= 1'b0,
		WRITE	= 1'b1
  	}writeToFifoPresentState, writeToFifoNextState;

	//State machine for writing/not writing
  	always_ff @(posedge clk_50, negedge reset_n) begin
      	if(!reset_n) begin
	  		writeToFifoPresentState	<= DONTWRITE;
		end
      	else begin
			writeToFifoPresentState	<= writeToFifoNextState;
		end
    	end

	//put byteFlag high when data_ena is low and serialPresentState is not 0 (waiting)
	always_comb begin
      	byteFlag = (!data_ena && serialPresentState);
      end

	//move through each of four bytes
	always_comb begin
		case(bytePresentState)
	  		HEADER: begin
	      		if(byteFlag == 1) begin
		  			byteNextState = BYTE1;
				end
	      		else begin
		  			byteNextState = HEADER;
				end
	    		end
	  		BYTE1: begin
	      		if(byteFlag == 1) begin
		  			byteNextState = BYTE2;
				end
	      		else begin
		  			byteNextState = BYTE1;
				end
	    		end
	  		BYTE2: begin
	      		if(byteFlag == 1) begin
		  			byteNextState = BYTE3;
				end
	      		else begin
		  			byteNextState = BYTE2;
				end
	    		end
	  		BYTE3: begin
	      		if(byteFlag == 1) begin
		  			byteNextState = BYTE4;
				end
	      		else begin
		  			byteNextState = BYTE3;
				end
	    		end
	  		BYTE4: begin
	      		if(byteFlag == 1) begin
		  			byteNextState = HEADER;
				end
	      		else begin
		  			byteNextState = BYTE4;
				end
	    		end
		endcase
	end

	//check for valid/invalid byte
	always_comb begin
        case(validTypePresentState)
	  	INVALIDTYPE: begin
	      	if((headerFound == 1) && (byteNextState == BYTE1)) begin
		  		validTypeNextState = VALIDTYPE;
			end
	      	else begin
		  		validTypeNextState = INVALIDTYPE;
			end
	    	end
	  	VALIDTYPE: begin
	      	if(byteNextState == HEADER) begin
		  		validTypeNextState = INVALIDTYPE;
			end
	      	else begin
		  		validTypeNextState = VALIDTYPE;
			end
	    	end
	  endcase
      end

	//control when to write/don't write
	always_comb begin
      	case (writeToFifoPresentState)
	  		DONTWRITE: begin
	  			if((byteFlag) && (bytePresentState != HEADER) && (validTypePresentState == VALIDTYPE)) begin
		  			writeToFifoNextState = WRITE;
				end
	      		else begin
		  			writeToFifoNextState = DONTWRITE;
				end
	    		end
	  		WRITE: begin
	      		writeToFifoNextState = DONTWRITE;
	    		end
		endcase
      end

	//final send of the write strobe.  Sent to fifo
	always_comb begin
		if(writeToFifoPresentState == WRITE) begin
	    		wr = 1;
	  	end
		else begin
	    		wr = 0;
	  	end
      end
endmodule
