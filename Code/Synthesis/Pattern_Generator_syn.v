/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : U-2022.12
// Date      : Sat Nov  2 11:47:58 2024
/////////////////////////////////////////////////////////////


module Binary2Gray ( in, out );
  input [11:0] in;
  output [11:0] out;
  wire   \in[11] ;
  assign out[11] = \in[11] ;
  assign \in[11]  = in[11];

  CLKXOR2_X2_12_LVT_NT U1 ( .A(in[9]), .B(in[10]), .Q(out[9]) );
  CLKXOR2_X2_12_LVT_NT U2 ( .A(in[9]), .B(in[8]), .Q(out[8]) );
  CLKXOR2_X2_12_LVT_NT U3 ( .A(in[8]), .B(in[7]), .Q(out[7]) );
  CLKXOR2_X2_12_LVT_NT U4 ( .A(in[7]), .B(in[6]), .Q(out[6]) );
  CLKXOR2_X2_12_LVT_NT U5 ( .A(in[6]), .B(in[5]), .Q(out[5]) );
  CLKXOR2_X2_12_LVT_NT U6 ( .A(in[5]), .B(in[4]), .Q(out[4]) );
  CLKXOR2_X2_12_LVT_NT U7 ( .A(in[4]), .B(in[3]), .Q(out[3]) );
  CLKXOR2_X2_12_LVT_NT U8 ( .A(in[3]), .B(in[2]), .Q(out[2]) );
  CLKXOR2_X2_12_LVT_NT U9 ( .A(in[2]), .B(in[1]), .Q(out[1]) );
  CLKXOR2_X2_12_LVT_NT U10 ( .A(\in[11] ), .B(in[10]), .Q(out[10]) );
  CLKXOR2_X2_12_LVT_NT U11 ( .A(in[1]), .B(in[0]), .Q(out[0]) );
endmodule


module Counter ( clk, rst_n, cnt_enb, Xmode, LoadVal, out );
  input [1:0] Xmode;
  input [11:0] LoadVal;
  output [11:0] out;
  input clk, rst_n, cnt_enb;
  wire   deltaX_0, N17, N18, N19, N20, N21, N22, N23, N24, N25, N26, N27, N28,
         N29, N30, N31, N32, N33, N34, N35, N36, N37, N38, N39, N40,
         \add_60/carry[11] , \add_60/carry[10] , \add_60/carry[9] ,
         \add_60/carry[8] , \add_60/carry[7] , \add_60/carry[6] ,
         \add_60/carry[5] , \add_60/carry[4] , \add_60/carry[3] ,
         \add_60/carry[2] , \add_60/carry[1] , n1, n2;
  wire   [3:2] deltaX;

  NOR2_X4_12_LVT_NT U4 ( .A(n1), .B(n2), .Q(deltaX[3]) );
  DFFRQ_X2_12_LVT_NT \out_reg[11]  ( .D(N40), .CK(clk), .RN(rst_n), .Q(out[11]) );
  DFFRQ_X2_12_LVT_NT \out_reg[10]  ( .D(N39), .CK(clk), .RN(rst_n), .Q(out[10]) );
  DFFRQ_X2_12_LVT_NT \out_reg[9]  ( .D(N38), .CK(clk), .RN(rst_n), .Q(out[9])
         );
  DFFRQ_X2_12_LVT_NT \out_reg[8]  ( .D(N37), .CK(clk), .RN(rst_n), .Q(out[8])
         );
  DFFRQ_X2_12_LVT_NT \out_reg[7]  ( .D(N36), .CK(clk), .RN(rst_n), .Q(out[7])
         );
  DFFRQ_X2_12_LVT_NT \out_reg[6]  ( .D(N35), .CK(clk), .RN(rst_n), .Q(out[6])
         );
  DFFRQ_X2_12_LVT_NT \out_reg[5]  ( .D(N34), .CK(clk), .RN(rst_n), .Q(out[5])
         );
  DFFRQ_X2_12_LVT_NT \out_reg[4]  ( .D(N33), .CK(clk), .RN(rst_n), .Q(out[4])
         );
  DFFRQ_X2_12_LVT_NT \out_reg[3]  ( .D(N32), .CK(clk), .RN(rst_n), .Q(out[3])
         );
  DFFRQ_X2_12_LVT_NT \out_reg[2]  ( .D(N31), .CK(clk), .RN(rst_n), .Q(out[2])
         );
  DFFRQ_X2_12_LVT_NT \out_reg[1]  ( .D(N30), .CK(clk), .RN(rst_n), .Q(out[1])
         );
  DFFRQ_X2_12_LVT_NT \out_reg[0]  ( .D(N29), .CK(clk), .RN(rst_n), .Q(out[0])
         );
  FA1_X0_12_LVT_NT \add_60/U1_2  ( .A(LoadVal[2]), .B(deltaX[2]), .CI(
        \add_60/carry[2] ), .CO(\add_60/carry[3] ), .S(N19) );
  FA1_X0_12_LVT_NT \add_60/U1_3  ( .A(LoadVal[3]), .B(deltaX[3]), .CI(
        \add_60/carry[3] ), .CO(\add_60/carry[4] ), .S(N20) );
  XOR2_X2_12_LVT_NT U3 ( .A(LoadVal[11]), .B(\add_60/carry[11] ), .Q(N28) );
  XOR2_X1_12_LVT_NT U5 ( .A(LoadVal[4]), .B(\add_60/carry[4] ), .Q(N21) );
  AND2_X2_12_LVT_NT U6 ( .A(\add_60/carry[9] ), .B(LoadVal[9]), .Q(
        \add_60/carry[10] ) );
  AND2_X2_12_LVT_NT U7 ( .A(\add_60/carry[8] ), .B(LoadVal[8]), .Q(
        \add_60/carry[9] ) );
  AND2_X2_12_LVT_NT U8 ( .A(\add_60/carry[7] ), .B(LoadVal[7]), .Q(
        \add_60/carry[8] ) );
  AND2_X2_12_LVT_NT U9 ( .A(\add_60/carry[6] ), .B(LoadVal[6]), .Q(
        \add_60/carry[7] ) );
  AND2_X2_12_LVT_NT U10 ( .A(\add_60/carry[5] ), .B(LoadVal[5]), .Q(
        \add_60/carry[6] ) );
  AND2_X2_12_LVT_NT U11 ( .A(\add_60/carry[4] ), .B(LoadVal[4]), .Q(
        \add_60/carry[5] ) );
  AND2_X2_12_LVT_NT U12 ( .A(LoadVal[0]), .B(deltaX_0), .Q(\add_60/carry[1] )
         );
  AND2_X2_12_LVT_NT U13 ( .A(\add_60/carry[1] ), .B(LoadVal[1]), .Q(
        \add_60/carry[2] ) );
  AND2_X0_12_LVT_NT U14 ( .A(cnt_enb), .B(N28), .Q(N40) );
  AND2_X0_12_LVT_NT U15 ( .A(N27), .B(cnt_enb), .Q(N39) );
  AND2_X0_12_LVT_NT U16 ( .A(N26), .B(cnt_enb), .Q(N38) );
  AND2_X0_12_LVT_NT U17 ( .A(N25), .B(cnt_enb), .Q(N37) );
  AND2_X0_12_LVT_NT U18 ( .A(N24), .B(cnt_enb), .Q(N36) );
  AND2_X0_12_LVT_NT U19 ( .A(N23), .B(cnt_enb), .Q(N35) );
  AND2_X0_12_LVT_NT U20 ( .A(N22), .B(cnt_enb), .Q(N34) );
  AND2_X0_12_LVT_NT U21 ( .A(N21), .B(cnt_enb), .Q(N33) );
  AND2_X0_12_LVT_NT U22 ( .A(N20), .B(cnt_enb), .Q(N32) );
  AND2_X0_12_LVT_NT U23 ( .A(N19), .B(cnt_enb), .Q(N31) );
  AND2_X0_12_LVT_NT U24 ( .A(N18), .B(cnt_enb), .Q(N30) );
  AND2_X0_12_LVT_NT U25 ( .A(N17), .B(cnt_enb), .Q(N29) );
  NOR2_X2_12_LVT_NT U26 ( .A(Xmode[0]), .B(n2), .Q(deltaX[2]) );
  NOR2_X2_12_LVT_NT U27 ( .A(Xmode[1]), .B(n1), .Q(deltaX_0) );
  INV_X2_12_LVT_NT U28 ( .A(Xmode[1]), .Q(n2) );
  INV_X2_12_LVT_NT U29 ( .A(Xmode[0]), .Q(n1) );
  AND2_X0_12_LVT_NT U30 ( .A(\add_60/carry[10] ), .B(LoadVal[10]), .Q(
        \add_60/carry[11] ) );
  CLKXOR2_X2_12_LVT_NT U31 ( .A(LoadVal[10]), .B(\add_60/carry[10] ), .Q(N27)
         );
  CLKXOR2_X2_12_LVT_NT U32 ( .A(LoadVal[9]), .B(\add_60/carry[9] ), .Q(N26) );
  CLKXOR2_X2_12_LVT_NT U33 ( .A(LoadVal[8]), .B(\add_60/carry[8] ), .Q(N25) );
  CLKXOR2_X2_12_LVT_NT U34 ( .A(LoadVal[7]), .B(\add_60/carry[7] ), .Q(N24) );
  CLKXOR2_X2_12_LVT_NT U35 ( .A(LoadVal[6]), .B(\add_60/carry[6] ), .Q(N23) );
  CLKXOR2_X2_12_LVT_NT U36 ( .A(LoadVal[5]), .B(\add_60/carry[5] ), .Q(N22) );
  CLKXOR2_X2_12_LVT_NT U37 ( .A(LoadVal[1]), .B(\add_60/carry[1] ), .Q(N18) );
  CLKXOR2_X2_12_LVT_NT U38 ( .A(deltaX_0), .B(LoadVal[0]), .Q(N17) );
