/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : U-2022.12
// Date      : Mon Oct 21 11:30:27 2024
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
  AND2_X2_12_LVT_NT U3 ( .A(cnt_enb), .B(N28), .Q(N40) );
  AND2_X2_12_LVT_NT U4 ( .A(N27), .B(cnt_enb), .Q(N39) );
  AND2_X2_12_LVT_NT U5 ( .A(N26), .B(cnt_enb), .Q(N38) );
  AND2_X2_12_LVT_NT U6 ( .A(N25), .B(cnt_enb), .Q(N37) );
  AND2_X2_12_LVT_NT U7 ( .A(N24), .B(cnt_enb), .Q(N36) );
  AND2_X2_12_LVT_NT U8 ( .A(N23), .B(cnt_enb), .Q(N35) );
  AND2_X2_12_LVT_NT U9 ( .A(N22), .B(cnt_enb), .Q(N34) );
  AND2_X2_12_LVT_NT U10 ( .A(N17), .B(cnt_enb), .Q(N29) );
  AND2_X2_12_LVT_NT U11 ( .A(N18), .B(cnt_enb), .Q(N30) );
  AND2_X2_12_LVT_NT U12 ( .A(N19), .B(cnt_enb), .Q(N31) );
  AND2_X2_12_LVT_NT U13 ( .A(N20), .B(cnt_enb), .Q(N32) );
  AND2_X2_12_LVT_NT U14 ( .A(N21), .B(cnt_enb), .Q(N33) );
  NOR2_X2_12_LVT_NT U15 ( .A(n1), .B(n2), .Q(deltaX[3]) );
  NOR2_X2_12_LVT_NT U16 ( .A(Xmode[0]), .B(n2), .Q(deltaX[2]) );
  NOR2_X2_12_LVT_NT U17 ( .A(Xmode[1]), .B(n1), .Q(deltaX_0) );
  INV_X2_12_LVT_NT U18 ( .A(Xmode[1]), .Q(n2) );
  INV_X2_12_LVT_NT U19 ( .A(Xmode[0]), .Q(n1) );
  CLKXOR2_X2_12_LVT_NT U20 ( .A(LoadVal[11]), .B(\add_60/carry[11] ), .Q(N28)
         );
  AND2_X0_12_LVT_NT U21 ( .A(\add_60/carry[10] ), .B(LoadVal[10]), .Q(
        \add_60/carry[11] ) );
  CLKXOR2_X2_12_LVT_NT U22 ( .A(LoadVal[10]), .B(\add_60/carry[10] ), .Q(N27)
         );
  AND2_X0_12_LVT_NT U23 ( .A(\add_60/carry[9] ), .B(LoadVal[9]), .Q(
        \add_60/carry[10] ) );
  CLKXOR2_X2_12_LVT_NT U24 ( .A(LoadVal[9]), .B(\add_60/carry[9] ), .Q(N26) );
  AND2_X0_12_LVT_NT U25 ( .A(\add_60/carry[8] ), .B(LoadVal[8]), .Q(
        \add_60/carry[9] ) );
  CLKXOR2_X2_12_LVT_NT U26 ( .A(LoadVal[8]), .B(\add_60/carry[8] ), .Q(N25) );
  AND2_X0_12_LVT_NT U27 ( .A(\add_60/carry[7] ), .B(LoadVal[7]), .Q(
        \add_60/carry[8] ) );
  CLKXOR2_X2_12_LVT_NT U28 ( .A(LoadVal[7]), .B(\add_60/carry[7] ), .Q(N24) );
  AND2_X0_12_LVT_NT U29 ( .A(\add_60/carry[6] ), .B(LoadVal[6]), .Q(
        \add_60/carry[7] ) );
  CLKXOR2_X2_12_LVT_NT U30 ( .A(LoadVal[6]), .B(\add_60/carry[6] ), .Q(N23) );
  AND2_X0_12_LVT_NT U31 ( .A(\add_60/carry[5] ), .B(LoadVal[5]), .Q(
        \add_60/carry[6] ) );
  CLKXOR2_X2_12_LVT_NT U32 ( .A(LoadVal[5]), .B(\add_60/carry[5] ), .Q(N22) );
  AND2_X0_12_LVT_NT U33 ( .A(\add_60/carry[4] ), .B(LoadVal[4]), .Q(
        \add_60/carry[5] ) );
  CLKXOR2_X2_12_LVT_NT U34 ( .A(LoadVal[4]), .B(\add_60/carry[4] ), .Q(N21) );
  AND2_X0_12_LVT_NT U35 ( .A(\add_60/carry[1] ), .B(LoadVal[1]), .Q(
        \add_60/carry[2] ) );
  CLKXOR2_X2_12_LVT_NT U36 ( .A(LoadVal[1]), .B(\add_60/carry[1] ), .Q(N18) );
  AND2_X0_12_LVT_NT U37 ( .A(LoadVal[0]), .B(deltaX_0), .Q(\add_60/carry[1] )
         );
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
  HA1_X2_12_LVT_NT U1_1_1 ( .A(A[1]), .B(A[0]), .CO(carry[2]), .S(SUM[1]) );
  INV_X2_12_LVT_NT U1 ( .A(A[0]), .Q(SUM[0]) );
  CLKXOR2_X2_12_LVT_NT U2 ( .A(carry[11]), .B(A[11]), .Q(SUM[11]) );
