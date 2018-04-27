/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : L-2016.03-SP2
// Date      : Thu Apr 26 21:25:12 2018
/////////////////////////////////////////////////////////////


module mult_DW01_add_0 ( A, B, CI, SUM, CO );
  input [31:0] A;
  input [31:0] B;
  output [31:0] SUM;
  input CI;
  output CO;
  wire   n1;
  wire   [31:1] carry;

  FADDX1 U1_30 ( .A(A[30]), .B(B[30]), .CI(carry[30]), .CO(carry[31]), .S(
        SUM[30]) );
  FADDX1 U1_29 ( .A(A[29]), .B(B[29]), .CI(carry[29]), .CO(carry[30]), .S(
        SUM[29]) );
  FADDX1 U1_28 ( .A(A[28]), .B(B[28]), .CI(carry[28]), .CO(carry[29]), .S(
        SUM[28]) );
  FADDX1 U1_27 ( .A(A[27]), .B(B[27]), .CI(carry[27]), .CO(carry[28]), .S(
        SUM[27]) );
  FADDX1 U1_26 ( .A(A[26]), .B(B[26]), .CI(carry[26]), .CO(carry[27]), .S(
        SUM[26]) );
  FADDX1 U1_25 ( .A(A[25]), .B(B[25]), .CI(carry[25]), .CO(carry[26]), .S(
        SUM[25]) );
  FADDX1 U1_24 ( .A(A[24]), .B(B[24]), .CI(carry[24]), .CO(carry[25]), .S(
        SUM[24]) );
  FADDX1 U1_23 ( .A(A[23]), .B(B[23]), .CI(carry[23]), .CO(carry[24]), .S(
        SUM[23]) );
  FADDX1 U1_22 ( .A(A[22]), .B(B[22]), .CI(carry[22]), .CO(carry[23]), .S(
        SUM[22]) );
  FADDX1 U1_21 ( .A(A[21]), .B(B[21]), .CI(carry[21]), .CO(carry[22]), .S(
        SUM[21]) );
  FADDX1 U1_20 ( .A(A[20]), .B(B[20]), .CI(carry[20]), .CO(carry[21]), .S(
        SUM[20]) );
  FADDX1 U1_19 ( .A(A[19]), .B(B[19]), .CI(carry[19]), .CO(carry[20]), .S(
        SUM[19]) );
  FADDX1 U1_18 ( .A(A[18]), .B(B[18]), .CI(carry[18]), .CO(carry[19]), .S(
        SUM[18]) );
  FADDX1 U1_17 ( .A(A[17]), .B(B[17]), .CI(carry[17]), .CO(carry[18]), .S(
        SUM[17]) );
  FADDX1 U1_16 ( .A(A[16]), .B(B[16]), .CI(carry[16]), .CO(carry[17]), .S(
        SUM[16]) );
  FADDX1 U1_15 ( .A(A[15]), .B(B[15]), .CI(carry[15]), .CO(carry[16]), .S(
        SUM[15]) );
  FADDX1 U1_14 ( .A(A[14]), .B(B[14]), .CI(carry[14]), .CO(carry[15]), .S(
        SUM[14]) );
  FADDX1 U1_13 ( .A(A[13]), .B(B[13]), .CI(carry[13]), .CO(carry[14]), .S(
        SUM[13]) );
  FADDX1 U1_12 ( .A(A[12]), .B(B[12]), .CI(carry[12]), .CO(carry[13]), .S(
        SUM[12]) );
  FADDX1 U1_11 ( .A(A[11]), .B(B[11]), .CI(carry[11]), .CO(carry[12]), .S(
        SUM[11]) );
  FADDX1 U1_10 ( .A(A[10]), .B(B[10]), .CI(carry[10]), .CO(carry[11]), .S(
        SUM[10]) );
  FADDX1 U1_9 ( .A(A[9]), .B(B[9]), .CI(carry[9]), .CO(carry[10]), .S(SUM[9])
         );
  FADDX1 U1_8 ( .A(A[8]), .B(B[8]), .CI(carry[8]), .CO(carry[9]), .S(SUM[8])
         );
  FADDX1 U1_7 ( .A(A[7]), .B(B[7]), .CI(carry[7]), .CO(carry[8]), .S(SUM[7])
         );
  FADDX1 U1_6 ( .A(A[6]), .B(B[6]), .CI(carry[6]), .CO(carry[7]), .S(SUM[6])
         );
  FADDX1 U1_5 ( .A(A[5]), .B(B[5]), .CI(carry[5]), .CO(carry[6]), .S(SUM[5])
         );
  FADDX1 U1_4 ( .A(A[4]), .B(B[4]), .CI(carry[4]), .CO(carry[5]), .S(SUM[4])
         );
  FADDX1 U1_3 ( .A(A[3]), .B(B[3]), .CI(carry[3]), .CO(carry[4]), .S(SUM[3])
         );
  FADDX1 U1_2 ( .A(A[2]), .B(B[2]), .CI(carry[2]), .CO(carry[3]), .S(SUM[2])
         );
  XOR3X1 U1_31 ( .IN1(A[31]), .IN2(B[31]), .IN3(carry[31]), .Q(SUM[31]) );
  FADDX1 U1_1 ( .A(A[1]), .B(B[1]), .CI(n1), .CO(carry[2]), .S(SUM[1]) );
  XOR2X1 U1 ( .IN1(B[0]), .IN2(A[0]), .Q(SUM[0]) );
  AND2X1 U2 ( .IN1(B[0]), .IN2(A[0]), .Q(n1) );