endmodule


module Counter12Bit_DW01_inc_0_DW01_inc_3 ( A, SUM );
  input [11:0] A;
  output [11:0] SUM;

  wire   [11:2] carry;

  HA1_X2_12_LVT_NT U1_1_10 ( .A(A[10]), .B(carry[10]), .CO(carry[11]), .S(
        SUM[10]) );
  HA1_X2_12_LVT_NT U1_1_8 ( .A(A[8]), .B(carry[8]), .CO(carry[9]), .S(SUM[8])
         );
  HA1_X2_12_LVT_NT U1_1_3 ( .A(A[3]), .B(carry[3]), .CO(carry[4]), .S(SUM[3])
         );
  HA1_X2_12_LVT_NT U1_1_2 ( .A(A[2]), .B(carry[2]), .CO(carry[3]), .S(SUM[2])
         );
  HA1_X2_12_LVT_NT U1_1_9 ( .A(A[9]), .B(carry[9]), .CO(carry[10]), .S(SUM[9])
         );
  HA1_X2_12_LVT_NT U1_1_4 ( .A(A[4]), .B(carry[4]), .CO(carry[5]), .S(SUM[4])
         );
  HA1_X2_12_LVT_NT U1_1_6 ( .A(A[6]), .B(carry[6]), .CO(carry[7]), .S(SUM[6])
         );
  HA1_X2_12_LVT_NT U1_1_7 ( .A(A[7]), .B(carry[7]), .CO(carry[8]), .S(SUM[7])
         );
  HA1_X2_12_LVT_NT U1_1_5 ( .A(A[5]), .B(carry[5]), .CO(carry[6]), .S(SUM[5])
         );
  HA1_X1_12_LVT_NT U1_1_1 ( .A(A[1]), .B(A[0]), .CO(carry[2]), .S(SUM[1]) );
  INV_X2_12_LVT_NT U1 ( .A(A[0]), .Q(SUM[0]) );
  CLKXOR2_X2_12_LVT_NT U2 ( .A(carry[11]), .B(A[11]), .Q(SUM[11]) );
endmodule


module Counter12Bit ( clk, rst_n, b12_enb, test, endLine );
  input clk, rst_n, b12_enb, test;
  output endLine;
  wire   N10, N11, N12, N13, N14, N15, N16, N17, N18, N19, N20, N21, N22, N23,
         N24, N25, N26, N27, N28, N29, N30, N31, N32, N33, n1, n2, n4, n5, n6,
         n7, n3, n8, n9, n10, n11, n12, n13, n14, n15;
  wire   [11:0] count;

  NAND2_A_NOR3_X4_12_LVT_NT U6 ( .AN(count[2]), .BN(count[4]), .C(n5), .D(n6), 
        .Q(n4) );
  DFFRQ_X2_12_LVT_NT \count_reg[0]  ( .D(N22), .CK(clk), .RN(rst_n), .Q(
        count[0]) );
  DFFRQ_X2_12_LVT_NT \count_reg[1]  ( .D(N23), .CK(clk), .RN(rst_n), .Q(
        count[1]) );
  DFFRQ_X2_12_LVT_NT \count_reg[2]  ( .D(N24), .CK(clk), .RN(rst_n), .Q(
        count[2]) );
  DFFRQ_X2_12_LVT_NT \count_reg[3]  ( .D(N25), .CK(clk), .RN(rst_n), .Q(
        count[3]) );
  DFFRQ_X2_12_LVT_NT \count_reg[4]  ( .D(N26), .CK(clk), .RN(rst_n), .Q(
        count[4]) );
  DFFRQ_X2_12_LVT_NT \count_reg[5]  ( .D(N27), .CK(clk), .RN(rst_n), .Q(
        count[5]) );
  DFFRQ_X2_12_LVT_NT \count_reg[6]  ( .D(N28), .CK(clk), .RN(rst_n), .Q(
        count[6]) );
  DFFRQ_X2_12_LVT_NT \count_reg[7]  ( .D(N29), .CK(clk), .RN(rst_n), .Q(
        count[7]) );
  DFFRQ_X2_12_LVT_NT \count_reg[8]  ( .D(N30), .CK(clk), .RN(rst_n), .Q(
        count[8]) );
  DFFRQ_X2_12_LVT_NT \count_reg[9]  ( .D(N31), .CK(clk), .RN(rst_n), .Q(
        count[9]) );
  DFFRQ_X2_12_LVT_NT \count_reg[10]  ( .D(N32), .CK(clk), .RN(rst_n), .Q(
        count[10]) );
  DFFRQ_X2_12_LVT_NT \count_reg[11]  ( .D(N33), .CK(clk), .RN(rst_n), .Q(
        count[11]) );
  Counter12Bit_DW01_inc_0_DW01_inc_3 add_66 ( .A(count), .SUM({N21, N20, N19, 
        N18, N17, N16, N15, N14, N13, N12, N11, N10}) );
  OAI211_X2_12_LVT_NT U3 ( .A0(n3), .A1(n4), .B0(count[0]), .C0(count[10]), 
        .Q(n1) );
  AND2_X2_12_LVT_NT U4 ( .A(n8), .B(n11), .Q(n3) );
  AND2_X0_12_LVT_NT U5 ( .A(n7), .B(n15), .Q(n8) );
  OR2_X2_12_LVT_NT U7 ( .A(count[2]), .B(n12), .Q(n9) );
  OR2_X2_12_LVT_NT U8 ( .A(count[1]), .B(count[11]), .Q(n10) );
  AND2_X2_12_LVT_NT U9 ( .A(n13), .B(n14), .Q(n11) );
  NOR2_X2_12_LVT_NT U10 ( .A(n10), .B(n9), .Q(n7) );
  INV_X0_12_LVT_NT U11 ( .A(test), .Q(n12) );
  INV_X0_12_LVT_NT U12 ( .A(count[4]), .Q(n13) );
  INV_X0_12_LVT_NT U13 ( .A(count[5]), .Q(n14) );
  AND2_X0_12_LVT_NT U14 ( .A(N20), .B(b12_enb), .Q(N32) );
  AND2_X0_12_LVT_NT U15 ( .A(N19), .B(b12_enb), .Q(N31) );
  AND2_X0_12_LVT_NT U16 ( .A(N18), .B(b12_enb), .Q(N30) );
  AND2_X0_12_LVT_NT U17 ( .A(N17), .B(b12_enb), .Q(N29) );
  AND2_X0_12_LVT_NT U18 ( .A(N16), .B(b12_enb), .Q(N28) );
  AND2_X0_12_LVT_NT U19 ( .A(N15), .B(b12_enb), .Q(N27) );
  AND2_X0_12_LVT_NT U20 ( .A(N14), .B(b12_enb), .Q(N26) );
  AND2_X0_12_LVT_NT U21 ( .A(N13), .B(b12_enb), .Q(N25) );
  AND2_X0_12_LVT_NT U22 ( .A(N12), .B(b12_enb), .Q(N24) );
  AND2_X0_12_LVT_NT U23 ( .A(N11), .B(b12_enb), .Q(N23) );
  NOR3_X2_12_LVT_NT U24 ( .A(count[7]), .B(count[9]), .C(count[6]), .Q(n15) );
  NOR2_X2_12_LVT_NT U25 ( .A(n1), .B(n2), .Q(endLine) );
  NAND2_X2_12_LVT_NT U26 ( .A(count[8]), .B(count[3]), .Q(n2) );
  NAND4_X2_12_LVT_NT U27 ( .A(count[9]), .B(count[7]), .C(count[6]), .D(
        count[5]), .Q(n5) );
  INV_A_NAND3_X2_12_LVT_NT U28 ( .AN(test), .B(count[11]), .C(count[1]), .Q(n6) );
  AND2_X0_12_LVT_NT U29 ( .A(N10), .B(b12_enb), .Q(N22) );
  AND2_X0_12_LVT_NT U30 ( .A(b12_enb), .B(N21), .Q(N33) );
