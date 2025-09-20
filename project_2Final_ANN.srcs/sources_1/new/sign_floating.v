`timescale 1ns / 1ps
//////////////////////////////////////////////////////
module sign_floating(
       input [31:0]binery1,
       output reg [31:0]floating
);
reg [31:0]binery;
wire[7:0]exponent;
wire[22:0]mentissa;
special_shifter sss(
       .binery(binery),
       .exponent(exponent),
       .mentissa(mentissa)
);
always@(*)begin
       binery=binery1;
      floating={binery1[31],exponent,mentissa};
end
endmodule