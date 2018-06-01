module ctrl_50(

	input	clk_50,
	input	reset_n,
	input	data_ena,
	input	headerFound,
	output	reg wr
);

////////////////////////////////////////
// BYTE1 out of four state machine ///////
// BYTE2 modes only								 ///////
// WAITING and WORKING          ///////
// serial byte									 ///////
  enum reg [0:0]{
	WTF_1 = 'x,
	WAITING = 1'b0,
	WORKING  = 1'b1

  } serialPresentState, serialNextState;

  reg serial_byte_flag;

  always_ff @(posedge clk_50, negedge reset_n)
    begin
      if(!reset_n)
        begin
	  serialPresentState <= WAITING;
	end
      else if (data_ena)
        begin
	  serialPresentState <= WORKING;
	end
      else
        begin
	  serialPresentState <= WAITING;
	end
    end

////////////////////////////////////////
// BYTE2 out of four state machine  //////
// BYTE1 header											//////
// four bytes											//////
// the_byte												//////
  enum reg [2:0]{
  	HEADER	= 3'b000,
  	BYTE1	= 3'b001,
	BYTE2	= 3'b010,
	BYTE3	= 3'b011,
  	BYTE4	= 3'b100,
	WTF_2	= 'x
  } bytePresentState, byteNextState;

  always_ff @(posedge clk_50, negedge reset_n)
    begin
      if(!reset_n)
        begin
	  bytePresentState <= HEADER;
	end
      else
        begin
	  bytePresentState <= byteNextState;
	end
    end

////////////////////////////////////////
//  three out of four state machine ////
// GOOD = temp data                 ////
// BAD  = something else   					////
// data_type												////
  enum reg [0:0]{
	INVALIDTYPE	= 1'b0,
	VALIDTYPE	= 1'b1,
	WTF_3		= 'x
  }validTypePresentState, validTypeNextState;

  always_ff @(posedge clk_50, negedge reset_n)
    begin
      if(!reset_n)
        begin
	  validTypePresentState	<= INVALIDTYPE;
	end
      else
        begin
	  validTypePresentState	<= validTypeNextState;
	end
    end

////////////////////////////////////////
// four out of four state machine  /////
// BYTE2 modes only									 /////
// YES_WR and NO_WR								 /////
// wr_fifo											 /////
  enum reg [0:0]{
  	NO_WR	= 1'b0,
	YES_WR	= 1'b1,
	WTF_4	= 'x
  }wr_fifo_ps,wr_fifo_ns;

  always_ff @(posedge clk_50, negedge reset_n)
    begin
      if(!reset_n)
        begin
	  wr_fifo_ps	<= NO_WR;
	end
      else
        begin
	  wr_fifo_ps	<= wr_fifo_ns;
	end
    end


////////////////////////////////////////
// keep tracking the data flow
// serial_byte_flag == 1
// when
// data_ena == 0
// bytePresentState == WORKING
////////////////////////////////////////
   always_comb
      begin
        serial_byte_flag = (!data_ena && serialPresentState);
      end
////////////////////////////////////////

////////////////////////////////////////
// loop through all of the bytes
// clockwiselly, and go back to
// header
////////////////////////////////////////

   always_comb
      begin
        case(bytePresentState)
	  HEADER:
	    begin
	      if(serial_byte_flag == 1)
	        begin
		  byteNextState = BYTE1;
		end
	      else
	        begin
		  byteNextState = HEADER;
		end
	    end
	  BYTE1:
	    begin
	      if(serial_byte_flag == 1)
	        begin
		  byteNextState = BYTE2;
		end
	      else
	        begin
		  byteNextState = BYTE1;
		end
	    end
	  BYTE2:
	    begin
	      if(serial_byte_flag == 1)
	        begin
		  byteNextState = BYTE3;
		end
	      else
	        begin
		  byteNextState = BYTE2;
		end
	    end
	  BYTE3:
	    begin
	      if(serial_byte_flag == 1)
	        begin
		  byteNextState = BYTE4;
		end
	      else
	        begin
		  byteNextState = BYTE3;
		end
	    end
	  BYTE4:
	    begin
	      if(serial_byte_flag == 1)
	        begin
		  byteNextState = HEADER;
		end
	      else
	        begin
		  byteNextState = BYTE4;
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
        case(validTypePresentState)
	  INVALIDTYPE:
	    begin
	      if(
	        (headerFound == 1)
		&&
		(byteNextState == BYTE1)
	        )
	        begin
		  validTypeNextState = VALIDTYPE;
		end
	      else
	        begin
		  validTypeNextState = INVALIDTYPE;
		end
	    end

	  VALIDTYPE:
	    begin
	      if(byteNextState == HEADER)
	        begin
		  validTypeNextState = INVALIDTYPE;
		end
	      else
	        begin
		  validTypeNextState = VALIDTYPE;
		end
	    end

	endcase
      end
////////////////////////////////////////

////////////////////////////////////////
    always_comb
      begin
        case (wr_fifo_ps)
	  NO_WR:
	    begin
	      if(
	         (serial_byte_flag)
		 &&
		 (bytePresentState != HEADER)
		 &&
		 (validTypePresentState == VALIDTYPE)
	        )
	        begin
		  wr_fifo_ns = YES_WR;
		end
	      else
	        begin
		  wr_fifo_ns = NO_WR;
		end
	    end

	  YES_WR:
    	    begin
	      wr_fifo_ns = NO_WR;
	    end

	endcase
      end
////////////////////////////////////////

////////////////////////////////////////
// output logic
////////////////////////////////////////
    always_comb
      begin
        if(wr_fifo_ps == YES_WR)
	  begin
	    wr = 1;
	  end
	else
	  begin
	    wr = 0;
	  end
      end



endmodule