endmodule


module Counter5Bit ( clk, rst_n, b5_enb, newLine, endFrame );
  input clk, rst_n, b5_enb, newLine;
  output endFrame;
  wire   N7, N8, N9, N10, N11, n1, n2, n3, n4, n5, n6, n7, n8, n10,
         \add_58/carry[4] , \add_58/carry[3] , \add_58/carry[2] ;
  wire   [4:0] count;

  DFFRQ_X2_12_LVT_NT \count_reg[0]  ( .D(n8), .CK(clk), .RN(rst_n), .Q(
        count[0]) );
  DFFRQ_X2_12_LVT_NT \count_reg[1]  ( .D(n7), .CK(clk), .RN(rst_n), .Q(
        count[1]) );
  DFFRQ_X2_12_LVT_NT \count_reg[2]  ( .D(n6), .CK(clk), .RN(rst_n), .Q(
        count[2]) );
  DFFRQ_X2_12_LVT_NT \count_reg[3]  ( .D(n5), .CK(clk), .RN(rst_n), .Q(
        count[3]) );
  DFFRQ_X2_12_LVT_NT \count_reg[4]  ( .D(n4), .CK(clk), .RN(rst_n), .Q(
        count[4]) );
  OR4_X2_12_LVT_NT U3 ( .A(n3), .B(count[0]), .C(count[2]), .D(count[1]), .Q(
        n10) );
  INV_X2_12_LVT_NT U4 ( .A(n10), .Q(endFrame) );
  INV_A_NAND2_X2_12_LVT_NT U5 ( .AN(newLine), .B(b5_enb), .Q(n2) );
  AND2_X2_12_LVT_NT U6 ( .A(b5_enb), .B(n2), .Q(n1) );
  INV_A_AO22_X2_12_LVT_NT U7 ( .B0(N11), .B1(n1), .A0(count[4]), .A1N(n2), .Q(
        n4) );
  INV_A_AO22_X2_12_LVT_NT U8 ( .B0(N10), .B1(n1), .A0(count[3]), .A1N(n2), .Q(
        n5) );
  INV_A_AO22_X2_12_LVT_NT U9 ( .B0(N9), .B1(n1), .A0(count[2]), .A1N(n2), .Q(
        n6) );
  INV_A_AO22_X2_12_LVT_NT U10 ( .B0(N8), .B1(n1), .A0(count[1]), .A1N(n2), .Q(
        n7) );
  INV_A_AO22_X0_12_LVT_NT U11 ( .B0(N7), .B1(n1), .A0(count[0]), .A1N(n2), .Q(
        n8) );
  INV_X2_12_LVT_NT U12 ( .A(count[0]), .Q(N7) );
  NAND2_X2_12_LVT_NT U13 ( .A(count[3]), .B(count[4]), .Q(n3) );
  HA1_X2_12_LVT_NT U14 ( .A(count[1]), .B(count[0]), .CO(\add_58/carry[2] ), 
        .S(N8) );
  HA1_X2_12_LVT_NT U15 ( .A(count[2]), .B(\add_58/carry[2] ), .CO(
        \add_58/carry[3] ), .S(N9) );
  HA1_X2_12_LVT_NT U16 ( .A(count[3]), .B(\add_58/carry[3] ), .CO(
        \add_58/carry[4] ), .S(N10) );
  CLKXOR2_X2_12_LVT_NT U17 ( .A(\add_58/carry[4] ), .B(count[4]), .Q(N11) );
endmodule


