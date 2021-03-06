// *********************************************************
// Program: clock.sv
// Description: top module for 8 segment display clock
// Author: Jeffrey Noe
// Due: 6/8/2018
// *********************************************************
module clock (
       input  reset_n,                          // reset pin
       input                  clk_1sec,         //1 sec clock
       input                  clk_1ms,          //1 mili sec clock
       input                  mil_time,         //mil time pin
       output logic [7:0]       segment_data,     //output 7 segment data
       output logic [2:0]       digit_select      //digit select
       );

       wire changeSec;              //connects clkSync and seconds modules
       wire changeMin;              //connects seconds and minutes modules
       wire changeHour;             //connects minutes and hours modules
       wire amPm;                   //connects the hours and displayDigits modules

       logic [2:0] minMSB;          //connects the minutes and displayDigits modules MSB
       logic [3:0] minLSB;          //connects the minutes and displayDigits modules LSB
       logic [1:0] hourMSB;         //connects the hours and displayDigits modules MSB
       logic [3:0] hourLSB;         //connects the hours and displayDigits modules LSB

       clkSync clkSync0(
            .clkSec          (clk_1sec),
            .clkMSec           (clk_1ms),
            .resetN          (reset_n),
            .changeSec        (changeSec)
       );

       seconds seconds0(
            .clkMSec         (clk_1ms),
            .resetN          (reset_n),
            .changeSec        (changeSec),
            .changeMin        (changeMin)
       );

       minutes minutes0(
            .clkMSec          (clk_1ms),
            .resetN           (reset_n),
            .changeMin        (changeMin),
            .changeHour       (changeHour),
            .minMSB           (minMSB),
            .minLSB           (minLSB)
       );

       hours hours0(
            .clkMSec          (clk_1ms),
            .resetN           (reset_n),
            .milTime          (mil_time),
            .changeHour       (changeHour),
            .amPm             (amPm),
            .hourMSB          (hourMSB),
            .hourLSB          (hourLSB)
       );

       displayDigits displayDigits0(
            .clkMSec          (clk_1ms),
            .resetN           (reset_n),
            .amPm             (amPm),
            .minMSB           (minMSB),
            .minLSB           (minLSB),
            .hourMSB          (hourMSB),
            .hourLSB          (hourLSB),
            .segmentData      (segment_data),
            .digitSelect      (digit_select)
       );

endmodule
