// *********************************************************
// Program: fifo.sv
// Description: Module of a first-in-first-out memory queue
// Author: Jeffrey Noe
// Due: 5/11/2018
// *********************************************************

module fifo(
      input             wr_clk,     //write clock
      input             rd_clk,     //read clock
      input             reset_n,    //rest async active low
      input             wr,         //write enable
      input             rd,         //read enable
      input       [7:0] data_in,    //data in
      output reg  [7:0] data_out,   //data output
      output            empty,      //empty flag
      output            full        //full flag..
      );

      //declare registers
      reg [7:0] word [0:7];         //7:0 memory width per word, 0:7 memory depth (total words)
      reg wrToggle = 1'b0;          //binary toggle to differentiate between full and empty memory
      reg rdToggle = 1'b0;          //binary toggle to differentiate between full and empty memory
      reg [2:0] rdPtr = 4'b0000;    //points to the current location in memory to be read
      reg [2:0] wrPtr = 4'b0000;    //points to the current location in memory to be written

      //assign the empty and full outputs
      assign empty = (rdToggle == wrToggle)&&(rdPtr == wrPtr);    //Indicate the memory is empty
      assign full = (rdToggle != wrToggle)&&(rdPtr == wrPtr);     //Indicate the memory is full

      // http://www.verilogpro.com/systemverilog-always_comb-always_ff/
      // always_comb automatically executes once at time zero,
      // always_comb is sensitive to changes within the contents of a function
      // Variables on the left-hand side of assignments within an always_comb procedure,
            // including variables from the contents of a called function, cannot be written to by any other processes
      // Statements in an always_comb cannot include those that block,
            // have blocking timing or event controls, or fork-join statements.

      //output the memory location pointed to by rdPtr
      always_ff @(posedge rd_clk, negedge reset_n) begin
            if(!reset_n) begin
                  //data_out = word[0];
                  rdPtr <= 3'b000;
                  wrPtr <= 3'b000;
                  rdToggle <= 1'b0;
                  wrToggle <= 1'b0;
            end
            else if (rd) begin
                  unique case (rdPtr)//All cases of rdPtr are accounted for
                        0:    begin
                              data_out <= word[0];
                              rdPtr <= rdPtr + 3'b001;
                        end
                        1:    begin
                              data_out <= word[1];
                              rdPtr <= rdPtr + 3'b001;
                        end
                        2:    begin
                              data_out <= word[2];
                              rdPtr <= rdPtr + 3'b001;
                        end
                        3:    begin
                              data_out <= word[3];
                              rdPtr <= rdPtr + 3'b001;
                        end
                        4:    begin
                              data_out <= word[4];
                              rdPtr <= rdPtr + 3'b001;
                        end
                        5:    begin
                              data_out <= word[5];
                              rdPtr <= rdPtr + 3'b001;
                        end
                        6:    begin
                              data_out <= word[6];
                              rdPtr <= rdPtr + 3'b001;
                        end
                        7:    begin
                              data_out <= word[7];
                              rdPtr <= 3'b000;
                              rdToggle = ~rdToggle;
                        end
                  endcase
            end
            else begin
                  //Do nothing
            end
      end

      //Write to the memory location pointed to by wrPtr
      always_ff @(posedge wr_clk) begin//reset operator is taken care of in the rd_clock flip-flop
            if (wr) begin
                  unique case (wrPtr)//All cases of wrPtr are accounted for
                        0:    begin
                              word[0] <= data_in;
                              wrPtr <= wrPtr + 3'b001;
                        end
                        1:    begin
                              word[1] <= data_in;
                              wrPtr <= wrPtr + 3'b001;
                        end
                        2:    begin
                              word[2] <= data_in;
                              wrPtr <= wrPtr + 3'b001;

                        end
                        3:    begin
                              word[3] <= data_in;
                              wrPtr <= wrPtr + 3'b001;
                        end
                        4:    begin
                              word[4] <= data_in;
                              wrPtr <= wrPtr + 3'b001;
                        end
                        5:    begin
                              word[5] <= data_in;
                              wrPtr <= wrPtr + 3'b001;
                        end
                        6:    begin
                              word[6] <= data_in;
                              wrPtr <= wrPtr + 3'b001;
                        end
                        7:    begin
                              word[7] <= data_in;
                              wrPtr <= 3'b000;
                              wrToggle = ~wrToggle;
                        end
                  endcase
            end
            else begin
                  //Do nothing
            end
      end




































endmodule
