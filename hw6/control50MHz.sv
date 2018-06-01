module ctrl_50(

	input	clk_50,
	input	reset_n,
	input	data_ena,
	input	headerFound,
	output	reg wr
);

////////////////////////////////////////
// BYTE1 out of BYTE4 state machine ///////
// BYTE2 modes only								 ///////
// WAITING and WORKING          ///////
// serial byte									 ///////
  enum reg [0:0]{
	WTF_1 = 'x,
	WAITING = 1'b0,
	WORKING  = 1'b1
  } serialBytePresentState, serialByteNextState;

  reg serialFlag;

  always_ff @(posedge clk_50, negedge reset_n)
    begin
      if(!reset_n)
        begin
	  serialBytePresentState <= WAITING;
	end
      else if (data_ena)
        begin
	  serialBytePresentState <= WORKING;
	end
      else
        begin
	  serialBytePresentState <= WAITING;
	end
    end

////////////////////////////////////////
// BYTE2 out of BYTE4 state machine  //////
// BYTE1 header											//////
// BYTE4 bytes											//////
// the_byte												//////
  enum reg [2:0]{
  	HEADER	= 3'b000,
  	BYTE1	= 3'b001,
	BYTE2	= 3'b010,
	BYTE3	= 3'b011,
  	BYTE4	= 3'b100,
	WTF_2	= 'x
  } presentState, nextState;

  always_ff @(posedge clk_50, negedge reset_n)
    begin
      if(!reset_n)
        begin
	  presentState <= HEADER;
	end
      else
        begin
	  presentState <= nextState;
	end
    end

////////////////////////////////////////
//  BYTE3 out of BYTE4 state machine ////
// GOOD = temp data                 ////
// BAD  = something else   					////
// data_type												////
  enum reg [0:0]{
	INVALIDBYTE	= 1'b0,
	VALIDBYTE	= 1'b1,
	WTF_3		= 'x
  }wordTypePresentState, wordTypeNextState;

  always_ff @(posedge clk_50, negedge reset_n)
    begin
      if(!reset_n)
        begin
	  wordTypePresentState	<= INVALIDBYTE;
	end
      else
        begin
	  wordTypePresentState	<= wordTypeNextState;
	end
    end

////////////////////////////////////////
// BYTE4 out of BYTE4 state machine  /////
// BYTE2 modes only									 /////
// WRITE and DONTWRITE								 /////
// wr_fifo											 /////
  enum reg [0:0]{
  	DONTWRITE	= 1'b0,
	WRITE	= 1'b1,
	WTF_4	= 'x
  }writeToFifoPresentState, writeToFifoNextState;

  always_ff @(posedge clk_50, negedge reset_n)
    begin
      if(!reset_n)
        begin
	  writeToFifoPresentState	<= DONTWRITE;
	end
      else
        begin
	  writeToFifoPresentState	<= writeToFifoNextState;
	end
    end


////////////////////////////////////////
// keep tracking the data flow
// serialFlag == 1
// when
// data_ena == 0
// serialBytePresentState == WORKING
////////////////////////////////////////
   always_comb
      begin
        serialFlag = (!data_ena && serialBytePresentState);
      end
////////////////////////////////////////

////////////////////////////////////////
// loop through all of the bytes
// clockwiselly, and go back to
// header
////////////////////////////////////////

   always_comb
      begin
        case(presentState)
	  HEADER:
	    begin
	      if(serialFlag == 1)
	        begin
		  nextState = BYTE1;
		end
	      else
	        begin
		  nextState = HEADER;
		end
	    end
	  BYTE1:
	    begin
	      if(serialFlag == 1)
	        begin
		  nextState = BYTE2;
		end
	      else
	        begin
		  nextState = BYTE1;
		end
	    end
	  BYTE2:
	    begin
	      if(serialFlag == 1)
	        begin
		  nextState = BYTE3;
		end
	      else
	        begin
		  nextState = BYTE2;
		end
	    end
	  BYTE3:
	    begin
	      if(serialFlag == 1)
	        begin
		  nextState = BYTE4;
		end
	      else
	        begin
		  nextState = BYTE3;
		end
	    end
	  BYTE4:
	    begin
	      if(serialFlag == 1)
	        begin
		  nextState = HEADER;
		end
	      else
	        begin
		  nextState = BYTE4;
		end
	    end
	endcase
      end
////////////////////////////////////////

////////////////////////////////////////
// GOOD = temp data
// BAD  = something else
////////////////////////////////////////
    always_comb
      begin
        case(wordTypePresentState)
	  INVALIDBYTE:
	    begin
	      if(
	        (headerFound == 1)
		&&
		(nextState == BYTE1)
	        )
	        begin
		  wordTypeNextState = VALIDBYTE;
		end
	      else
	        begin
		  wordTypeNextState = INVALIDBYTE;
		end
	    end

	  VALIDBYTE:
	    begin
	      if(nextState == HEADER)
	        begin
		  wordTypeNextState = INVALIDBYTE;
		end
	      else
	        begin
		  wordTypeNextState = VALIDBYTE;
		end
	    end

	endcase
      end
////////////////////////////////////////

////////////////////////////////////////
    always_comb
      begin
        case (writeToFifoPresentState)
	  DONTWRITE:
	    begin
	      if(
	         (serialFlag)
		 &&
		 (presentState != HEADER)
		 &&
		 (wordTypePresentState == VALIDBYTE)
	        )
	        begin
		  writeToFifoNextState = WRITE;
		end
	      else
	        begin
		  writeToFifoNextState = DONTWRITE;
		end
	    end

	  WRITE:
    	    begin
	      writeToFifoNextState = DONTWRITE;
	    end

	endcase
      end
////////////////////////////////////////

////////////////////////////////////////
// output logic
////////////////////////////////////////
    always_comb
      begin
        if(writeToFifoPresentState == WRITE)
	  begin
	    wr = 1;
	  end
	else
	  begin
	    wr = 0;
	  end
      end



endmodule