module Ramp ( clk, rst_n, ramp_enb, delta, Y, out );
  input [1:0] Y;
  output [11:0] out;
  input clk, rst_n, ramp_enb, delta;
  wire   deltaY_8, \deltaY[4] , deltaY_0, N18, N19, N20, N21, N22, N23, N24,
         N25, N26, N27, N28, N29, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12,
         n13, n14, n15, n16, \add_70/carry[11] , \add_70/carry[10] ,
         \add_70/carry[9] , \add_70/carry[8] , \add_70/carry[7] ,
         \add_70/carry[6] , \add_70/carry[5] , \add_70/carry[4] ,
         \add_70/carry[3] , \add_70/carry[2] , \add_70/carry[1] ;

  INV_A_NOR2_X4_12_LVT_NT U18 ( .AN(Y[1]), .B(Y[0]), .Q(\deltaY[4] ) );
  DFFRQ_X2_12_LVT_NT \out_reg[0]  ( .D(n16), .CK(clk), .RN(rst_n), .Q(out[0])
         );
  DFFRQ_X2_12_LVT_NT \out_reg[1]  ( .D(n15), .CK(clk), .RN(rst_n), .Q(out[1])
         );
  DFFRQ_X2_12_LVT_NT \out_reg[2]  ( .D(n14), .CK(clk), .RN(rst_n), .Q(out[2])
         );
  DFFRQ_X2_12_LVT_NT \out_reg[3]  ( .D(n13), .CK(clk), .RN(rst_n), .Q(out[3])
         );
  DFFRQ_X2_12_LVT_NT \out_reg[4]  ( .D(n12), .CK(clk), .RN(rst_n), .Q(out[4])
         );
  DFFRQ_X2_12_LVT_NT \out_reg[5]  ( .D(n11), .CK(clk), .RN(rst_n), .Q(out[5])
         );
  DFFRQ_X2_12_LVT_NT \out_reg[6]  ( .D(n10), .CK(clk), .RN(rst_n), .Q(out[6])
         );
  DFFRQ_X2_12_LVT_NT \out_reg[7]  ( .D(n9), .CK(clk), .RN(rst_n), .Q(out[7])
         );
  DFFRQ_X2_12_LVT_NT \out_reg[8]  ( .D(n8), .CK(clk), .RN(rst_n), .Q(out[8])
         );
  DFFRQ_X2_12_LVT_NT \out_reg[9]  ( .D(n7), .CK(clk), .RN(rst_n), .Q(out[9])
         );
  DFFRQ_X2_12_LVT_NT \out_reg[10]  ( .D(n6), .CK(clk), .RN(rst_n), .Q(out[10])
         );
  DFFRQ_X2_12_LVT_NT \out_reg[11]  ( .D(n5), .CK(clk), .RN(rst_n), .Q(out[11])
         );
  FA1_X0_12_LVT_NT \add_70/U1_1  ( .A(out[1]), .B(deltaY_8), .CI(
        \add_70/carry[1] ), .CO(\add_70/carry[2] ), .S(N19) );
  FA1_X0_12_LVT_NT \add_70/U1_3  ( .A(out[3]), .B(deltaY_8), .CI(
        \add_70/carry[3] ), .CO(\add_70/carry[4] ), .S(N21) );
  FA1_X0_12_LVT_NT \add_70/U1_4  ( .A(out[4]), .B(\deltaY[4] ), .CI(
        \add_70/carry[4] ), .CO(\add_70/carry[5] ), .S(N22) );
  FA1_X0_12_LVT_NT \add_70/U1_8  ( .A(out[8]), .B(deltaY_8), .CI(
        \add_70/carry[8] ), .CO(\add_70/carry[9] ), .S(N26) );
  FA1_X0_12_LVT_NT \add_70/U1_10  ( .A(out[10]), .B(deltaY_8), .CI(
        \add_70/carry[10] ), .CO(\add_70/carry[11] ), .S(N28) );
  XOR2_X1_12_LVT_NT U3 ( .A(out[2]), .B(\add_70/carry[2] ), .Q(N20) );
  XOR2_X1_12_LVT_NT U4 ( .A(out[9]), .B(\add_70/carry[9] ), .Q(N27) );
  XOR2_X1_12_LVT_NT U5 ( .A(out[5]), .B(\add_70/carry[5] ), .Q(N23) );
  INV_A_NOR2_X12_12_LVT_NT U6 ( .AN(Y[0]), .B(deltaY_0), .Q(deltaY_8) );
  INV_A_NOR2_X8_12_LVT_NT U7 ( .AN(Y[0]), .B(Y[1]), .Q(deltaY_0) );
  AND2_X2_12_LVT_NT U8 ( .A(\add_70/carry[6] ), .B(out[6]), .Q(
        \add_70/carry[7] ) );
  AND2_X2_12_LVT_NT U9 ( .A(\add_70/carry[5] ), .B(out[5]), .Q(
        \add_70/carry[6] ) );
  AND2_X2_12_LVT_NT U10 ( .A(\add_70/carry[2] ), .B(out[2]), .Q(
        \add_70/carry[3] ) );
  AND2_X2_12_LVT_NT U11 ( .A(out[0]), .B(deltaY_0), .Q(\add_70/carry[1] ) );
  AND2_X2_12_LVT_NT U12 ( .A(\add_70/carry[7] ), .B(out[7]), .Q(
        \add_70/carry[8] ) );
  AND2_X2_12_LVT_NT U13 ( .A(\add_70/carry[9] ), .B(out[9]), .Q(
        \add_70/carry[10] ) );
  AO22_X2_12_LVT_NT U14 ( .A0(out[11]), .A1(n3), .B0(N29), .B1(n4), .Q(n5) );
  AO22_X0_12_LVT_NT U15 ( .A0(out[10]), .A1(n3), .B0(N28), .B1(n4), .Q(n6) );
  AO22_X2_12_LVT_NT U16 ( .A0(out[9]), .A1(n3), .B0(N27), .B1(n4), .Q(n7) );
  AO22_X0_12_LVT_NT U17 ( .A0(out[8]), .A1(n3), .B0(N26), .B1(n4), .Q(n8) );
  AO22_X2_12_LVT_NT U19 ( .A0(out[7]), .A1(n3), .B0(N25), .B1(n4), .Q(n9) );
  AO22_X2_12_LVT_NT U20 ( .A0(out[6]), .A1(n3), .B0(N24), .B1(n4), .Q(n10) );
  AO22_X2_12_LVT_NT U21 ( .A0(out[5]), .A1(n3), .B0(N23), .B1(n4), .Q(n11) );
  AO22_X0_12_LVT_NT U22 ( .A0(out[4]), .A1(n3), .B0(N22), .B1(n4), .Q(n12) );
  AO22_X0_12_LVT_NT U23 ( .A0(out[3]), .A1(n3), .B0(N21), .B1(n4), .Q(n13) );
  AO22_X2_12_LVT_NT U24 ( .A0(out[2]), .A1(n3), .B0(N20), .B1(n4), .Q(n14) );
  AO22_X0_12_LVT_NT U25 ( .A0(out[1]), .A1(n3), .B0(N19), .B1(n4), .Q(n15) );
  AO22_X2_12_LVT_NT U26 ( .A0(out[0]), .A1(n3), .B0(N18), .B1(n4), .Q(n16) );
  INV_A_NOR2_X2_12_LVT_NT U27 ( .AN(ramp_enb), .B(delta), .Q(n3) );
  INV_A_NOR2_X2_12_LVT_NT U28 ( .AN(ramp_enb), .B(n3), .Q(n4) );
  CLKXOR2_X2_12_LVT_NT U29 ( .A(out[11]), .B(\add_70/carry[11] ), .Q(N29) );
  CLKXOR2_X2_12_LVT_NT U30 ( .A(out[7]), .B(\add_70/carry[7] ), .Q(N25) );
  CLKXOR2_X2_12_LVT_NT U31 ( .A(out[6]), .B(\add_70/carry[6] ), .Q(N24) );
  CLKXOR2_X2_12_LVT_NT U32 ( .A(deltaY_0), .B(out[0]), .Q(N18) );
endmodule


