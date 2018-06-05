// *********************************************************
// Program: header.sv
// Description: identifies when the header has been received
// Author: Jeffrey Noe
// Due: 6/01/2018
// *********************************************************

module header(
      input                   clk_50,                            //50 MHz input clock
      input                   reset_n,                           //reset async active low
      input                   serial_data,                       //serial input data
      input                   data_ena,                          //serial data enable
      output logic            headerFound                        //write strobe to ram
      );


      //msb to lsb
      reg [7:0] singlePacket;
      reg beginRead = 1'b0;
      reg [2:0] serialCount = 3'b0;
      enum logic [1:0] {      //moves through states in the case statement inside always_comb
            IDLE = 2'b00,
            READ = 2'b01,
            TESTBYTE = 2'b10,
            TEMPSTATE = 2'b11,
      } presentState, nextState;

      //Handles reset and move to next state
      always_ff @(posedge clk_50, negedge reset_n) begin
            if (!reset_n)
                  presentState = IDLE;
            else
                  presentState <= nextState;
      end

      always_comb begin
            unique case (presentState)
                  IDLE: begin
                        if (data_ena | beginRead) begin
                              beginRead = 1'b1;
                              singlePacket[serialCount] <= serial_data;
                              serialCount <= serialCount + 1;
                              nextState <= READ;
                        end
                        else
                              nextState <= IDLE;
                  end
                  READ: begin
                        if(serialCount == 3'b111)
                              nextState <= TESTBYTE;
                        else//No need to "nextState <= READ" because it already has that value
                              singlePacket[serialCount] <= serial_data;
                  end
                  TESTBYTE: begin
                        if(singlePacket == 8'hA5 || singlePacket == 8'hC3) begin
                              headerFound <= 1'b1;
                        end
                        else begin
                              headerFound <= 1'b0;
                        end
                        serialCount <= 8'b0;
                        beginRead = 1'b0;
                        nextState = IDLE;
                  end
            endcase
      end
endmodule