endmodule


module mult_DW01_inc_0 ( A, SUM );
  input [7:0] A;
  output [7:0] SUM;

  wire   [7:2] carry;

  HADDX1 U1_1_1 ( .A0(A[1]), .B0(A[0]), .C1(carry[2]), .SO(SUM[1]) );
  HADDX1 U1_1_6 ( .A0(A[6]), .B0(carry[6]), .C1(carry[7]), .SO(SUM[6]) );
  HADDX1 U1_1_2 ( .A0(A[2]), .B0(carry[2]), .C1(carry[3]), .SO(SUM[2]) );
  HADDX1 U1_1_5 ( .A0(A[5]), .B0(carry[5]), .C1(carry[6]), .SO(SUM[5]) );
  HADDX1 U1_1_4 ( .A0(A[4]), .B0(carry[4]), .C1(carry[5]), .SO(SUM[4]) );
  HADDX1 U1_1_3 ( .A0(A[3]), .B0(carry[3]), .C1(carry[4]), .SO(SUM[3]) );
  INVX0 U1 ( .IN(A[0]), .QN(SUM[0]) );
  XOR2X1 U2 ( .IN1(carry[7]), .IN2(A[7]), .Q(SUM[7]) );
endmodule


module mult ( reset, clk, a_in, b_in, start, product, done );
  input [31:0] a_in;
  input [31:0] b_in;
  output [63:0] product;
  input reset, clk, start;
  output done;
  wire   N23, N24, N25, N26, N27, N28, N29, N30, N31, N32, N33, N34, N35, N36,
         N37, N38, N39, N40, N41, N42, N43, N44, N45, N46, N47, N48, N49, N50,
         N51, N52, N53, N54, N163, N164, N165, N166, N167, N168, N169, N170,
         n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41,
         n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55,
         n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69,
         n70, n71, n72, n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83,
         n84, n85, n86, n87, n88, n89, n90, n91, n92, n93, n94, n95, n96, n97,
         n98, n99, n100, n101, n102, n103, n104, n105, n106, n107, n108, n109,
         n110, n111, n112, n113, n114, n115, n116, n117, n118, n119, n120,
         n121, n122, n123, n124, n125;
  wire   [7:0] count;

  mult_DW01_add_0 add_53 ( .A(product[63:32]), .B(a_in), .CI(1'b0), .SUM({N54, 
        N53, N52, N51, N50, N49, N48, N47, N46, N45, N44, N43, N42, N41, N40, 
        N39, N38, N37, N36, N35, N34, N33, N32, N31, N30, N29, N28, N27, N26, 
        N25, N24, N23}) );
  mult_DW01_inc_0 r74 ( .A(count), .SUM({N170, N169, N168, N167, N166, N165, 
        N164, N163}) );
  DFFASX1 cycleAlternator_reg ( .D(n93), .CLK(clk), .SETB(n125), .QN(n124) );
  DFFARX1 \count_reg[1]  ( .D(n99), .CLK(clk), .RSTB(n125), .Q(count[1]), .QN(
        n121) );
  DFFARX1 \count_reg[2]  ( .D(n98), .CLK(clk), .RSTB(n125), .Q(count[2]), .QN(
        n122) );
  DFFARX1 \count_reg[3]  ( .D(n97), .CLK(clk), .RSTB(n125), .Q(count[3]), .QN(
        n123) );
  DFFARX1 \count_reg[6]  ( .D(n94), .CLK(clk), .RSTB(n125), .Q(count[6]), .QN(
        n119) );
  DFFARX1 done_reg ( .D(n28), .CLK(clk), .RSTB(n125), .Q(done) );
  DFFARX1 \count_reg[7]  ( .D(n100), .CLK(clk), .RSTB(n125), .Q(count[7]) );
  DFFARX1 \count_reg[4]  ( .D(n96), .CLK(clk), .RSTB(n125), .Q(count[4]) );
  DFFARX1 \count_reg[5]  ( .D(n95), .CLK(clk), .RSTB(n125), .Q(count[5]) );
  DFFARX1 \product_reg[0]  ( .D(n92), .CLK(clk), .RSTB(n125), .Q(product[0])
         );
  DFFARX1 \product_reg[1]  ( .D(n91), .CLK(clk), .RSTB(n125), .Q(product[1])
         );
  DFFARX1 \product_reg[31]  ( .D(n61), .CLK(clk), .RSTB(n125), .Q(product[31])
         );
  DFFARX1 \product_reg[30]  ( .D(n62), .CLK(clk), .RSTB(n125), .Q(product[30])
         );
  DFFARX1 \product_reg[29]  ( .D(n63), .CLK(clk), .RSTB(n125), .Q(product[29])
         );
  DFFARX1 \product_reg[28]  ( .D(n64), .CLK(clk), .RSTB(n125), .Q(product[28])
         );
  DFFARX1 \product_reg[27]  ( .D(n65), .CLK(clk), .RSTB(n125), .Q(product[27])
         );
  DFFARX1 \product_reg[26]  ( .D(n66), .CLK(clk), .RSTB(n125), .Q(product[26])
         );
  DFFARX1 \product_reg[25]  ( .D(n67), .CLK(clk), .RSTB(n125), .Q(product[25])
         );
  DFFARX1 \product_reg[24]  ( .D(n68), .CLK(clk), .RSTB(n125), .Q(product[24])
         );
  DFFARX1 \product_reg[23]  ( .D(n69), .CLK(clk), .RSTB(n125), .Q(product[23])
         );
  DFFARX1 \product_reg[22]  ( .D(n70), .CLK(clk), .RSTB(n125), .Q(product[22])
         );
  DFFARX1 \product_reg[21]  ( .D(n71), .CLK(clk), .RSTB(n125), .Q(product[21])
         );
  DFFARX1 \product_reg[20]  ( .D(n72), .CLK(clk), .RSTB(n125), .Q(product[20])
         );
  DFFARX1 \product_reg[19]  ( .D(n73), .CLK(clk), .RSTB(n125), .Q(product[19])
         );
  DFFARX1 \product_reg[18]  ( .D(n74), .CLK(clk), .RSTB(n125), .Q(product[18])
         );
  DFFARX1 \product_reg[17]  ( .D(n75), .CLK(clk), .RSTB(n125), .Q(product[17])
         );
  DFFARX1 \product_reg[16]  ( .D(n76), .CLK(clk), .RSTB(n125), .Q(product[16])
         );
  DFFARX1 \product_reg[15]  ( .D(n77), .CLK(clk), .RSTB(n125), .Q(product[15])
         );
  DFFARX1 \product_reg[14]  ( .D(n78), .CLK(clk), .RSTB(n125), .Q(product[14])
         );
  DFFARX1 \product_reg[13]  ( .D(n79), .CLK(clk), .RSTB(n125), .Q(product[13])
         );
  DFFARX1 \product_reg[12]  ( .D(n80), .CLK(clk), .RSTB(n125), .Q(product[12])
         );
  DFFARX1 \product_reg[11]  ( .D(n81), .CLK(clk), .RSTB(n125), .Q(product[11])
         );
  DFFARX1 \product_reg[10]  ( .D(n82), .CLK(clk), .RSTB(n125), .Q(product[10])
         );
  DFFARX1 \product_reg[9]  ( .D(n83), .CLK(clk), .RSTB(n125), .Q(product[9])
         );
  DFFARX1 \product_reg[8]  ( .D(n84), .CLK(clk), .RSTB(n125), .Q(product[8])
         );
  DFFARX1 \product_reg[7]  ( .D(n85), .CLK(clk), .RSTB(n125), .Q(product[7])
         );
  DFFARX1 \product_reg[6]  ( .D(n86), .CLK(clk), .RSTB(n125), .Q(product[6])
         );
  DFFARX1 \product_reg[5]  ( .D(n87), .CLK(clk), .RSTB(n125), .Q(product[5])
         );
  DFFARX1 \product_reg[4]  ( .D(n88), .CLK(clk), .RSTB(n125), .Q(product[4])
         );
  DFFARX1 \product_reg[3]  ( .D(n89), .CLK(clk), .RSTB(n125), .Q(product[3])
         );
  DFFARX1 \product_reg[2]  ( .D(n90), .CLK(clk), .RSTB(n125), .Q(product[2])
         );
  DFFARX1 \product_reg[63]  ( .D(n29), .CLK(clk), .RSTB(n125), .Q(product[63])
         );
  DFFARX1 \product_reg[33]  ( .D(n59), .CLK(clk), .RSTB(n125), .Q(product[33])
         );
  DFFARX1 \product_reg[62]  ( .D(n30), .CLK(clk), .RSTB(n125), .Q(product[62])
         );
  DFFARX1 \product_reg[61]  ( .D(n31), .CLK(clk), .RSTB(n125), .Q(product[61])
         );
  DFFARX1 \product_reg[60]  ( .D(n32), .CLK(clk), .RSTB(n125), .Q(product[60])
         );
  DFFARX1 \product_reg[59]  ( .D(n33), .CLK(clk), .RSTB(n125), .Q(product[59])
         );
  DFFARX1 \product_reg[58]  ( .D(n34), .CLK(clk), .RSTB(n125), .Q(product[58])
         );
  DFFARX1 \product_reg[57]  ( .D(n35), .CLK(clk), .RSTB(n125), .Q(product[57])
         );
  DFFARX1 \product_reg[56]  ( .D(n36), .CLK(clk), .RSTB(n125), .Q(product[56])
         );
  DFFARX1 \product_reg[55]  ( .D(n37), .CLK(clk), .RSTB(n125), .Q(product[55])
         );
  DFFARX1 \product_reg[54]  ( .D(n38), .CLK(clk), .RSTB(n125), .Q(product[54])
         );
  DFFARX1 \product_reg[53]  ( .D(n39), .CLK(clk), .RSTB(n125), .Q(product[53])
         );
  DFFARX1 \product_reg[52]  ( .D(n40), .CLK(clk), .RSTB(n125), .Q(product[52])
         );
  DFFARX1 \product_reg[51]  ( .D(n41), .CLK(clk), .RSTB(n125), .Q(product[51])
         );
  DFFARX1 \product_reg[50]  ( .D(n42), .CLK(clk), .RSTB(n125), .Q(product[50])
         );
  DFFARX1 \product_reg[49]  ( .D(n43), .CLK(clk), .RSTB(n125), .Q(product[49])
         );
  DFFARX1 \product_reg[48]  ( .D(n44), .CLK(clk), .RSTB(n125), .Q(product[48])
         );
  DFFARX1 \product_reg[47]  ( .D(n45), .CLK(clk), .RSTB(n125), .Q(product[47])
         );
  DFFARX1 \product_reg[46]  ( .D(n46), .CLK(clk), .RSTB(n125), .Q(product[46])
         );
  DFFARX1 \product_reg[45]  ( .D(n47), .CLK(clk), .RSTB(n125), .Q(product[45])
         );
  DFFARX1 \product_reg[44]  ( .D(n48), .CLK(clk), .RSTB(n125), .Q(product[44])
         );
  DFFARX1 \product_reg[43]  ( .D(n49), .CLK(clk), .RSTB(n125), .Q(product[43])
         );
  DFFARX1 \product_reg[42]  ( .D(n50), .CLK(clk), .RSTB(n125), .Q(product[42])
         );
  DFFARX1 \product_reg[41]  ( .D(n51), .CLK(clk), .RSTB(n125), .Q(product[41])
         );
  DFFARX1 \product_reg[40]  ( .D(n52), .CLK(clk), .RSTB(n125), .Q(product[40])
         );
  DFFARX1 \product_reg[39]  ( .D(n53), .CLK(clk), .RSTB(n125), .Q(product[39])
         );
  DFFARX1 \product_reg[38]  ( .D(n54), .CLK(clk), .RSTB(n125), .Q(product[38])
         );
  DFFARX1 \product_reg[37]  ( .D(n55), .CLK(clk), .RSTB(n125), .Q(product[37])
         );
  DFFARX1 \product_reg[36]  ( .D(n56), .CLK(clk), .RSTB(n125), .Q(product[36])
         );
  DFFARX1 \product_reg[35]  ( .D(n57), .CLK(clk), .RSTB(n125), .Q(product[35])
         );
  DFFARX1 \product_reg[34]  ( .D(n58), .CLK(clk), .RSTB(n125), .Q(product[34])
         );
  DFFARX1 \product_reg[32]  ( .D(n60), .CLK(clk), .RSTB(n125), .Q(product[32])
         );
  DFFARX1 \count_reg[0]  ( .D(n101), .CLK(clk), .RSTB(n125), .Q(count[0]), 
        .QN(n120) );
  INVX0 U103 ( .IN(reset), .QN(n125) );
  AND2X1 U104 ( .IN1(N164), .IN2(n102), .Q(n99) );
  AND2X1 U105 ( .IN1(N165), .IN2(n102), .Q(n98) );
  AND2X1 U106 ( .IN1(N166), .IN2(n102), .Q(n97) );
  AND2X1 U107 ( .IN1(N167), .IN2(n102), .Q(n96) );
  AND2X1 U108 ( .IN1(N168), .IN2(n102), .Q(n95) );
  OR2X1 U109 ( .IN1(n103), .IN2(N169), .Q(n94) );
  OAI21X1 U110 ( .IN1(n104), .IN2(n124), .IN3(n105), .QN(n93) );
  AO222X1 U111 ( .IN1(b_in[0]), .IN2(n106), .IN3(product[1]), .IN4(n107), 
        .IN5(product[0]), .IN6(n108), .Q(n92) );
  AO222X1 U112 ( .IN1(b_in[1]), .IN2(n106), .IN3(product[2]), .IN4(n107), 
        .IN5(n108), .IN6(product[1]), .Q(n91) );
  AO222X1 U113 ( .IN1(b_in[2]), .IN2(n106), .IN3(product[3]), .IN4(n107), 
        .IN5(product[2]), .IN6(n108), .Q(n90) );
  AO222X1 U114 ( .IN1(b_in[3]), .IN2(n106), .IN3(product[4]), .IN4(n107), 
        .IN5(product[3]), .IN6(n108), .Q(n89) );
  AO222X1 U115 ( .IN1(b_in[4]), .IN2(n106), .IN3(product[5]), .IN4(n107), 
        .IN5(product[4]), .IN6(n108), .Q(n88) );
  AO222X1 U116 ( .IN1(b_in[5]), .IN2(n106), .IN3(product[6]), .IN4(n107), 
        .IN5(product[5]), .IN6(n108), .Q(n87) );
  AO222X1 U117 ( .IN1(b_in[6]), .IN2(n106), .IN3(product[7]), .IN4(n107), 
        .IN5(product[6]), .IN6(n108), .Q(n86) );
  AO222X1 U118 ( .IN1(b_in[7]), .IN2(n106), .IN3(product[8]), .IN4(n107), 
        .IN5(product[7]), .IN6(n108), .Q(n85) );
  AO222X1 U119 ( .IN1(b_in[8]), .IN2(n106), .IN3(product[9]), .IN4(n107), 
        .IN5(product[8]), .IN6(n108), .Q(n84) );
  AO222X1 U120 ( .IN1(b_in[9]), .IN2(n106), .IN3(product[10]), .IN4(n107), 
        .IN5(product[9]), .IN6(n108), .Q(n83) );
  AO222X1 U121 ( .IN1(b_in[10]), .IN2(n106), .IN3(product[11]), .IN4(n107), 
        .IN5(product[10]), .IN6(n108), .Q(n82) );
  AO222X1 U122 ( .IN1(b_in[11]), .IN2(n106), .IN3(product[12]), .IN4(n107), 
        .IN5(product[11]), .IN6(n108), .Q(n81) );
  AO222X1 U123 ( .IN1(b_in[12]), .IN2(n106), .IN3(product[13]), .IN4(n107), 
        .IN5(product[12]), .IN6(n108), .Q(n80) );
  AO222X1 U124 ( .IN1(b_in[13]), .IN2(n106), .IN3(product[14]), .IN4(n107), 
        .IN5(product[13]), .IN6(n108), .Q(n79) );
  AO222X1 U125 ( .IN1(b_in[14]), .IN2(n106), .IN3(product[15]), .IN4(n107), 
        .IN5(product[14]), .IN6(n108), .Q(n78) );
  AO222X1 U126 ( .IN1(b_in[15]), .IN2(n106), .IN3(product[16]), .IN4(n107), 
        .IN5(product[15]), .IN6(n108), .Q(n77) );
  AO222X1 U127 ( .IN1(b_in[16]), .IN2(n106), .IN3(product[17]), .IN4(n107), 
        .IN5(product[16]), .IN6(n108), .Q(n76) );
  AO222X1 U128 ( .IN1(b_in[17]), .IN2(n106), .IN3(product[18]), .IN4(n107), 
        .IN5(product[17]), .IN6(n108), .Q(n75) );
  AO222X1 U129 ( .IN1(b_in[18]), .IN2(n106), .IN3(product[19]), .IN4(n107), 
        .IN5(product[18]), .IN6(n108), .Q(n74) );
  AO222X1 U130 ( .IN1(b_in[19]), .IN2(n106), .IN3(product[20]), .IN4(n107), 
        .IN5(product[19]), .IN6(n108), .Q(n73) );
  AO222X1 U131 ( .IN1(b_in[20]), .IN2(n106), .IN3(product[21]), .IN4(n107), 
        .IN5(product[20]), .IN6(n108), .Q(n72) );
  AO222X1 U132 ( .IN1(b_in[21]), .IN2(n106), .IN3(product[22]), .IN4(n107), 
        .IN5(product[21]), .IN6(n108), .Q(n71) );
  AO222X1 U133 ( .IN1(b_in[22]), .IN2(n106), .IN3(product[23]), .IN4(n107), 
        .IN5(product[22]), .IN6(n108), .Q(n70) );
  AO222X1 U134 ( .IN1(b_in[23]), .IN2(n106), .IN3(product[24]), .IN4(n107), 
        .IN5(product[23]), .IN6(n108), .Q(n69) );
  AO222X1 U135 ( .IN1(b_in[24]), .IN2(n106), .IN3(product[25]), .IN4(n107), 
        .IN5(product[24]), .IN6(n108), .Q(n68) );
  AO222X1 U136 ( .IN1(b_in[25]), .IN2(n106), .IN3(product[26]), .IN4(n107), 
        .IN5(product[25]), .IN6(n108), .Q(n67) );
  AO222X1 U137 ( .IN1(b_in[26]), .IN2(n106), .IN3(product[27]), .IN4(n107), 
        .IN5(product[26]), .IN6(n108), .Q(n66) );
  AO222X1 U138 ( .IN1(b_in[27]), .IN2(n106), .IN3(product[28]), .IN4(n107), 
        .IN5(product[27]), .IN6(n108), .Q(n65) );
  AO222X1 U139 ( .IN1(b_in[28]), .IN2(n106), .IN3(product[29]), .IN4(n107), 
        .IN5(product[28]), .IN6(n108), .Q(n64) );
  AO222X1 U140 ( .IN1(b_in[29]), .IN2(n106), .IN3(product[30]), .IN4(n107), 
        .IN5(product[29]), .IN6(n108), .Q(n63) );
  AO222X1 U141 ( .IN1(b_in[30]), .IN2(n106), .IN3(product[31]), .IN4(n107), 
        .IN5(product[30]), .IN6(n108), .Q(n62) );
  AO222X1 U142 ( .IN1(b_in[31]), .IN2(n106), .IN3(product[32]), .IN4(n107), 
        .IN5(product[31]), .IN6(n108), .Q(n61) );
  NOR2X0 U143 ( .IN1(n109), .IN2(n108), .QN(n107) );
  INVX0 U144 ( .IN(n110), .QN(n108) );
  AO222X1 U145 ( .IN1(N23), .IN2(n111), .IN3(product[33]), .IN4(n112), .IN5(
        n113), .IN6(product[32]), .Q(n60) );
  AO222X1 U146 ( .IN1(N24), .IN2(n111), .IN3(product[34]), .IN4(n112), .IN5(
        n113), .IN6(product[33]), .Q(n59) );
  AO222X1 U147 ( .IN1(N25), .IN2(n111), .IN3(product[35]), .IN4(n112), .IN5(
        product[34]), .IN6(n113), .Q(n58) );
  AO222X1 U148 ( .IN1(N26), .IN2(n111), .IN3(product[36]), .IN4(n112), .IN5(
        product[35]), .IN6(n113), .Q(n57) );
  AO222X1 U149 ( .IN1(N27), .IN2(n111), .IN3(product[37]), .IN4(n112), .IN5(
        product[36]), .IN6(n113), .Q(n56) );
  AO222X1 U150 ( .IN1(N28), .IN2(n111), .IN3(product[38]), .IN4(n112), .IN5(
        product[37]), .IN6(n113), .Q(n55) );
  AO222X1 U151 ( .IN1(N29), .IN2(n111), .IN3(product[39]), .IN4(n112), .IN5(
        product[38]), .IN6(n113), .Q(n54) );
  AO222X1 U152 ( .IN1(N30), .IN2(n111), .IN3(product[40]), .IN4(n112), .IN5(
        product[39]), .IN6(n113), .Q(n53) );
  AO222X1 U153 ( .IN1(N31), .IN2(n111), .IN3(product[41]), .IN4(n112), .IN5(
        product[40]), .IN6(n113), .Q(n52) );
  AO222X1 U154 ( .IN1(N32), .IN2(n111), .IN3(product[42]), .IN4(n112), .IN5(
        product[41]), .IN6(n113), .Q(n51) );
  AO222X1 U155 ( .IN1(N33), .IN2(n111), .IN3(product[43]), .IN4(n112), .IN5(
        product[42]), .IN6(n113), .Q(n50) );
  AO222X1 U156 ( .IN1(N34), .IN2(n111), .IN3(product[44]), .IN4(n112), .IN5(
        product[43]), .IN6(n113), .Q(n49) );
  AO222X1 U157 ( .IN1(N35), .IN2(n111), .IN3(product[45]), .IN4(n112), .IN5(
        product[44]), .IN6(n113), .Q(n48) );
  AO222X1 U158 ( .IN1(N36), .IN2(n111), .IN3(product[46]), .IN4(n112), .IN5(
        product[45]), .IN6(n113), .Q(n47) );
  AO222X1 U159 ( .IN1(N37), .IN2(n111), .IN3(product[47]), .IN4(n112), .IN5(
        product[46]), .IN6(n113), .Q(n46) );
  AO222X1 U160 ( .IN1(N38), .IN2(n111), .IN3(product[48]), .IN4(n112), .IN5(
        product[47]), .IN6(n113), .Q(n45) );
  AO222X1 U161 ( .IN1(N39), .IN2(n111), .IN3(product[49]), .IN4(n112), .IN5(
        product[48]), .IN6(n113), .Q(n44) );
  AO222X1 U162 ( .IN1(N40), .IN2(n111), .IN3(product[50]), .IN4(n112), .IN5(
        product[49]), .IN6(n113), .Q(n43) );
  AO222X1 U163 ( .IN1(N41), .IN2(n111), .IN3(product[51]), .IN4(n112), .IN5(
        product[50]), .IN6(n113), .Q(n42) );
  AO222X1 U164 ( .IN1(N42), .IN2(n111), .IN3(product[52]), .IN4(n112), .IN5(
        product[51]), .IN6(n113), .Q(n41) );
  AO222X1 U165 ( .IN1(N43), .IN2(n111), .IN3(product[53]), .IN4(n112), .IN5(
        product[52]), .IN6(n113), .Q(n40) );
  AO222X1 U166 ( .IN1(N44), .IN2(n111), .IN3(product[54]), .IN4(n112), .IN5(
        product[53]), .IN6(n113), .Q(n39) );
  AO222X1 U167 ( .IN1(N45), .IN2(n111), .IN3(product[55]), .IN4(n112), .IN5(
        product[54]), .IN6(n113), .Q(n38) );
  AO222X1 U168 ( .IN1(N46), .IN2(n111), .IN3(product[56]), .IN4(n112), .IN5(
        product[55]), .IN6(n113), .Q(n37) );
  AO222X1 U169 ( .IN1(N47), .IN2(n111), .IN3(product[57]), .IN4(n112), .IN5(
        product[56]), .IN6(n113), .Q(n36) );
  AO222X1 U170 ( .IN1(N48), .IN2(n111), .IN3(product[58]), .IN4(n112), .IN5(
        product[57]), .IN6(n113), .Q(n35) );
  AO222X1 U171 ( .IN1(N49), .IN2(n111), .IN3(product[59]), .IN4(n112), .IN5(
        product[58]), .IN6(n113), .Q(n34) );
  AO222X1 U172 ( .IN1(N50), .IN2(n111), .IN3(product[60]), .IN4(n112), .IN5(
        product[59]), .IN6(n113), .Q(n33) );
  AO222X1 U173 ( .IN1(N51), .IN2(n111), .IN3(product[61]), .IN4(n112), .IN5(
        product[60]), .IN6(n113), .Q(n32) );
  AO222X1 U174 ( .IN1(N52), .IN2(n111), .IN3(product[62]), .IN4(n112), .IN5(
        product[61]), .IN6(n113), .Q(n31) );
  AO222X1 U175 ( .IN1(N53), .IN2(n111), .IN3(product[63]), .IN4(n112), .IN5(
        product[62]), .IN6(n113), .Q(n30) );
  INVX0 U176 ( .IN(n105), .QN(n112) );
  AO22X1 U177 ( .IN1(product[63]), .IN2(n113), .IN3(N54), .IN4(n111), .Q(n29)
         );
  NOR3X0 U178 ( .IN1(n113), .IN2(n124), .IN3(n109), .QN(n111) );
  AOI21X1 U179 ( .IN1(product[0]), .IN2(n104), .IN3(n110), .QN(n113) );
  NAND2X0 U180 ( .IN1(n114), .IN2(n105), .QN(n110) );
  NAND2X0 U181 ( .IN1(n124), .IN2(n104), .QN(n105) );
  AO21X1 U182 ( .IN1(n114), .IN2(done), .IN3(n115), .Q(n28) );
  OR2X1 U183 ( .IN1(n103), .IN2(N163), .Q(n101) );
  INVX0 U184 ( .IN(n102), .QN(n103) );
  AND2X1 U185 ( .IN1(N170), .IN2(n102), .Q(n100) );
  NAND2X0 U186 ( .IN1(n114), .IN2(n109), .QN(n102) );
  INVX0 U187 ( .IN(n104), .QN(n109) );
  NOR2X0 U188 ( .IN1(n106), .IN2(n115), .QN(n104) );
  NOR3X0 U189 ( .IN1(n120), .IN2(n119), .IN3(n116), .QN(n115) );
  INVX0 U190 ( .IN(n114), .QN(n106) );
  NAND3X0 U191 ( .IN1(n120), .IN2(n117), .IN3(n119), .QN(n114) );
  INVX0 U192 ( .IN(n116), .QN(n117) );
  NAND4X0 U193 ( .IN1(n122), .IN2(n123), .IN3(n121), .IN4(n118), .QN(n116) );
  NOR3X0 U194 ( .IN1(count[4]), .IN2(count[7]), .IN3(count[5]), .QN(n118) );
endmodule