module Control ( clk, rst_n, f_sync, sync, endLine, endFrame, X, Mode, b12_enb, 
        b5_enb, ramp_enb, cnt_enb, test, newLine, BinaryOrGray, delta, Xmode, 
        ValSel );
  input [1:0] X;
  input [2:0] Mode;
  output [1:0] Xmode;
  output [1:0] ValSel;
  input clk, rst_n, f_sync, sync, endLine, endFrame;
  output b12_enb, b5_enb, ramp_enb, cnt_enb, test, newLine, BinaryOrGray,
         delta;
  wire   \flag2x2[0] , keepCount, N127, N179, N181, N183, N184, N185, N186,
         N187, N188, N190, N191, N192, N193, N194, N195, N197, N198, N199,
         N200, N219, n1, n2, n3, n4, n5, n6, n12, n13, n27, n28, n29, n30, n31,
         n32, n33, n34, n36, n37, n38, n39, n40, n41, n43, n44, n45, n46, n47,
         n48, n49, n50, n51, n52, n53, n55, n57, n59, n60, n61, n62, n63, n7,
         n8, n9, n10, n11, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25,
         n26, n35, n42, n54, n56, n58, n64, n65, n66, n67, n68, n69, n70, n71,
         n72, n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85,
         n86, n87, n88, n89, n90, n91, n92, n93, n94, n95, n96, n97, n98, n99,
         n100, n101, n102, n103, n104, n105, n106, n107, n108, n109, n110,
         n111;
  wire   [2:0] STATE;
  wire   [1:0] flag;
  wire   [2:0] NEXT_STATE;

  TLAT_X1_12_LVT_NT keepCount_reg ( .G(n98), .D(newLine), .Q(keepCount) );
  TLAT_X1_12_LVT_NT \flag_reg[0]  ( .G(N197), .D(N198), .Q(flag[0]), .QN(n13)
         );
  TLAT_X1_12_LVT_NT BinaryOrGray_reg ( .G(N187), .D(N188), .Q(BinaryOrGray) );
  TLAT_X1_12_LVT_NT test_reg ( .G(N185), .D(N186), .Q(test) );
  TLAT_X1_12_LVT_NT \ValSel_reg[0]  ( .G(N194), .D(N195), .Q(ValSel[0]) );
  TLAT_X1_12_LVT_NT ramp_enb_reg ( .G(N183), .D(N184), .Q(ramp_enb) );
  TLATN_X1_12_LVT_NT delta_reg ( .D(N190), .GN(n61), .Q(delta) );
  TLAT_X1_12_LVT_NT \Xmode_reg[0]  ( .G(N191), .D(N192), .Q(Xmode[0]) );
  TLAT_X1_12_LVT_NT \Xmode_reg[1]  ( .G(N191), .D(N193), .Q(Xmode[1]) );
  XNOR2_X2_12_LVT_NT U33 ( .A(flag[1]), .B(flag[0]), .Q(n47) );
  NOR2_X4_12_LVT_NT U45 ( .A(Mode[0]), .B(Mode[2]), .Q(n34) );
  INV_A_NOR2_X4_12_LVT_NT U58 ( .AN(n44), .B(n45), .Q(n46) );
  NOR2_X4_12_LVT_NT U59 ( .A(n100), .B(STATE[1]), .Q(n45) );
  INV_A_NAND2_X4_12_LVT_NT U71 ( .AN(endLine), .B(keepCount), .Q(N179) );
  DFFRQ_X2_12_LVT_NT \flag2x2_reg[0]  ( .D(N219), .CK(clk), .RN(rst_n), .Q(
        \flag2x2[0] ) );
  OAI22_X4_12_LVT_NT U3 ( .A0(N179), .A1(n101), .B0(N179), .B1(STATE[0]), .Q(
        n5) );
  OAI211_X4_12_LVT_NT U6 ( .A0(n101), .A1(N127), .B0(n102), .C0(n104), .Q(n3)
         );
  OAI211_X4_12_LVT_NT U9 ( .A0(n104), .A1(n4), .B0(n3), .C0(n6), .Q(N194) );
  DFFRQ_X4_12_LVT_NT \STATE_reg[1]  ( .D(NEXT_STATE[1]), .CK(clk), .RN(rst_n), 
        .Q(STATE[1]) );
  DFFRQ_X4_12_LVT_NT \STATE_reg[2]  ( .D(NEXT_STATE[2]), .CK(clk), .RN(rst_n), 
        .Q(STATE[2]) );
  TLAT_X4_12_LVT_NT b5_enb_reg ( .G(N181), .D(newLine), .Q(b5_enb) );
  DFFRQ_X4_12_LVT_NT \STATE_reg[0]  ( .D(n7), .CK(clk), .RN(rst_n), .Q(
        STATE[0]) );
  TLAT_X2_12_LVT_NT \ValSel_reg[1]  ( .G(N194), .D(n26), .Q(ValSel[1]) );
  TLAT_X2_12_LVT_NT \flag_reg[1]  ( .G(N199), .D(N200), .Q(flag[1]), .QN(n12)
         );
  NOR2_X2_12_LVT_NT U4 ( .A(n102), .B(n101), .Q(n62) );
  OR2_X2_12_LVT_NT U5 ( .A(n37), .B(n68), .Q(n7) );
  AND2_X2_12_LVT_NT U7 ( .A(n91), .B(n101), .Q(n8) );
  AND2_X2_12_LVT_NT U8 ( .A(n17), .B(n24), .Q(n9) );
  AND2_X2_12_LVT_NT U10 ( .A(n77), .B(n19), .Q(n10) );
  AND2_X2_12_LVT_NT U11 ( .A(n72), .B(n22), .Q(n11) );
  OR2_X4_12_LVT_NT U12 ( .A(n93), .B(n94), .Q(b12_enb) );
  OR2_X4_12_LVT_NT U13 ( .A(n97), .B(b12_enb), .Q(cnt_enb) );
  AND2_X2_12_LVT_NT U14 ( .A(STATE[0]), .B(n102), .Q(n16) );
  OA22_X2_12_LVT_NT U15 ( .A0(n41), .A1(n12), .B0(flag[1]), .B1(n59), .Q(n17)
         );
  AND2_X2_12_LVT_NT U16 ( .A(n74), .B(n53), .Q(n18) );
  AND2_X2_12_LVT_NT U17 ( .A(n75), .B(n76), .Q(n19) );
  AND2_X2_12_LVT_NT U18 ( .A(n95), .B(n96), .Q(n20) );
  AND2_X2_12_LVT_NT U19 ( .A(n101), .B(n103), .Q(n21) );
  AND2_X2_12_LVT_NT U20 ( .A(n70), .B(n71), .Q(n22) );
  INV_X4_12_LVT_NT U21 ( .A(STATE[2]), .Q(n102) );
  INV_X4_12_LVT_NT U22 ( .A(STATE[1]), .Q(n104) );
  OR2_X2_12_LVT_NT U23 ( .A(n101), .B(STATE[1]), .Q(n23) );
  INV_X2_12_LVT_NT U24 ( .A(n90), .Q(n30) );
  AND2_X2_12_LVT_NT U25 ( .A(n88), .B(n89), .Q(n24) );
  OR2_X2_12_LVT_NT U26 ( .A(n30), .B(n45), .Q(n25) );
  OR2_X2_12_LVT_NT U27 ( .A(n85), .B(n86), .Q(n26) );
  OAI22_X4_12_LVT_NT U28 ( .A0(N179), .A1(n101), .B0(N179), .B1(STATE[0]), .Q(
        n2) );
  NOR2_X2_12_LVT_NT U29 ( .A(n20), .B(n104), .Q(n93) );
  INV_X0_12_LVT_NT U30 ( .A(n35), .Q(NEXT_STATE[2]) );
  NOR2_X0_12_LVT_NT U31 ( .A(n99), .B(n108), .Q(n42) );
  NOR2_X0_12_LVT_NT U32 ( .A(n28), .B(n29), .Q(n54) );
  NOR2_X0_12_LVT_NT U34 ( .A(n27), .B(n111), .Q(n56) );
  NOR2_X0_12_LVT_NT U35 ( .A(n56), .B(n58), .Q(n35) );
  NOR2_X0_12_LVT_NT U36 ( .A(n42), .B(n54), .Q(n64) );
  INV_X0_12_LVT_NT U37 ( .A(n64), .Q(n58) );
  INV_X2_12_LVT_NT U38 ( .A(Mode[0]), .Q(n111) );
  BUF_X2_12_LVT_NT U39 ( .A(n48), .Q(n65) );
  AOI32_X2_12_LVT_NT U40 ( .A0(n101), .A1(n102), .A2(n104), .B0(STATE[1]), 
        .B1(n62), .Q(n48) );
  NOR2_X0_12_LVT_NT U41 ( .A(n29), .B(n36), .Q(n66) );
  NOR2_X0_12_LVT_NT U42 ( .A(n11), .B(n105), .Q(n67) );
  NOR2_X0_12_LVT_NT U43 ( .A(n66), .B(n67), .Q(n69) );
  INV_X0_12_LVT_NT U44 ( .A(n69), .Q(n68) );
  NAND2_X0_12_LVT_NT U46 ( .A(STATE[2]), .B(n104), .Q(n70) );
  NAND2_X0_12_LVT_NT U47 ( .A(STATE[1]), .B(n100), .Q(n71) );
  NAND2_X0_12_LVT_NT U48 ( .A(f_sync), .B(n101), .Q(n72) );
  AO22_X2_12_LVT_NT U49 ( .A0(n38), .A1(n39), .B0(newLine), .B1(n40), .Q(n37)
         );
  NAND3_X1_12_LVT_NT U50 ( .A(STATE[0]), .B(n102), .C(STATE[1]), .Q(n36) );
  NAND2_X0_12_LVT_NT U51 ( .A(n73), .B(n65), .Q(N199) );
  INV_X0_12_LVT_NT U52 ( .A(n46), .Q(n74) );
  NAND2_X0_12_LVT_NT U53 ( .A(sync), .B(n18), .Q(n73) );
  NAND2_X0_12_LVT_NT U54 ( .A(n108), .B(n13), .Q(n75) );
  NAND2_X0_12_LVT_NT U55 ( .A(n111), .B(n12), .Q(n76) );
  INV_X0_12_LVT_NT U56 ( .A(n34), .Q(n77) );
  INV_X0_12_LVT_NT U57 ( .A(n78), .Q(n40) );
  NOR2_X0_12_LVT_NT U60 ( .A(n106), .B(n13), .Q(n79) );
  NOR2_X0_12_LVT_NT U61 ( .A(n10), .B(n110), .Q(n80) );
  NOR2_X0_12_LVT_NT U62 ( .A(n41), .B(n12), .Q(n81) );
  NOR2_X0_12_LVT_NT U63 ( .A(n81), .B(n82), .Q(n78) );
  NOR2_X0_12_LVT_NT U64 ( .A(n79), .B(n80), .Q(n83) );
  INV_X0_12_LVT_NT U65 ( .A(n83), .Q(n82) );
  NAND3_X2_12_LVT_NT U66 ( .A(Mode[0]), .B(n110), .C(Mode[2]), .Q(n41) );
  INV_X4_12_LVT_NT U67 ( .A(Mode[1]), .Q(n110) );
  NOR2_X2_12_LVT_NT U68 ( .A(STATE[2]), .B(n23), .Q(n97) );
  INV_X6_12_LVT_NT U69 ( .A(STATE[0]), .Q(n101) );
  NOR2_X0_12_LVT_NT U70 ( .A(n9), .B(n99), .Q(n84) );
  INV_X0_12_LVT_NT U72 ( .A(n55), .Q(n85) );
  NOR2_X0_12_LVT_NT U73 ( .A(n84), .B(n25), .Q(n87) );
  INV_X0_12_LVT_NT U74 ( .A(n87), .Q(n86) );
  NAND2_X0_12_LVT_NT U75 ( .A(n43), .B(n13), .Q(n88) );
  NAND2_X0_12_LVT_NT U76 ( .A(n57), .B(flag[0]), .Q(n89) );
  INV_X2_12_LVT_NT U77 ( .A(newLine), .Q(n99) );
  NAND3_X2_12_LVT_NT U78 ( .A(n101), .B(n102), .C(STATE[1]), .Q(n55) );
  NOR3_X6_12_LVT_NT U79 ( .A(n110), .B(Mode[2]), .C(n111), .Q(n57) );
  INV_X0_12_LVT_NT U80 ( .A(n104), .Q(n91) );
  NAND2_X2_12_LVT_NT U81 ( .A(STATE[2]), .B(n8), .Q(n90) );
  INV_X2_12_LVT_NT U82 ( .A(n92), .Q(newLine) );
  NAND2_X0_12_LVT_NT U83 ( .A(n104), .B(n16), .Q(n92) );
  NOR2_X3_12_LVT_NT U84 ( .A(n57), .B(n43), .Q(n51) );
  NOR3_X8_12_LVT_NT U85 ( .A(Mode[0]), .B(Mode[1]), .C(n108), .Q(n43) );
  INV_X0_12_LVT_NT U86 ( .A(n6), .Q(n94) );
  NAND2_X0_12_LVT_NT U87 ( .A(STATE[2]), .B(n21), .Q(n95) );
  NAND2_X0_12_LVT_NT U88 ( .A(n5), .B(n102), .Q(n96) );
  INV_X0_12_LVT_NT U89 ( .A(b12_enb), .Q(n98) );
  NAND2_X0_12_LVT_NT U90 ( .A(n65), .B(n99), .Q(N181) );
  OAI211_X2_12_LVT_NT U91 ( .A0(n31), .A1(n27), .B0(n32), .C0(n33), .Q(
        NEXT_STATE[1]) );
  AOI12_X1_12_LVT_NT U92 ( .B0(Mode[2]), .B1(Mode[0]), .A0(n34), .Q(n31) );
  INV_X2_12_LVT_NT U93 ( .A(sync), .Q(n105) );
  NAND2_X1_12_LVT_NT U94 ( .A(endLine), .B(endFrame), .Q(n39) );
  INV_X2_12_LVT_NT U95 ( .A(n53), .Q(n109) );
  INV_X2_12_LVT_NT U96 ( .A(n62), .Q(n100) );
  INV_X2_12_LVT_NT U97 ( .A(n51), .Q(n107) );
  NAND2_X2_12_LVT_NT U98 ( .A(n99), .B(n90), .Q(N184) );
  OR2_X2_12_LVT_NT U99 ( .A(N186), .B(N187), .Q(N185) );
  NAND2_X2_12_LVT_NT U100 ( .A(n41), .B(n59), .Q(n53) );
  NAND2_X2_12_LVT_NT U101 ( .A(n39), .B(n105), .Q(n29) );
  AOI21_X2_12_LVT_NT U102 ( .A0(n5), .A1(n102), .B0(n1), .Q(n4) );
  AOI21_X2_12_LVT_NT U103 ( .A0(N179), .A1(n101), .B0(n102), .Q(n1) );
  NOR2_X2_12_LVT_NT U104 ( .A(n30), .B(N181), .Q(n61) );
  OAI21_X2_12_LVT_NT U105 ( .A0(N179), .A1(n60), .B0(n61), .Q(N191) );
  INV_A_OAI211_X1_12_LVT_NT U106 ( .A1N(n34), .A0(n27), .B0(n90), .C0(n60), 
        .Q(N195) );
  NAND3_X1_12_LVT_NT U107 ( .A(n55), .B(n33), .C(n65), .Q(N187) );
  NAND3_X1_12_LVT_NT U108 ( .A(n36), .B(n90), .C(n46), .Q(N186) );
  NAND3_X0_12_LVT_NT U109 ( .A(n63), .B(n90), .C(n65), .Q(N183) );
  OR3_X2_12_LVT_NT U110 ( .A(n27), .B(n111), .C(n108), .Q(n63) );
  NOR2_X0_12_LVT_NT U111 ( .A(n105), .B(n90), .Q(N190) );
  NAND3_X2_12_LVT_NT U112 ( .A(n109), .B(n110), .C(n51), .Q(N127) );
  AND2_X2_12_LVT_NT U113 ( .A(n55), .B(n36), .Q(n60) );
  NAND2_X0_12_LVT_NT U114 ( .A(n99), .B(n55), .Q(N188) );
  INV_X0_12_LVT_NT U115 ( .A(n43), .Q(n106) );
  NAND2_A_OAI21_X2_12_LVT_NT U116 ( .B0(\flag2x2[0] ), .B1(n44), .A0N(n45), 
        .A1N(\flag2x2[0] ), .Q(n38) );
  INV_X4_12_LVT_NT U117 ( .A(Mode[2]), .Q(n108) );
  NOR2_X2_12_LVT_NT U118 ( .A(\flag2x2[0] ), .B(n109), .Q(N219) );
  NAND3_X2_12_LVT_NT U119 ( .A(Mode[1]), .B(n111), .C(Mode[2]), .Q(n59) );
  INV_A_NAND3_X0_12_LVT_NT U120 ( .AN(n29), .B(STATE[1]), .C(n100), .Q(n32) );
  AOI12_X1_12_LVT_NT U121 ( .B0(STATE[2]), .B1(n104), .A0(n30), .Q(n28) );
  NAND4_X2_12_LVT_NT U122 ( .A(Mode[0]), .B(newLine), .C(n110), .D(n108), .Q(
        n33) );
  NAND2_X2_12_LVT_NT U123 ( .A(Mode[1]), .B(newLine), .Q(n27) );
  INV_X0_12_LVT_NT U124 ( .A(N179), .Q(n103) );
  NAND3_X2_12_LVT_NT U125 ( .A(n2), .B(n104), .C(STATE[2]), .Q(n6) );
  NAND3_X2_12_LVT_NT U126 ( .A(n101), .B(n104), .C(STATE[2]), .Q(n44) );
  OAI12_X1_12_LVT_NT U127 ( .B0(n46), .B1(n52), .A0(n65), .Q(N197) );
  AOI21_X2_12_LVT_NT U128 ( .A0(sync), .A1(n53), .B0(n107), .Q(n52) );
  NOR2_X0_12_LVT_NT U129 ( .A(n46), .B(n49), .Q(N198) );
  AOI32_X2_12_LVT_NT U130 ( .A0(n107), .A1(n105), .A2(flag[0]), .B0(n50), .B1(
        n13), .Q(n49) );
  OAI21_X2_12_LVT_NT U131 ( .A0(n51), .A1(n105), .B0(n109), .Q(n50) );
  NOR2_X0_12_LVT_NT U132 ( .A(n46), .B(n47), .Q(N200) );
  NAND2_A_NAND2_X0_12_LVT_NT U133 ( .A0N(X[0]), .A1N(n30), .B0(n55), .Q(N192)
         );
  AND2_X0_12_LVT_NT U134 ( .A(X[1]), .B(n30), .Q(N193) );
