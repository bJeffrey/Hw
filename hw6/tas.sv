// *********************************************************
// Program: tas.sv
// Description: Top Module that sends the average temperatures to RAM
// Author: Jeffrey Noe
// Due: 6/01/2018
// *********************************************************

module tas(
      input             clk_50,           //50 MHz input clock
      input             clk_2,            //2 MHz input clock
      input             reset_n,          //reset async active low
      input             serial_data,      //serial input data
      input             data_ena          //serial data enable
      output            ram_wr_n,         //write strobe to ram
      output [7:0]      ram_data,         //ram data
      output [10:0]     ram_addr          //ram address
      );
      //inside the smaller inner module (from this top module)
      fifo fifo_0(
            clk_2             (wr_clk),
            clk_50            (rd_clk),
            .reset_n          (reset_n),
            ram_wr_n          (wr),
            1'b0              (rd),
            something         (data_in),
            something         (data_out),
            something         (empty),
            something         (full)
      );


endmodule