endmodule


module Counter12Bit ( clk, rst_n, b12_enb, test, endLine );
  input clk, rst_n, b12_enb, test;
  output endLine;
  wire   N10, N11, N12, N13, N14, N15, N16, N17, N18, N19, N20, N21, N22, N23,
         N24, N25, N26, N27, N28, N29, N30, N31, N32, N33, n1, n2, n3, n4, n5,
         n6, n7, n8;
  wire   [11:0] count;

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
  AND2_X2_12_LVT_NT U3 ( .A(N20), .B(b12_enb), .Q(N32) );
  AND2_X2_12_LVT_NT U4 ( .A(N19), .B(b12_enb), .Q(N31) );
  AND2_X2_12_LVT_NT U5 ( .A(N18), .B(b12_enb), .Q(N30) );
  AND2_X2_12_LVT_NT U6 ( .A(N17), .B(b12_enb), .Q(N29) );
  AND2_X2_12_LVT_NT U7 ( .A(N16), .B(b12_enb), .Q(N28) );
  AND2_X2_12_LVT_NT U8 ( .A(N15), .B(b12_enb), .Q(N27) );
  AND2_X2_12_LVT_NT U9 ( .A(N14), .B(b12_enb), .Q(N26) );
  AND2_X2_12_LVT_NT U10 ( .A(N13), .B(b12_enb), .Q(N25) );
  AND2_X2_12_LVT_NT U11 ( .A(N12), .B(b12_enb), .Q(N24) );
  AND2_X2_12_LVT_NT U12 ( .A(N11), .B(b12_enb), .Q(N23) );
  INV_A_NOR4_X2_12_LVT_NT U13 ( .AN(n7), .B(n8), .C(count[5]), .D(count[4]), 
        .Q(n3) );
  OR3_X2_12_LVT_NT U14 ( .A(count[7]), .B(count[9]), .C(count[6]), .Q(n8) );
  INV_A_NOR4_X2_12_LVT_NT U15 ( .AN(test), .B(count[1]), .C(count[11]), .D(
        count[2]), .Q(n7) );
  NOR2_X2_12_LVT_NT U16 ( .A(n1), .B(n2), .Q(endLine) );
  NAND2_X2_12_LVT_NT U17 ( .A(count[8]), .B(count[3]), .Q(n2) );
  OAI211_X2_12_LVT_NT U18 ( .A0(n3), .A1(n4), .B0(count[0]), .C0(count[10]), 
        .Q(n1) );
  NAND2_A_NOR3_X2_12_LVT_NT U19 ( .AN(count[2]), .BN(count[4]), .C(n5), .D(n6), 
        .Q(n4) );
  NAND4_X2_12_LVT_NT U20 ( .A(count[9]), .B(count[7]), .C(count[6]), .D(
        count[5]), .Q(n5) );
  INV_A_NAND3_X2_12_LVT_NT U21 ( .AN(test), .B(count[11]), .C(count[1]), .Q(n6) );
  AND2_X2_12_LVT_NT U22 ( .A(N10), .B(b12_enb), .Q(N22) );
  AND2_X2_12_LVT_NT U23 ( .A(b12_enb), .B(N21), .Q(N33) );
endmodule