endmodule


module Pattern_Generator ( clk, rst_n, f_sync, sync, constVal, X, Y, Mode, cnt
 );
  input [11:0] constVal;
  input [1:0] X;
  input [1:0] Y;
  input [2:0] Mode;
  output [11:0] cnt;
  input clk, rst_n, f_sync, sync;
  wire   BinaryOrGray, N8, N9, N10, N11, N12, N13, N14, N15, N16, N17, N18,
         N19, cnt_enb, b12_enb, test, endLine, b5_enb, newLine, endFrame,
         ramp_enb, delta, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24,
         n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38,
         n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49;
  wire   [1:0] ValSel;
  wire   [11:0] LoadVal;
  wire   [11:0] ramp_out;
  wire   [11:0] counter_out;
  wire   [11:0] gray_converter;
  wire   [1:0] Xmode;

  OAI211_X4_12_LVT_NT U15 ( .A0(n40), .A1(n37), .B0(n15), .C0(n16), .Q(
        LoadVal[9]) );
  AOI22_X4_12_LVT_NT U16 ( .A0(constVal[9]), .A1(n17), .B0(ramp_out[9]), .B1(
        n36), .Q(n16) );
  OAI211_X4_12_LVT_NT U17 ( .A0(n41), .A1(n37), .B0(n15), .C0(n18), .Q(
        LoadVal[8]) );
  AOI22_X4_12_LVT_NT U18 ( .A0(constVal[8]), .A1(n17), .B0(ramp_out[8]), .B1(
        n36), .Q(n18) );
  OAI211_X4_12_LVT_NT U19 ( .A0(n42), .A1(n37), .B0(n15), .C0(n19), .Q(
        LoadVal[7]) );
  AOI22_X4_12_LVT_NT U20 ( .A0(constVal[7]), .A1(n17), .B0(ramp_out[7]), .B1(
        n36), .Q(n19) );
  OAI211_X4_12_LVT_NT U21 ( .A0(n43), .A1(n37), .B0(n15), .C0(n20), .Q(
        LoadVal[6]) );
  AOI22_X4_12_LVT_NT U22 ( .A0(constVal[6]), .A1(n17), .B0(ramp_out[6]), .B1(
        n36), .Q(n20) );
  OAI211_X4_12_LVT_NT U23 ( .A0(n44), .A1(n37), .B0(n15), .C0(n21), .Q(
        LoadVal[5]) );
  AOI22_X4_12_LVT_NT U24 ( .A0(constVal[5]), .A1(n17), .B0(ramp_out[5]), .B1(
        n36), .Q(n21) );
  OAI211_X4_12_LVT_NT U25 ( .A0(n45), .A1(n37), .B0(n15), .C0(n22), .Q(
        LoadVal[4]) );
  AOI22_X4_12_LVT_NT U26 ( .A0(constVal[4]), .A1(n17), .B0(ramp_out[4]), .B1(
        n36), .Q(n22) );
  OAI211_X4_12_LVT_NT U31 ( .A0(n48), .A1(n37), .B0(n15), .C0(n25), .Q(
        LoadVal[1]) );
  AOI22_X4_12_LVT_NT U32 ( .A0(constVal[1]), .A1(n17), .B0(ramp_out[1]), .B1(
        n36), .Q(n25) );
  OAI211_X4_12_LVT_NT U35 ( .A0(n39), .A1(n37), .B0(n15), .C0(n27), .Q(
        LoadVal[10]) );
  AOI22_X4_12_LVT_NT U36 ( .A0(constVal[10]), .A1(n17), .B0(ramp_out[10]), 
        .B1(n36), .Q(n27) );
  OAI211_X4_12_LVT_NT U37 ( .A0(n49), .A1(n37), .B0(n15), .C0(n28), .Q(
        LoadVal[0]) );
  AOI22_X4_12_LVT_NT U38 ( .A0(constVal[0]), .A1(n17), .B0(ramp_out[0]), .B1(
        n36), .Q(n28) );
  DFFRQ_X2_12_LVT_NT \cnt_reg[11]  ( .D(N19), .CK(clk), .RN(rst_n), .Q(cnt[11]) );
  DFFRQ_X2_12_LVT_NT \cnt_reg[10]  ( .D(N18), .CK(clk), .RN(rst_n), .Q(cnt[10]) );
  DFFRQ_X2_12_LVT_NT \cnt_reg[9]  ( .D(N17), .CK(clk), .RN(rst_n), .Q(cnt[9])
         );
  DFFRQ_X2_12_LVT_NT \cnt_reg[8]  ( .D(N16), .CK(clk), .RN(rst_n), .Q(cnt[8])
         );
  DFFRQ_X2_12_LVT_NT \cnt_reg[7]  ( .D(N15), .CK(clk), .RN(rst_n), .Q(cnt[7])
         );
  DFFRQ_X2_12_LVT_NT \cnt_reg[6]  ( .D(N14), .CK(clk), .RN(rst_n), .Q(cnt[6])
         );
  DFFRQ_X2_12_LVT_NT \cnt_reg[5]  ( .D(N13), .CK(clk), .RN(rst_n), .Q(cnt[5])
         );
  DFFRQ_X2_12_LVT_NT \cnt_reg[4]  ( .D(N12), .CK(clk), .RN(rst_n), .Q(cnt[4])
         );
  DFFRQ_X2_12_LVT_NT \cnt_reg[3]  ( .D(N11), .CK(clk), .RN(rst_n), .Q(cnt[3])
         );
  DFFRQ_X2_12_LVT_NT \cnt_reg[2]  ( .D(N10), .CK(clk), .RN(rst_n), .Q(cnt[2])
         );
  DFFRQ_X2_12_LVT_NT \cnt_reg[1]  ( .D(N9), .CK(clk), .RN(rst_n), .Q(cnt[1])
         );
  DFFRQ_X2_12_LVT_NT \cnt_reg[0]  ( .D(N8), .CK(clk), .RN(rst_n), .Q(cnt[0])
         );
  Binary2Gray B2G ( .in(counter_out), .out(gray_converter) );
  Counter counter ( .clk(clk), .rst_n(rst_n), .cnt_enb(cnt_enb), .Xmode(Xmode), 
        .LoadVal({n31, LoadVal[10:3], n32, LoadVal[1:0]}), .out(counter_out)
         );
  Counter12Bit cnt12b ( .clk(clk), .rst_n(rst_n), .b12_enb(b12_enb), .test(
        test), .endLine(endLine) );
  Counter5Bit cnt5b ( .clk(clk), .rst_n(rst_n), .b5_enb(b5_enb), .newLine(
        newLine), .endFrame(endFrame) );
  Ramp ramp ( .clk(clk), .rst_n(rst_n), .ramp_enb(ramp_enb), .delta(delta), 
        .Y(Y), .out(ramp_out) );
  Control control ( .clk(clk), .rst_n(rst_n), .f_sync(f_sync), .sync(sync), 
        .endLine(endLine), .endFrame(endFrame), .X(X), .Mode(Mode), .b12_enb(
        b12_enb), .b5_enb(b5_enb), .ramp_enb(ramp_enb), .cnt_enb(cnt_enb), 
        .test(test), .newLine(newLine), .BinaryOrGray(BinaryOrGray), .delta(
        delta), .Xmode(Xmode), .ValSel(ValSel) );
  OAI211_X2_12_LVT_NT U55 ( .A0(n47), .A1(n37), .B0(n15), .C0(n24), .Q(
        LoadVal[2]) );
  AOI22_X2_12_LVT_NT U56 ( .A0(constVal[2]), .A1(n17), .B0(ramp_out[2]), .B1(
        n36), .Q(n24) );
  AOI22_X2_12_LVT_NT U57 ( .A0(constVal[11]), .A1(n17), .B0(ramp_out[11]), 
        .B1(n36), .Q(n26) );
  AND2_X2_12_LVT_NT U58 ( .A(n23), .B(n30), .Q(n29) );
  NAND2_X2_12_LVT_NT U59 ( .A(n15), .B(n29), .Q(LoadVal[3]) );
  NAND2_X0_12_LVT_NT U60 ( .A(ValSel[1]), .B(counter_out[3]), .Q(n30) );
  AOI22_X2_12_LVT_NT U61 ( .A0(constVal[3]), .A1(n17), .B0(ramp_out[3]), .B1(
        n36), .Q(n23) );
  BUF_X2_12_LVT_NT U62 ( .A(LoadVal[11]), .Q(n31) );
  BUF_X2_12_LVT_NT U63 ( .A(LoadVal[2]), .Q(n32) );
  OAI211_X2_12_LVT_NT U64 ( .A0(n38), .A1(n37), .B0(n15), .C0(n26), .Q(
        LoadVal[11]) );
  BUF_X2_12_LVT_NT U65 ( .A(n35), .Q(n33) );
  BUF_X2_12_LVT_NT U66 ( .A(n35), .Q(n34) );
  INV_X2_12_LVT_NT U67 ( .A(counter_out[0]), .Q(n49) );
  INV_X2_12_LVT_NT U68 ( .A(counter_out[1]), .Q(n48) );
  INV_X2_12_LVT_NT U69 ( .A(counter_out[2]), .Q(n47) );
  INV_X2_12_LVT_NT U70 ( .A(counter_out[3]), .Q(n46) );
  INV_X2_12_LVT_NT U71 ( .A(counter_out[4]), .Q(n45) );
  INV_X2_12_LVT_NT U72 ( .A(counter_out[5]), .Q(n44) );
  INV_X2_12_LVT_NT U73 ( .A(counter_out[6]), .Q(n43) );
  INV_X2_12_LVT_NT U74 ( .A(counter_out[7]), .Q(n42) );
  INV_X2_12_LVT_NT U75 ( .A(counter_out[8]), .Q(n41) );
  INV_X2_12_LVT_NT U76 ( .A(counter_out[9]), .Q(n40) );
  INV_X2_12_LVT_NT U77 ( .A(counter_out[10]), .Q(n39) );
  INV_X2_12_LVT_NT U78 ( .A(counter_out[11]), .Q(n38) );
  NAND2_A_OAI21_X2_12_LVT_NT U79 ( .B0(n33), .B1(n40), .A0N(gray_converter[9]), 
        .A1N(n34), .Q(N17) );
  NAND2_A_OAI21_X2_12_LVT_NT U80 ( .B0(n33), .B1(n39), .A0N(gray_converter[10]), .A1N(n34), .Q(N18) );
  NAND2_A_OAI21_X2_12_LVT_NT U81 ( .B0(n33), .B1(n48), .A0N(gray_converter[1]), 
        .A1N(n34), .Q(N9) );
  NAND2_A_OAI21_X2_12_LVT_NT U82 ( .B0(n33), .B1(n47), .A0N(gray_converter[2]), 
        .A1N(n34), .Q(N10) );
  NAND2_A_OAI21_X2_12_LVT_NT U83 ( .B0(n33), .B1(n46), .A0N(gray_converter[3]), 
        .A1N(n33), .Q(N11) );
  NAND2_A_OAI21_X2_12_LVT_NT U84 ( .B0(n33), .B1(n45), .A0N(gray_converter[4]), 
        .A1N(n34), .Q(N12) );
  NAND2_A_OAI21_X2_12_LVT_NT U85 ( .B0(n33), .B1(n44), .A0N(gray_converter[5]), 
        .A1N(n34), .Q(N13) );
  NAND2_A_OAI21_X2_12_LVT_NT U86 ( .B0(n33), .B1(n43), .A0N(gray_converter[6]), 
        .A1N(n34), .Q(N14) );
  NAND2_A_OAI21_X2_12_LVT_NT U87 ( .B0(n33), .B1(n42), .A0N(gray_converter[7]), 
        .A1N(n34), .Q(N15) );
  NAND2_A_OAI21_X2_12_LVT_NT U88 ( .B0(n33), .B1(n41), .A0N(gray_converter[8]), 
        .A1N(n34), .Q(N16) );
  NAND2_A_OAI21_X2_12_LVT_NT U89 ( .B0(n33), .B1(n49), .A0N(gray_converter[0]), 
        .A1N(n34), .Q(N8) );
  NAND2_A_OAI21_X2_12_LVT_NT U90 ( .B0(n33), .B1(n38), .A0N(gray_converter[11]), .A1N(n34), .Q(N19) );
  NAND2_X4_12_LVT_NT U91 ( .A(ValSel[1]), .B(n36), .Q(n15) );
  INV_X4_12_LVT_NT U92 ( .A(ValSel[0]), .Q(n36) );
  BUF_X2_12_LVT_NT U93 ( .A(BinaryOrGray), .Q(n35) );
  INV_X6_12_LVT_NT U94 ( .A(ValSel[1]), .Q(n37) );
  NOR2_X12_12_LVT_NT U95 ( .A(n36), .B(ValSel[1]), .Q(n17) );
endmodule

