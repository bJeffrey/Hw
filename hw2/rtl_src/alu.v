/////////////////////////////////////////////////////////////
// Created by: Synopsys Design Compiler(R)
// Version   : L-2016.03-SP2
// Date      : Wed Apr 18 16:39:59 2018
/////////////////////////////////////////////////////////////


module alu ( in_a, in_b, opcode, alu_out, alu_zero, alu_carry );
  input [7:0] in_a;
  input [7:0] in_b;
  input [3:0] opcode;
  output [7:0] alu_out;
  output alu_zero, alu_carry;
  wire   N0, N1, N2, N3, N4, N5, N6, N7, N8, N9, N10, N11, N12, N13, N14, N15,
         N16, N17, N18, N19, N20, N21, N22, N23, N24, N25, N26, N27, N28, N29,
         N30, N31, N32, N33, N34, N35, N36, N37, N38, N39, N40, N41, N42, N43,
         N44, N45, N46, N47, N48, N49, N50, N51, N52, N53, N54, N55, N56, N57,
         N58, N59, N60, N61, N62, N63, N64, N65, N66, N67, N68, N69, N70, N71,
         N72, N73, N74, N75, N76, N77, N78, N79, N80, N81, N82, N83, N84, N85,
         N86, N87, N88, N89, N90, N91, N92, N93, N94, N95, N96, N97, N98, N99,
         N100, N101, N102, N103, N104, N105, N106, N107, N108, N109, N110,
         N111, N112, N113, N114, N115, N116, N117, N118, N119, N120, N121;

  GTECH_OR2 C17 ( .A(N12), .B(N22), .Z(N10) );
  GTECH_OR2 C20 ( .A(opcode[3]), .B(opcode[2]), .Z(N12) );
  GTECH_OR2 C22 ( .A(N12), .B(N26), .Z(N13) );
  GTECH_OR2 C28 ( .A(N12), .B(N29), .Z(N15) );
  GTECH_OR2 C33 ( .A(N21), .B(N34), .Z(N17) );
  GTECH_OR2 C37 ( .A(opcode[3]), .B(N19), .Z(N21) );
  GTECH_OR2 C38 ( .A(opcode[1]), .B(N20), .Z(N22) );
  GTECH_OR2 C39 ( .A(N21), .B(N22), .Z(N23) );
  GTECH_OR2 C44 ( .A(N25), .B(opcode[0]), .Z(N26) );
  GTECH_OR2 C45 ( .A(N21), .B(N26), .Z(N27) );
  GTECH_OR2 C51 ( .A(N25), .B(N20), .Z(N29) );
  GTECH_OR2 C52 ( .A(N21), .B(N29), .Z(N30) );
  GTECH_OR2 C55 ( .A(N32), .B(opcode[2]), .Z(N33) );
  GTECH_OR2 C56 ( .A(opcode[1]), .B(opcode[0]), .Z(N34) );
  GTECH_OR2 C57 ( .A(N33), .B(N34), .Z(N35) );
  GTECH_OR2 C63 ( .A(N33), .B(N22), .Z(N37) );
  GTECH_OR2 C69 ( .A(N33), .B(N26), .Z(N39) );
  GTECH_OR2 C76 ( .A(N33), .B(N29), .Z(N41) );
  GTECH_AND2 C78 ( .A(opcode[3]), .B(opcode[2]), .Z(N43) );
  GTECH_AND2 C83 ( .A(N32), .B(N19), .Z(N44) );
  GTECH_AND2 C84 ( .A(N25), .B(N20), .Z(N45) );
  GTECH_AND2 C85 ( .A(N44), .B(N45), .Z(N46) );
  \**SEQGEN**  alu_carry_reg ( .clear(1'b0), .preset(1'b0), .next_state(1'b0), 
        .clocked_on(1'b0), .data_in(N102), .enable(N101), .Q(alu_carry), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b0) );
  SUB_UNS_OP sub_33 ( .A(in_a), .B(in_b), .Z({N64, N63, N62, N61, N60, N59, 
        N58, N57}) );
  SUB_UNS_OP sub_40 ( .A(in_a), .B(1'b1), .Z({N81, N80, N79, N78, N77, N76, 
        N75, N74}) );
  ADD_UNS_OP add_30 ( .A(in_a), .B(in_b), .Z({N56, N55, N54, N53, N52, N51, 
        N50, N49, N48}) );
  ADD_UNS_OP add_37 ( .A(in_a), .B(1'b1), .Z({N73, N72, N71, N70, N69, N68, 
        N67, N66, N65}) );
  SUB_UNS_OP sub_61 ( .A(1'b0), .B(in_a), .Z({N100, N99, N98, N97, N96, N95, 
        N94, N93, N92}) );
  SELECT_OP C141 ( .DATA1(1'b1), .DATA2(1'b0), .DATA3(1'b1), .DATA4(1'b0), 
        .DATA5(1'b0), .DATA6(1'b0), .DATA7(1'b0), .DATA8(1'b0), .DATA9(1'b0), 
        .DATA10(1'b1), .DATA11(1'b1), .DATA12(1'b0), .CONTROL1(N11), 
        .CONTROL2(N14), .CONTROL3(N16), .CONTROL4(N18), .CONTROL5(N24), 
        .CONTROL6(N28), .CONTROL7(N31), .CONTROL8(N36), .CONTROL9(N38), 
        .CONTROL10(N40), .CONTROL11(N42), .CONTROL12(N47), .Z(N101) );
  SELECT_OP C142 ( .DATA1(N56), .DATA2(N73), .DATA3(1'b1), .DATA4(N100), 
        .CONTROL1(N11), .CONTROL2(N16), .CONTROL3(N40), .CONTROL4(N42), .Z(
        N102) );
  SELECT_OP C143 ( .DATA1({N55, N54, N53, N52, N51, N50, N49, N48}), .DATA2({
        N64, N63, N62, N61, N60, N59, N58, N57}), .DATA3({N72, N71, N70, N69, 
        N68, N67, N66, N65}), .DATA4({N81, N80, N79, N78, N77, N76, N75, N74}), 
        .DATA5({1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, N82}), .DATA6({1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, N83}), .DATA7({N84, N85, N86, N87, 
        N88, N89, N90, N91}), .DATA8({1'b0, in_a[7:1]}), .DATA9({in_a[6:0], 
        1'b0}), .DATA10({N2, N3, N4, N5, N6, N7, N8, N9}), .DATA11({N99, N98, 
        N97, N96, N95, N94, N93, N92}), .CONTROL1(N11), .CONTROL2(N14), 
        .CONTROL3(N16), .CONTROL4(N18), .CONTROL5(N24), .CONTROL6(N28), 
        .CONTROL7(N31), .CONTROL8(N36), .CONTROL9(N38), .CONTROL10(N40), 
        .CONTROL11(N42), .Z(alu_out) );
  GTECH_OR2 C146 ( .A(N108), .B(in_a[0]), .Z(N0) );
  GTECH_OR2 C147 ( .A(N107), .B(in_a[1]), .Z(N108) );
  GTECH_OR2 C148 ( .A(N106), .B(in_a[2]), .Z(N107) );
  GTECH_OR2 C149 ( .A(N105), .B(in_a[3]), .Z(N106) );
  GTECH_OR2 C150 ( .A(N104), .B(in_a[4]), .Z(N105) );
  GTECH_OR2 C151 ( .A(N103), .B(in_a[5]), .Z(N104) );
  GTECH_OR2 C152 ( .A(in_a[7]), .B(in_a[6]), .Z(N103) );
  GTECH_OR2 C153 ( .A(N114), .B(in_b[0]), .Z(N1) );
  GTECH_OR2 C154 ( .A(N113), .B(in_b[1]), .Z(N114) );
  GTECH_OR2 C155 ( .A(N112), .B(in_b[2]), .Z(N113) );
  GTECH_OR2 C156 ( .A(N111), .B(in_b[3]), .Z(N112) );
  GTECH_OR2 C157 ( .A(N110), .B(in_b[4]), .Z(N111) );
  GTECH_OR2 C158 ( .A(N109), .B(in_b[5]), .Z(N110) );
  GTECH_OR2 C159 ( .A(in_b[7]), .B(in_b[6]), .Z(N109) );
  GTECH_NOT I_0 ( .A(in_a[7]), .Z(N2) );
  GTECH_NOT I_1 ( .A(in_a[6]), .Z(N3) );
  GTECH_NOT I_2 ( .A(in_a[5]), .Z(N4) );
  GTECH_NOT I_3 ( .A(in_a[4]), .Z(N5) );
  GTECH_NOT I_4 ( .A(in_a[3]), .Z(N6) );
  GTECH_NOT I_5 ( .A(in_a[2]), .Z(N7) );
  GTECH_NOT I_6 ( .A(in_a[1]), .Z(N8) );
  GTECH_NOT I_7 ( .A(in_a[0]), .Z(N9) );
  GTECH_NOT I_8 ( .A(N10), .Z(N11) );
  GTECH_NOT I_9 ( .A(N13), .Z(N14) );
  GTECH_NOT I_10 ( .A(N15), .Z(N16) );
  GTECH_NOT I_11 ( .A(N17), .Z(N18) );
  GTECH_NOT I_12 ( .A(opcode[2]), .Z(N19) );
  GTECH_NOT I_13 ( .A(opcode[0]), .Z(N20) );
  GTECH_NOT I_14 ( .A(N23), .Z(N24) );
  GTECH_NOT I_15 ( .A(opcode[1]), .Z(N25) );
  GTECH_NOT I_16 ( .A(N27), .Z(N28) );
  GTECH_NOT I_17 ( .A(N30), .Z(N31) );
  GTECH_NOT I_18 ( .A(opcode[3]), .Z(N32) );
  GTECH_NOT I_19 ( .A(N35), .Z(N36) );
  GTECH_NOT I_20 ( .A(N37), .Z(N38) );
  GTECH_NOT I_21 ( .A(N39), .Z(N40) );
  GTECH_NOT I_22 ( .A(N41), .Z(N42) );
  GTECH_OR2 C183 ( .A(N43), .B(N46), .Z(N47) );
  GTECH_BUF B_0 ( .A(N11) );
  GTECH_BUF B_1 ( .A(N14) );
  GTECH_BUF B_2 ( .A(N16) );
  GTECH_BUF B_3 ( .A(N18) );
  GTECH_OR2 C200 ( .A(N0), .B(N1), .Z(N82) );
  GTECH_AND2 C201 ( .A(N0), .B(N1), .Z(N83) );
  GTECH_XOR2 C202 ( .A(in_a[7]), .B(in_b[7]), .Z(N84) );
  GTECH_XOR2 C203 ( .A(in_a[6]), .B(in_b[6]), .Z(N85) );
  GTECH_XOR2 C204 ( .A(in_a[5]), .B(in_b[5]), .Z(N86) );
  GTECH_XOR2 C205 ( .A(in_a[4]), .B(in_b[4]), .Z(N87) );
  GTECH_XOR2 C206 ( .A(in_a[3]), .B(in_b[3]), .Z(N88) );
  GTECH_XOR2 C207 ( .A(in_a[2]), .B(in_b[2]), .Z(N89) );
  GTECH_XOR2 C208 ( .A(in_a[1]), .B(in_b[1]), .Z(N90) );
  GTECH_XOR2 C209 ( .A(in_a[0]), .B(in_b[0]), .Z(N91) );
  GTECH_BUF B_4 ( .A(N42) );
  GTECH_NOT I_23 ( .A(N121), .Z(alu_zero) );
  GTECH_OR2 C212 ( .A(N120), .B(alu_out[0]), .Z(N121) );
  GTECH_OR2 C213 ( .A(N119), .B(alu_out[1]), .Z(N120) );
  GTECH_OR2 C214 ( .A(N118), .B(alu_out[2]), .Z(N119) );
  GTECH_OR2 C215 ( .A(N117), .B(alu_out[3]), .Z(N118) );
  GTECH_OR2 C216 ( .A(N116), .B(alu_out[4]), .Z(N117) );
  GTECH_OR2 C217 ( .A(N115), .B(alu_out[5]), .Z(N116) );
  GTECH_OR2 C218 ( .A(alu_out[7]), .B(alu_out[6]), .Z(N115) );
endmodule