module Counter5Bit ( clk, rst_n, b5_enb, newLine, endFrame );
  input clk, rst_n, b5_enb, newLine;
  output endFrame;
  wire   N7, N8, N9, N10, N11, n1, n2, n3, n4, n5, n6, n7, n8,
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
  INV_A_NAND2_X2_12_LVT_NT U3 ( .AN(newLine), .B(b5_enb), .Q(n2) );
  AND2_X2_12_LVT_NT U4 ( .A(b5_enb), .B(n2), .Q(n1) );
  INV_A_AO22_X2_12_LVT_NT U5 ( .B0(N11), .B1(n1), .A0(count[4]), .A1N(n2), .Q(
        n4) );
  INV_A_AO22_X2_12_LVT_NT U6 ( .B0(N10), .B1(n1), .A0(count[3]), .A1N(n2), .Q(
        n5) );
  INV_A_AO22_X2_12_LVT_NT U7 ( .B0(N9), .B1(n1), .A0(count[2]), .A1N(n2), .Q(
        n6) );
  INV_A_AO22_X2_12_LVT_NT U8 ( .B0(N8), .B1(n1), .A0(count[1]), .A1N(n2), .Q(
        n7) );
  INV_A_AO22_X2_12_LVT_NT U9 ( .B0(N7), .B1(n1), .A0(count[0]), .A1N(n2), .Q(
        n8) );
  INV_X2_12_LVT_NT U10 ( .A(count[0]), .Q(N7) );
  NOR4_X2_12_LVT_NT U11 ( .A(n3), .B(count[0]), .C(count[2]), .D(count[1]), 
        .Q(endFrame) );
  NAND2_X2_12_LVT_NT U12 ( .A(count[3]), .B(count[4]), .Q(n3) );
  HA1_X2_12_LVT_NT U13 ( .A(count[1]), .B(count[0]), .CO(\add_58/carry[2] ), 
        .S(N8) );
  HA1_X2_12_LVT_NT U14 ( .A(count[2]), .B(\add_58/carry[2] ), .CO(
        \add_58/carry[3] ), .S(N9) );
  HA1_X2_12_LVT_NT U15 ( .A(count[3]), .B(\add_58/carry[3] ), .CO(
        \add_58/carry[4] ), .S(N10) );
  CLKXOR2_X2_12_LVT_NT U16 ( .A(\add_58/carry[4] ), .B(count[4]), .Q(N11) );
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
  INV_A_NOR2_X2_12_LVT_NT U3 ( .AN(Y[1]), .B(Y[0]), .Q(\deltaY[4] ) );
  AO22_X2_12_LVT_NT U4 ( .A0(out[11]), .A1(n3), .B0(N29), .B1(n4), .Q(n5) );
  AO22_X2_12_LVT_NT U5 ( .A0(out[10]), .A1(n3), .B0(N28), .B1(n4), .Q(n6) );
  AO22_X2_12_LVT_NT U6 ( .A0(out[9]), .A1(n3), .B0(N27), .B1(n4), .Q(n7) );
  AO22_X2_12_LVT_NT U7 ( .A0(out[8]), .A1(n3), .B0(N26), .B1(n4), .Q(n8) );
  AO22_X2_12_LVT_NT U8 ( .A0(out[7]), .A1(n3), .B0(N25), .B1(n4), .Q(n9) );
  AO22_X2_12_LVT_NT U9 ( .A0(out[6]), .A1(n3), .B0(N24), .B1(n4), .Q(n10) );
  AO22_X2_12_LVT_NT U10 ( .A0(out[5]), .A1(n3), .B0(N23), .B1(n4), .Q(n11) );
  AO22_X2_12_LVT_NT U11 ( .A0(out[4]), .A1(n3), .B0(N22), .B1(n4), .Q(n12) );
  AO22_X2_12_LVT_NT U12 ( .A0(out[3]), .A1(n3), .B0(N21), .B1(n4), .Q(n13) );
  AO22_X2_12_LVT_NT U13 ( .A0(out[2]), .A1(n3), .B0(N20), .B1(n4), .Q(n14) );
  AO22_X2_12_LVT_NT U14 ( .A0(out[1]), .A1(n3), .B0(N19), .B1(n4), .Q(n15) );
  AO22_X2_12_LVT_NT U15 ( .A0(out[0]), .A1(n3), .B0(N18), .B1(n4), .Q(n16) );
  INV_A_NOR2_X2_12_LVT_NT U16 ( .AN(Y[0]), .B(deltaY_0), .Q(deltaY_8) );
  INV_A_NOR2_X2_12_LVT_NT U17 ( .AN(ramp_enb), .B(delta), .Q(n3) );
  INV_A_NOR2_X2_12_LVT_NT U18 ( .AN(ramp_enb), .B(n3), .Q(n4) );
  INV_A_NOR2_X2_12_LVT_NT U19 ( .AN(Y[0]), .B(Y[1]), .Q(deltaY_0) );
  CLKXOR2_X2_12_LVT_NT U20 ( .A(out[11]), .B(\add_70/carry[11] ), .Q(N29) );
  AND2_X0_12_LVT_NT U21 ( .A(\add_70/carry[9] ), .B(out[9]), .Q(
        \add_70/carry[10] ) );
  CLKXOR2_X2_12_LVT_NT U22 ( .A(out[9]), .B(\add_70/carry[9] ), .Q(N27) );
  AND2_X0_12_LVT_NT U23 ( .A(\add_70/carry[7] ), .B(out[7]), .Q(
        \add_70/carry[8] ) );
  CLKXOR2_X2_12_LVT_NT U24 ( .A(out[7]), .B(\add_70/carry[7] ), .Q(N25) );
  AND2_X0_12_LVT_NT U25 ( .A(\add_70/carry[6] ), .B(out[6]), .Q(
        \add_70/carry[7] ) );
  CLKXOR2_X2_12_LVT_NT U26 ( .A(out[6]), .B(\add_70/carry[6] ), .Q(N24) );
  AND2_X0_12_LVT_NT U27 ( .A(\add_70/carry[5] ), .B(out[5]), .Q(
        \add_70/carry[6] ) );
  CLKXOR2_X2_12_LVT_NT U28 ( .A(out[5]), .B(\add_70/carry[5] ), .Q(N23) );
  AND2_X0_12_LVT_NT U29 ( .A(\add_70/carry[2] ), .B(out[2]), .Q(
        \add_70/carry[3] ) );
  CLKXOR2_X2_12_LVT_NT U30 ( .A(out[2]), .B(\add_70/carry[2] ), .Q(N20) );
  AND2_X0_12_LVT_NT U31 ( .A(out[0]), .B(deltaY_0), .Q(\add_70/carry[1] ) );
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
         N187, N188, N190, N191, N192, N193, N194, N195, N196, N197, N198,
         N199, N200, N219, n1, n2, n3, n4, n5, n6, n7, n12, n13, n27, n28, n29,
         n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43,
         n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57,
         n58, n59, n60, n61, n62, n63, n8, n9, n10, n11, n14, n15, n16, n17,
         n18, n19, n20, n21, n22, n23, n24;
  wire   [2:0] STATE;
  wire   [1:0] flag;
  wire   [2:0] NEXT_STATE;

  TLAT_X1_12_LVT_NT keepCount_reg ( .G(n8), .D(newLine), .Q(keepCount) );
  TLAT_X1_12_LVT_NT \flag_reg[0]  ( .G(N197), .D(N198), .Q(flag[0]), .QN(n13)
         );
  TLAT_X1_12_LVT_NT \flag_reg[1]  ( .G(N199), .D(N200), .Q(flag[1]), .QN(n12)
         );
  TLAT_X1_12_LVT_NT BinaryOrGray_reg ( .G(N187), .D(N188), .Q(BinaryOrGray) );
  TLAT_X1_12_LVT_NT test_reg ( .G(N185), .D(N186), .Q(test) );
  TLAT_X1_12_LVT_NT b5_enb_reg ( .G(N181), .D(newLine), .Q(b5_enb) );
  TLAT_X1_12_LVT_NT \ValSel_reg[0]  ( .G(N194), .D(N195), .Q(ValSel[0]) );
  TLAT_X1_12_LVT_NT ramp_enb_reg ( .G(N183), .D(N184), .Q(ramp_enb) );
  TLAT_X1_12_LVT_NT \ValSel_reg[1]  ( .G(N194), .D(N196), .Q(ValSel[1]) );
  TLATN_X1_12_LVT_NT delta_reg ( .D(N190), .GN(n61), .Q(delta) );
  TLAT_X1_12_LVT_NT \Xmode_reg[0]  ( .G(N191), .D(N192), .Q(Xmode[0]) );
  TLAT_X1_12_LVT_NT \Xmode_reg[1]  ( .G(N191), .D(N193), .Q(Xmode[1]) );
  XNOR2_X2_12_LVT_NT U33 ( .A(flag[1]), .B(flag[0]), .Q(n47) );
  DFFRQ_X2_12_LVT_NT \flag2x2_reg[0]  ( .D(N219), .CK(clk), .RN(rst_n), .Q(
        \flag2x2[0] ) );
  DFFRQ_X2_12_LVT_NT \STATE_reg[0]  ( .D(NEXT_STATE[0]), .CK(clk), .RN(rst_n), 
        .Q(STATE[0]) );
  DFFRQ_X2_12_LVT_NT \STATE_reg[2]  ( .D(NEXT_STATE[2]), .CK(clk), .RN(rst_n), 
        .Q(STATE[2]) );
  DFFRQ_X2_12_LVT_NT \STATE_reg[1]  ( .D(NEXT_STATE[1]), .CK(clk), .RN(rst_n), 
        .Q(STATE[1]) );
  INV_X2_12_LVT_NT U3 ( .A(n62), .Q(n10) );
  INV_X2_12_LVT_NT U4 ( .A(n53), .Q(n22) );
  INV_X2_12_LVT_NT U5 ( .A(n51), .Q(n20) );
  NAND2_X2_12_LVT_NT U6 ( .A(n9), .B(n14), .Q(N184) );
  OR2_X2_12_LVT_NT U7 ( .A(N186), .B(N187), .Q(N185) );
  INV_X2_12_LVT_NT U8 ( .A(b12_enb), .Q(n8) );
  NAND2_X2_12_LVT_NT U9 ( .A(n39), .B(n18), .Q(n29) );
  INV_X2_12_LVT_NT U10 ( .A(newLine), .Q(n9) );
  NOR2_X2_12_LVT_NT U11 ( .A(n15), .B(n11), .Q(n62) );
  INV_A_NOR2_X2_12_LVT_NT U12 ( .AN(n44), .B(n45), .Q(n46) );
  INV_X2_12_LVT_NT U13 ( .A(n30), .Q(n14) );
  NOR2_X2_12_LVT_NT U14 ( .A(n57), .B(n43), .Q(n51) );
  OAI31_X2_12_LVT_NT U15 ( .A0(n18), .A1(n22), .A2(n46), .B0(n48), .Q(N199) );
  OAI211_X2_12_LVT_NT U16 ( .A0(n17), .A1(n4), .B0(n3), .C0(n6), .Q(N194) );
  AOI21_X2_12_LVT_NT U17 ( .A0(n5), .A1(n15), .B0(n1), .Q(n4) );
  OAI211_X2_12_LVT_NT U18 ( .A0(n11), .A1(N127), .B0(n15), .C0(n17), .Q(n3) );
  AOI21_X2_12_LVT_NT U19 ( .A0(N179), .A1(n11), .B0(n15), .Q(n1) );
  NOR2_X2_12_LVT_NT U20 ( .A(n30), .B(N181), .Q(n61) );
  OAI21_X2_12_LVT_NT U21 ( .A0(N179), .A1(n60), .B0(n61), .Q(N191) );
  NAND2_X2_12_LVT_NT U22 ( .A(n48), .B(n9), .Q(N181) );
  INV_A_OAI211_X2_12_LVT_NT U23 ( .A1N(n34), .A0(n27), .B0(n14), .C0(n60), .Q(
        N195) );
  NAND3_X2_12_LVT_NT U24 ( .A(n55), .B(n33), .C(n48), .Q(N187) );
  INV_X2_12_LVT_NT U25 ( .A(n43), .Q(n19) );
  NAND3_X2_12_LVT_NT U26 ( .A(n36), .B(n14), .C(n46), .Q(N186) );
  NAND3_X2_12_LVT_NT U27 ( .A(n63), .B(n14), .C(n48), .Q(N183) );
  OR3_X2_12_LVT_NT U28 ( .A(n27), .B(n24), .C(n21), .Q(n63) );
  NAND2_X2_12_LVT_NT U29 ( .A(n41), .B(n59), .Q(n53) );
  NOR2_X2_12_LVT_NT U30 ( .A(n18), .B(n14), .Q(N190) );
  NAND3_X2_12_LVT_NT U31 ( .A(n22), .B(n23), .C(n51), .Q(N127) );
  AND2_X2_12_LVT_NT U32 ( .A(n55), .B(n36), .Q(n60) );
  NAND2_X2_12_LVT_NT U34 ( .A(n9), .B(n55), .Q(N188) );
  OAI31_X2_12_LVT_NT U35 ( .A0(n11), .A1(STATE[1]), .A2(STATE[2]), .B0(n8), 
        .Q(cnt_enb) );
  OAI21_X2_12_LVT_NT U36 ( .A0(n7), .A1(n17), .B0(n6), .Q(b12_enb) );
  AOI32_X2_12_LVT_NT U37 ( .A0(n11), .A1(n16), .A2(STATE[2]), .B0(n5), .B1(n15), .Q(n7) );
  INV_X2_12_LVT_NT U38 ( .A(N179), .Q(n16) );
  OAI22_X2_12_LVT_NT U39 ( .A0(N179), .A1(n11), .B0(N179), .B1(STATE[0]), .Q(
        n5) );
  INV_A_NAND2_X2_12_LVT_NT U40 ( .AN(endLine), .B(keepCount), .Q(N179) );
  NAND3_X2_12_LVT_NT U41 ( .A(n2), .B(n17), .C(STATE[2]), .Q(n6) );
  OAI22_X2_12_LVT_NT U42 ( .A0(N179), .A1(n11), .B0(N179), .B1(STATE[0]), .Q(
        n2) );
  INV_X2_12_LVT_NT U43 ( .A(STATE[0]), .Q(n11) );
  INV_X2_12_LVT_NT U44 ( .A(STATE[2]), .Q(n15) );
  NOR3_X2_12_LVT_NT U45 ( .A(STATE[1]), .B(STATE[2]), .C(n11), .Q(newLine) );
  OAI211_X2_12_LVT_NT U46 ( .A0(n31), .A1(n27), .B0(n32), .C0(n33), .Q(
        NEXT_STATE[1]) );
  AOI21_X2_12_LVT_NT U47 ( .A0(Mode[2]), .A1(Mode[0]), .B0(n34), .Q(n31) );
  INV_A_NAND3_X2_12_LVT_NT U48 ( .AN(n29), .B(STATE[1]), .C(n10), .Q(n32) );
  NAND2_X2_12_LVT_NT U49 ( .A(endLine), .B(endFrame), .Q(n39) );
  OAI221_X2_12_LVT_NT U50 ( .A0(n35), .A1(n18), .B0(n29), .B1(n36), .C0(n37), 
        .Q(NEXT_STATE[0]) );
  AOI222_X2_12_LVT_NT U51 ( .A0(STATE[2]), .A1(n17), .B0(STATE[1]), .B1(n10), 
        .C0(f_sync), .C1(n11), .Q(n35) );
  AOI22_X2_12_LVT_NT U52 ( .A0(n38), .A1(n39), .B0(newLine), .B1(n40), .Q(n37)
         );
  OAI222_X2_12_LVT_NT U53 ( .A0(n41), .A1(n12), .B0(n42), .B1(n23), .C0(n19), 
        .C1(n13), .Q(n40) );
  OAI222_X2_12_LVT_NT U54 ( .A0(n27), .A1(n24), .B0(n28), .B1(n29), .C0(n9), 
        .C1(n21), .Q(NEXT_STATE[2]) );
  AOI21_X2_12_LVT_NT U55 ( .A0(STATE[2]), .A1(n17), .B0(n30), .Q(n28) );
  NOR2_X2_12_LVT_NT U56 ( .A(n10), .B(STATE[1]), .Q(n45) );
  NAND2_A_OAI21_X2_12_LVT_NT U57 ( .B0(\flag2x2[0] ), .B1(n44), .A0N(n45), 
        .A1N(\flag2x2[0] ), .Q(n38) );
  INV_X2_12_LVT_NT U58 ( .A(STATE[1]), .Q(n17) );
  NAND2_X2_12_LVT_NT U59 ( .A(Mode[1]), .B(newLine), .Q(n27) );
  NOR3_X2_12_LVT_NT U60 ( .A(n15), .B(STATE[0]), .C(n17), .Q(n30) );
  NAND4_X2_12_LVT_NT U61 ( .A(Mode[0]), .B(newLine), .C(n23), .D(n21), .Q(n33)
         );
  NAND3_X2_12_LVT_NT U62 ( .A(n11), .B(n17), .C(STATE[2]), .Q(n44) );
  NAND3_X2_12_LVT_NT U63 ( .A(STATE[0]), .B(n15), .C(STATE[1]), .Q(n36) );
  NOR2_X2_12_LVT_NT U64 ( .A(\flag2x2[0] ), .B(n22), .Q(N219) );
  AOI32_X2_12_LVT_NT U65 ( .A0(n11), .A1(n15), .A2(n17), .B0(STATE[1]), .B1(
        n62), .Q(n48) );
  NOR3_X2_12_LVT_NT U66 ( .A(Mode[0]), .B(Mode[1]), .C(n21), .Q(n43) );
  AOI221_X2_12_LVT_NT U67 ( .A0(n21), .A1(n13), .B0(n24), .B1(n12), .C0(n34), 
        .Q(n42) );
  NOR3_X2_12_LVT_NT U68 ( .A(n23), .B(Mode[2]), .C(n24), .Q(n57) );
  NOR2_X2_12_LVT_NT U69 ( .A(Mode[0]), .B(Mode[2]), .Q(n34) );
  NAND3_X2_12_LVT_NT U70 ( .A(n11), .B(n15), .C(STATE[1]), .Q(n55) );
  INV_X2_12_LVT_NT U71 ( .A(sync), .Q(n18) );
  INV_X2_12_LVT_NT U72 ( .A(Mode[1]), .Q(n23) );
  NAND3_X2_12_LVT_NT U73 ( .A(Mode[0]), .B(n23), .C(Mode[2]), .Q(n41) );
  OAI211_X2_12_LVT_NT U74 ( .A0(n54), .A1(n9), .B0(n55), .C0(n56), .Q(N196) );
  NOR2_X2_12_LVT_NT U75 ( .A(n30), .B(n45), .Q(n56) );
  AOI221_X2_12_LVT_NT U76 ( .A0(n43), .A1(n13), .B0(n57), .B1(flag[0]), .C0(
        n58), .Q(n54) );
  OAI22_X2_12_LVT_NT U77 ( .A0(n41), .A1(n12), .B0(flag[1]), .B1(n59), .Q(n58)
         );
  INV_X2_12_LVT_NT U78 ( .A(Mode[0]), .Q(n24) );
  INV_X2_12_LVT_NT U79 ( .A(Mode[2]), .Q(n21) );
  NAND3_X2_12_LVT_NT U80 ( .A(Mode[1]), .B(n24), .C(Mode[2]), .Q(n59) );
  OAI21_X2_12_LVT_NT U81 ( .A0(n46), .A1(n52), .B0(n48), .Q(N197) );
  AOI21_X2_12_LVT_NT U82 ( .A0(sync), .A1(n53), .B0(n20), .Q(n52) );
  NOR2_X2_12_LVT_NT U83 ( .A(n46), .B(n49), .Q(N198) );
  AOI32_X2_12_LVT_NT U84 ( .A0(n20), .A1(n18), .A2(flag[0]), .B0(n50), .B1(n13), .Q(n49) );
  OAI21_X2_12_LVT_NT U85 ( .A0(n51), .A1(n18), .B0(n22), .Q(n50) );
  NOR2_X2_12_LVT_NT U86 ( .A(n46), .B(n47), .Q(N200) );
  NAND2_A_NAND2_X2_12_LVT_NT U87 ( .A0N(X[0]), .A1N(n30), .B0(n55), .Q(N192)
         );
  AND2_X2_12_LVT_NT U88 ( .A(X[1]), .B(n30), .Q(N193) );
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
         n39, n40, n41, n42, n43, n44, n45;
  wire   [1:0] ValSel;
  wire   [11:0] LoadVal;
  wire   [11:0] ramp_out;
  wire   [11:0] counter_out;
  wire   [11:0] gray_converter;
  wire   [1:0] Xmode;

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
        .LoadVal(LoadVal), .out(counter_out) );
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
  OAI211_X2_12_LVT_NT U55 ( .A0(n34), .A1(n33), .B0(n15), .C0(n26), .Q(
        LoadVal[11]) );
  BUF_X2_12_LVT_NT U56 ( .A(n31), .Q(n29) );
  BUF_X2_12_LVT_NT U57 ( .A(n31), .Q(n30) );
  OAI211_X2_12_LVT_NT U58 ( .A0(n42), .A1(n33), .B0(n15), .C0(n23), .Q(
        LoadVal[3]) );
  AOI22_X2_12_LVT_NT U59 ( .A0(constVal[3]), .A1(n17), .B0(ramp_out[3]), .B1(
        n32), .Q(n23) );
  OAI211_X2_12_LVT_NT U60 ( .A0(n43), .A1(n33), .B0(n15), .C0(n24), .Q(
        LoadVal[2]) );
  OAI211_X2_12_LVT_NT U61 ( .A0(n45), .A1(n33), .B0(n15), .C0(n28), .Q(
        LoadVal[0]) );
  AOI22_X2_12_LVT_NT U62 ( .A0(constVal[0]), .A1(n17), .B0(ramp_out[0]), .B1(
        n32), .Q(n28) );
  INV_X2_12_LVT_NT U63 ( .A(counter_out[0]), .Q(n45) );
  OAI211_X2_12_LVT_NT U64 ( .A0(n44), .A1(n33), .B0(n15), .C0(n25), .Q(
        LoadVal[1]) );
  AOI22_X2_12_LVT_NT U65 ( .A0(constVal[1]), .A1(n17), .B0(ramp_out[1]), .B1(
        n32), .Q(n25) );
  INV_X2_12_LVT_NT U66 ( .A(counter_out[1]), .Q(n44) );
  INV_X2_12_LVT_NT U67 ( .A(counter_out[2]), .Q(n43) );
  AOI22_X2_12_LVT_NT U68 ( .A0(constVal[2]), .A1(n17), .B0(ramp_out[2]), .B1(
        n32), .Q(n24) );
  INV_X2_12_LVT_NT U69 ( .A(counter_out[3]), .Q(n42) );
  OAI211_X2_12_LVT_NT U70 ( .A0(n41), .A1(n33), .B0(n15), .C0(n22), .Q(
        LoadVal[4]) );
  AOI22_X2_12_LVT_NT U71 ( .A0(constVal[4]), .A1(n17), .B0(ramp_out[4]), .B1(
        n32), .Q(n22) );
  INV_X2_12_LVT_NT U72 ( .A(counter_out[4]), .Q(n41) );
  OAI211_X2_12_LVT_NT U73 ( .A0(n40), .A1(n33), .B0(n15), .C0(n21), .Q(
        LoadVal[5]) );
  AOI22_X2_12_LVT_NT U74 ( .A0(constVal[5]), .A1(n17), .B0(ramp_out[5]), .B1(
        n32), .Q(n21) );
  INV_X2_12_LVT_NT U75 ( .A(counter_out[5]), .Q(n40) );
  OAI211_X2_12_LVT_NT U76 ( .A0(n39), .A1(n33), .B0(n15), .C0(n20), .Q(
        LoadVal[6]) );
  AOI22_X2_12_LVT_NT U77 ( .A0(constVal[6]), .A1(n17), .B0(ramp_out[6]), .B1(
        n32), .Q(n20) );
  INV_X2_12_LVT_NT U78 ( .A(counter_out[6]), .Q(n39) );
  OAI211_X2_12_LVT_NT U79 ( .A0(n38), .A1(n33), .B0(n15), .C0(n19), .Q(
        LoadVal[7]) );
  AOI22_X2_12_LVT_NT U80 ( .A0(constVal[7]), .A1(n17), .B0(ramp_out[7]), .B1(
        n32), .Q(n19) );
  INV_X2_12_LVT_NT U81 ( .A(counter_out[7]), .Q(n38) );
  OAI211_X2_12_LVT_NT U82 ( .A0(n37), .A1(n33), .B0(n15), .C0(n18), .Q(
        LoadVal[8]) );
  AOI22_X2_12_LVT_NT U83 ( .A0(constVal[8]), .A1(n17), .B0(ramp_out[8]), .B1(
        n32), .Q(n18) );
  INV_X2_12_LVT_NT U84 ( .A(counter_out[8]), .Q(n37) );
  OAI211_X2_12_LVT_NT U85 ( .A0(n36), .A1(n33), .B0(n15), .C0(n16), .Q(
        LoadVal[9]) );
  AOI22_X2_12_LVT_NT U86 ( .A0(constVal[9]), .A1(n17), .B0(ramp_out[9]), .B1(
        n32), .Q(n16) );
  INV_X2_12_LVT_NT U87 ( .A(counter_out[9]), .Q(n36) );
  OAI211_X2_12_LVT_NT U88 ( .A0(n35), .A1(n33), .B0(n15), .C0(n27), .Q(
        LoadVal[10]) );
  AOI22_X2_12_LVT_NT U89 ( .A0(constVal[10]), .A1(n17), .B0(ramp_out[10]), 
        .B1(n32), .Q(n27) );
  INV_X2_12_LVT_NT U90 ( .A(counter_out[10]), .Q(n35) );
  INV_X2_12_LVT_NT U91 ( .A(counter_out[11]), .Q(n34) );
  AOI22_X2_12_LVT_NT U92 ( .A0(constVal[11]), .A1(n17), .B0(ramp_out[11]), 
        .B1(n32), .Q(n26) );
  NAND2_A_OAI21_X2_12_LVT_NT U93 ( .B0(n29), .B1(n36), .A0N(gray_converter[9]), 
        .A1N(n30), .Q(N17) );
  NAND2_A_OAI21_X2_12_LVT_NT U94 ( .B0(n29), .B1(n35), .A0N(gray_converter[10]), .A1N(n30), .Q(N18) );
  NAND2_A_OAI21_X2_12_LVT_NT U95 ( .B0(n29), .B1(n44), .A0N(gray_converter[1]), 
        .A1N(n30), .Q(N9) );
  NAND2_A_OAI21_X2_12_LVT_NT U96 ( .B0(n29), .B1(n43), .A0N(gray_converter[2]), 
        .A1N(n30), .Q(N10) );
  NAND2_A_OAI21_X2_12_LVT_NT U97 ( .B0(n29), .B1(n42), .A0N(gray_converter[3]), 
        .A1N(n29), .Q(N11) );
  NAND2_A_OAI21_X2_12_LVT_NT U98 ( .B0(n29), .B1(n41), .A0N(gray_converter[4]), 
        .A1N(n30), .Q(N12) );
  NAND2_A_OAI21_X2_12_LVT_NT U99 ( .B0(n29), .B1(n40), .A0N(gray_converter[5]), 
        .A1N(n30), .Q(N13) );
  NAND2_A_OAI21_X2_12_LVT_NT U100 ( .B0(n29), .B1(n39), .A0N(gray_converter[6]), .A1N(n30), .Q(N14) );
  NAND2_A_OAI21_X2_12_LVT_NT U101 ( .B0(n29), .B1(n38), .A0N(gray_converter[7]), .A1N(n30), .Q(N15) );
  NAND2_A_OAI21_X2_12_LVT_NT U102 ( .B0(n29), .B1(n37), .A0N(gray_converter[8]), .A1N(n30), .Q(N16) );
  NAND2_A_OAI21_X2_12_LVT_NT U103 ( .B0(n29), .B1(n45), .A0N(gray_converter[0]), .A1N(n30), .Q(N8) );
  NAND2_A_OAI21_X2_12_LVT_NT U104 ( .B0(n29), .B1(n34), .A0N(
        gray_converter[11]), .A1N(n30), .Q(N19) );
  NOR2_X2_12_LVT_NT U105 ( .A(n32), .B(ValSel[1]), .Q(n17) );
  INV_X2_12_LVT_NT U106 ( .A(ValSel[1]), .Q(n33) );
  NAND2_X2_12_LVT_NT U107 ( .A(ValSel[1]), .B(n32), .Q(n15) );
  INV_X2_12_LVT_NT U108 ( .A(ValSel[0]), .Q(n32) );
  BUF_X2_12_LVT_NT U109 ( .A(BinaryOrGray), .Q(n31) );
endmodule

