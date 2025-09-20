`timescale 1ns / 1ps
module special_shifter(
       input [31:0]binery,
       output reg[7:0]exponent,
       output reg[22:0]mentissa
);
always@(*)begin
if(binery[31]==0)begin
///////////////////////////////////////////////////////////////////////
if (binery[30] == 1) begin
    mentissa = binery[29:7];
    exponent = 8'd157; // 127 + 30
end
else if (binery[29] == 1) begin
    mentissa = binery[28:6];
    exponent = 8'd156; // 127 + 29
end
else if (binery[28] == 1) begin
    mentissa = binery[27:5];
    exponent = 8'd155; // 127 + 28
end
else if (binery[27] == 1) begin
    mentissa = binery[26:4];
    exponent = 8'd154; // 127 + 27
end
else if (binery[26] == 1) begin
    mentissa = binery[25:3];
    exponent = 8'd153; // 127 + 26
end
else if (binery[25] == 1) begin
    mentissa = binery[24:2];
    exponent = 8'd152; // 127 + 25
end
else if (binery[24] == 1) begin
    mentissa = binery[23:1];
    exponent = 8'd151; // 127 + 24
end
else if (binery[23] == 1) begin
    mentissa = binery[22:0]; // last 23 bits
    exponent = 8'd150; // 127 + 23
end
else if (binery[22] == 1) begin
    mentissa = {binery[21:0], 1'b0}; 
    exponent = 8'd149; // 127 + 22
end
else if (binery[21] == 1) begin
    mentissa = {binery[20:0], 2'b00};
    exponent = 8'd148; // 127 + 21
end
else if (binery[20] == 1) begin
    mentissa = {binery[19:0], 3'b000};
    exponent = 8'd147; // 127 + 20
end
else if (binery[20] == 1) begin
    mentissa = {binery[19:0], 3'b000};
    exponent = 8'd147; // 127 + 20
end
else if (binery[19] == 1) begin
    mentissa = {binery[18:0], 4'b0000};
    exponent = 8'd146; // 127 + 19
end
else if (binery[18] == 1) begin
    mentissa = {binery[17:0], 5'b00000};
    exponent = 8'd145; // 127 + 18
end
else if (binery[17] == 1) begin
    mentissa = {binery[16:0], 6'b000000};
    exponent = 8'd144; // 127 + 17
end
else if (binery[16] == 1) begin
    mentissa = {binery[15:0], 7'b0000000};
    exponent = 8'd143; // 127 + 16
end
else if (binery[15] == 1) begin
    mentissa = {binery[14:0], 8'b00000000};
    exponent = 8'd142; // 127 + 15
end
else if (binery[14] == 1) begin
    mentissa = {binery[13:0], 9'b000000000};
    exponent = 8'd141; // 127 + 14
end
else if (binery[13] == 1) begin
    mentissa = {binery[12:0], 10'b0000000000};
    exponent = 8'd140; // 127 + 13
end
else if (binery[12] == 1) begin
    mentissa = {binery[11:0], 11'b00000000000};
    exponent = 8'd139; // 127 + 12
end
else if (binery[11] == 1) begin
    mentissa = {binery[10:0], 12'b000000000000};
    exponent = 8'd138; // 127 + 11
end
else if (binery[10] == 1) begin
    mentissa = {binery[9:0], 13'b0000000000000};
    exponent = 8'd137; // 127 + 10
end
else if (binery[9] == 1) begin
    mentissa = {binery[8:0], 14'b00000000000000};
    exponent = 8'd136; // 127 + 9
end
else if (binery[8] == 1) begin
    mentissa = {binery[7:0], 15'b000000000000000};
    exponent = 8'd135; // 127 + 8
end
else if (binery[7] == 1) begin
    mentissa = {binery[6:0], 16'b0000000000000000};
    exponent = 8'd134; // 127 + 7
end
else if (binery[6] == 1) begin
    mentissa = {binery[5:0], 17'b00000000000000000};
    exponent = 8'd133; // 127 + 6
end
else if (binery[5] == 1) begin
    mentissa = {binery[4:0], 18'b000000000000000000};
    exponent = 8'd132; // 127 + 5
end
else if (binery[4] == 1) begin
    mentissa = {binery[3:0], 19'b0000000000000000000};
    exponent = 8'd131; // 127 + 4
end
else if (binery[3] == 1) begin
    mentissa = {binery[2:0], 20'b00000000000000000000};
    exponent = 8'd130; // 127 + 3
end
else if (binery[2] == 1) begin
    mentissa = {binery[1:0], 21'b000000000000000000000};
    exponent = 8'd129; // 127 + 2
end
else if (binery[1] == 1) begin
    mentissa = {binery[0], 22'b0000000000000000000000};
    exponent = 8'd128; // 127 + 1
end
else if (binery[0] == 1) begin
    mentissa = 23'b00000000000000000000000; // nothing left below bit 0
    exponent = 8'd127; // 127 + 0
end
end
///////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
else begin      /////////for negative number case
    if (binery[30] == 0) begin
    mentissa = ~binery[29:7] + 1;
    exponent = 8'd157;   // 127 + 30
end
else if (binery[29] == 0) begin
    mentissa = ~binery[28:6] + 1;
    exponent = 8'd156;   // 127 + 29
end
else if (binery[28] == 0) begin
    mentissa = ~binery[27:5] + 1;
    exponent = 8'd155;   // 127 + 28
end
else if (binery[27] == 0) begin
    mentissa = ~binery[26:4] + 1;
    exponent = 8'd154;   // 127 + 27
end
else if (binery[26] == 0) begin
    mentissa = ~binery[25:3] + 1;
    exponent = 8'd153;   // 127 + 26
end
else if (binery[25] == 0) begin
    mentissa = ~binery[24:2] + 1;
    exponent = 8'd152;   // 127 + 25
end
else if (binery[24] == 0) begin
    mentissa = ~binery[23:1] + 1;
    exponent = 8'd151;   // 127 + 24
end
else if (binery[23] == 0) begin
    mentissa = ~binery[22:0] + 1;
    exponent = 8'd150;   // 127 + 23
end
else if (binery[22] == 0) begin
    mentissa = ~{binery[21:0], 1'b0} + 1;
    exponent = 8'd149;   // 127 + 22
end
else if (binery[21] == 0) begin
    mentissa = ~{binery[20:0], 2'b00} + 1;
    exponent = 8'd148;   // 127 + 21
end
else if (binery[20] == 0) begin
    mentissa = ~{binery[19:0], 3'b000} + 1;
    exponent = 8'd147;   // 127 + 20
end

else if (binery[19] == 0) begin
    mentissa = ~{binery[18:0], 4'b0000} + 1;
    exponent = 8'd146;   // 127 + 19
end
else if (binery[18] == 0) begin
    mentissa = ~{binery[17:0], 5'b00000} + 1;
    exponent = 8'd145;   // 127 + 18
end
else if (binery[17] == 0) begin
    mentissa = ~{binery[16:0], 6'b000000} + 1;
    exponent = 8'd144;   // 127 + 17
end
else if (binery[16] == 0) begin
    mentissa = ~{binery[15:0], 7'b0000000} + 1;
    exponent = 8'd143;   // 127 + 16
end
else if (binery[15] == 0) begin
    mentissa = ~{binery[14:0], 8'b00000000} + 1;
    exponent = 8'd142;   // 127 + 15
end
else if (binery[14] == 0) begin
    mentissa = ~{binery[13:0], 9'b000000000} + 1;
    exponent = 8'd141;   // 127 + 14
end
else if (binery[13] == 0) begin
    mentissa = ~{binery[12:0], 10'b0000000000} + 1;
    exponent = 8'd140;   // 127 + 13
end
else if (binery[12] == 0) begin
    mentissa = ~{binery[11:0], 11'b00000000000} + 1;
    exponent = 8'd139;   // 127 + 12
end
else if (binery[11] == 0) begin
    mentissa = ~{binery[10:0], 12'b000000000000} + 1;
    exponent = 8'd138;   // 127 + 11
end
else if (binery[10] == 0) begin
    mentissa = ~{binery[9:0], 13'b0000000000000} + 1;
    exponent = 8'd137;   // 127 + 10
end
else if (binery[9] == 0) begin
    mentissa = ~{binery[8:0], 14'b00000000000000} + 1;
    exponent = 8'd136;   // 127 + 9
end
else if (binery[8] == 0) begin
    mentissa = ~{binery[7:0], 15'b000000000000000} + 1;
    exponent = 8'd135;   // 127 + 8
end
else if (binery[7] == 0) begin
    mentissa = ~{binery[6:0], 16'b0000000000000000} + 1;
    exponent = 8'd134;   // 127 + 7
end
else if (binery[6] == 0) begin
    mentissa = ~{binery[5:0], 17'b00000000000000000} + 1;
    exponent = 8'd133;   // 127 + 6
end
else if (binery[5] == 0) begin
    mentissa = ~{binery[4:0], 18'b000000000000000000} + 1;
    exponent = 8'd132;   // 127 + 5
end
else if (binery[4] == 0) begin
    mentissa = ~{binery[3:0], 19'b0000000000000000000} + 1;
    exponent = 8'd131;   // 127 + 4
end
else if (binery[3] == 0) begin
    mentissa = ~{binery[2:0], 20'b00000000000000000000} + 1;
    exponent = 8'd130;   // 127 + 3
end
else if (binery[2] == 0) begin
    mentissa = ~{binery[1:0], 21'b000000000000000000000} + 1;
    exponent = 8'd129;   // 127 + 2
end
else if (binery[1] == 0) begin
    mentissa = ~{binery[0], 22'b0000000000000000000000} + 1;
    exponent = 8'd128;   // 127 + 1
end
else if (binery[0] == 0) begin
    mentissa = ~{23'b00000000000000000000000} + 1;
    exponent = 8'd127;   // 127 + 0
end
end    
end

endmodule