module tas (
       input  clk_50,               // 50Mhz input clock
       input  clk_2,                // 2Mhz input clock
       input  reset_n,              // reset async active low
       input  serial_data,          // serial input data
       input  data_ena,             // serial data enable
       output ram_wr_n,             // write strobe to ram
       output [7:0] ram_data,       // ram data
       output [10:0] ram_addr       // ram address
       );

       wire headerFound;                  //header detected from the input
       wire wr;                           //write to the fifo
       wire rd;                           //read from the fifo
       wire empty;                        //fifo is empty
       wire full;                         //fifo is full
       wire done;                         //4 bytes have been read from the fifo.  Signal done
       wire clear;                        //4 bytes have been read from the fifo.  Clear the averager accumulator
       logic [7:0] word;                  //Single word read from serial_data
       logic [7:0] fifoToAverager;        //8-bit wire between fifo and averager

       getWord getWord0(
            .clk_50                 (clk_50),
            .reset_n                (reset_n),
            .serial_data            (serial_data),
            .data_ena               (data_ena),
            .word                   (word),
            .headerFound            (headerFound)
       );

       control50MHz control50MHz0(
           .clk_50                 (clk_50),
           .reset_n                (reset_n),
           .data_ena               (data_ena),
           .headerFound            (headerFound),
           .wr                     (wr)
       );

       control2MHz control2MHz0(
            .clk_2                  (clk_2),
            .reset_n                (reset_n),
            .empty                  (empty),
            .rd                     (rd),
            .done                   (done),
            .clear                  (clear)
       );

       fifo fifo0(
            .wr_clk                 (clk_50),
            .rd_clk                 (clk_2),
            .reset_n                (reset_n),
            .wr                     (wr),
            .rd                     (rd),
            .data_in                (word),
            .data_out               (fifoToAverager),
            .asyncEmpty             (empty),
            .asyncFull              (full)
       );

       averager averager0(
            .clk_2                  (clk_2),
            .reset_n                (reset_n),
            .rd                     (rd),
            .data_in                (fifoToAverager),
            .clear                  (clear),
            .averagedTempReading    (ram_data)
       );

       ramCounter ramCounter0(
            .clk_2                  (clk_2),
            .reset_n                (reset_n),
            .done                   (done),
            .ramAddress             (ram_addr)
       );

endmodule
