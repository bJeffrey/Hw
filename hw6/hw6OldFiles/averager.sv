// *********************************************************
// Program: averager.sv
// Description: averages 4 temperature readings
// Author: Jeffrey Noe
// Due: 6/01/2018
// *********************************************************

module averager(
            input             wr_clk,     //write clock
            input             rd_clk,     //read clock
            input             reset_n,    //rest async active low
            input             wr,         //write enable
            input             rd,         //read enable
            input       [7:0] data_in,    //data in
            output reg  [7:0] data_out,   //data output
            output logic      empty,      //empty flag
            output logic      full,        //full flag..
            output logic [7:0]      averagedTempReading,    //1 averaged temperature reading
            output logic [10:0]     ramAddress              //Address to store the temperature reading.  Starts with 0x07FF.  Ends with 0x0000
            );

            //declare registers
            reg [10:0] ramAddressCount = 12'h07FF;
            reg shiftToggle = 0;
            reg [7:0] word [0:3];         //7:0 memory width per word, 0:3 memory depth (total words)
            reg wrToggle = 1'b0;          //binary toggle to differentiate between full and empty memory
            reg rdToggle = 1'b0;          //binary toggle to differentiate between full and empty memory
            reg [2:0] rdPtr = 2'b00;      //points to the current location in memory to be read
            reg [2:0] wrPtr = 2'b00;      //points to the current location in memory to be written
            reg syncEmpty;                //binary value to synchronize the empty output
            reg syncFull;                 //binary value to synchronize the full output

            //assign the empty and full asynchronous signals
            assign asyncEmpty = (rdToggle == wrToggle)&&(rdPtr == wrPtr);    //Indicate the memory is empty
            assign asyncFull = (rdToggle != wrToggle)&&(rdPtr == wrPtr);     //Indicate the memory is full

            //assign empty and full outputs to high when either async or sync empty/full is high
            assign empty = asyncEmpty | syncEmpty;
            assign full = asyncFull | syncFull;

            //ensure the syncrhonous empty is updated at the beginning of the read clock
            always_ff @(posedge rd_clk) begin
                  syncEmpty <= asyncEmpty;
            end

            //ensure the asynchronous full is updeated at the beginning of the write clock
            always_ff@(posedge wr_clk) begin
                  syncFull <= asyncFull;
            end

            //output the memory location pointed to by rdPtr
            always_ff @(posedge rd_clk, negedge reset_n) begin
                  if(!reset_n) begin //Handle the reset by resetting the pointers and toggles.
                                     //Memory does not need to be set to zero
                        rdPtr <= 2'b00;
                        wrPtr <= 2'b00;
                        rdToggle <= 1'b0;
                        wrToggle <= 1'b0;
                  end
                  else if (rd) begin
                        unique case (rdPtr)//use unique case to prevent a latch as all cases of rdPtr are accounted for.
                              0:    begin
                                    data_out <= word[0];
                                    rdPtr <= rdPtr + 2'b01;
                              end
                              1:    begin
                                    data_out <= word[1];
                                    rdPtr <= rdPtr + 2'b01;
                              end
                              2:    begin
                                    data_out <= word[2];
                                    rdPtr <= rdPtr + 2'b01;
                              end
                              3:    begin
                                    data_out <= word[3];
                                    rdPtr <= 2'b00;
                                    rdToggle = ~rdToggle;//change toggle value to indicate empty/full
                              end
                        endcase
                  end
                  else begin
                        //Do nothing
                  end
            end

            //Write to the memory location pointed to by wrPtr
            always_ff @(posedge wr_clk) begin//reset operator is taken care of in the rd_clock flip-flop
                  if(ramAddressCount == 0)
                        ramAddressCount <= 12'h07FF;
                  else if ((wr == 1) && (shiftToggle == 0)) begin
                        unique case (wrPtr)//use unique case to prevent a latch as all cases of wrPtr are accounted for.
                              0:    begin
                                    word[0] <= data_in;
                                    wrPtr <= wrPtr + 2'b01;
                              end
                              1:    begin
                                    word[1] <= data_in;
                                    wrPtr <= wrPtr + 2'b01;
                              end
                              2:    begin
                                    word[2] <= data_in;
                                    wrPtr <= wrPtr + 2'b01;

                              end
                              3:    begin
                                    ramAddress <= ramAddressCount;
                                    shiftToggle <= 1;
                                    //word[3] <= data_in;
                                     averagedTempReading <= word[0] >> 2 + word[1] >> 2 + word[2] >> 2 + data_in >> 2;
                                    wrPtr <= 2'b00;
                                    wrToggle = ~wrToggle;//change toggle value to indicate empty/full
                              end
                        endcase
                  end
                  else if (shiftToggle == 1)begin
                        shiftToggle <= 0;
                        ramAddressCount = ramAddressCount - 1'b1;
                  end
                  else begin
                        //do nothing
                  end
            end
endmodule
