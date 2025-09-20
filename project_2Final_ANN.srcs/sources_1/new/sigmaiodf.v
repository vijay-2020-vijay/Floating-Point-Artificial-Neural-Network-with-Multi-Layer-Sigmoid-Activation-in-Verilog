`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////
////input of this module should be floating number///////////////////
///////////////////////////////////////////////////////////////////////
module sigmaiodf #(n=40,s0=4'd0,s1=4'd1,s2=4'd2,s3=3'd3,s4=4'd4,s5=4'd5,s6=4'd6,s7=4'd7,s8=4'd8,s9=4'd9,s10=4'd10,s11=4'd11,s12=4'd12,s00=4'd13
,s14=4'd14,s15=4'd15)
(clk,reset,start,x,sigmaiod,done);
    input[31:0]x;
    input clk,reset;
    input start;
    output reg [31:0]sigmaiod;
    output reg done;
    
    
    
    reg[31:0]result1;
/////////////////////////////////complete input and output decletration//////////////////////////////////////
    reg[3:0]ns;
    reg[31:0]m1,n1,d1,d2,a1,b1;
    wire[31:0]multi_wire,d_wire,add_wire;
    reg[31:0]sum1,term1,count1;
    reg[6:0]i,j;
//////////////////////////////////////////state and module decleration////////////////////////////////////////
    multipli M1(.a(m1),.b(n1),.mult(multi_wire));
    div1 D1(.A(d1),.B(d2),.OUT(d_wire));
    addsubs A1(.a_operand(a1),.b_operand(b1),.AddBar_Sub(1'b0),.Exception(),.result(add_wire));
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
    always@(posedge clk)begin
        if(reset)begin
            sum1<=32'b00111111100000000000000000000000;
            term1<=32'b00111111100000000000000000000000;
            count1<=32'b00111111100000000000000000000000;
            done<=0;
            //sigmaiod<=0;
            i<=0;
            j<=1;
            ns<=s00;
        end
        else begin
//////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
            case(ns)
            s00:begin
               if(start==1)begin
                 ns<=s0;
                 done<=0;
              end
            end
             s0:begin
                  i<=i+1;
                  ns<=s1;  
                end
             s1:begin
                   a1<=count1;
                   b1<=32'b00111111100000000000000000000000;
                   d1<=x;
                   d2<=count1;
                   ns<=s2;
                   end
              s2:begin
                   m1<=d_wire;  //////x/1,x/2,x/3,x/4,x/5,x/6,x/7....
                   n1<=term1;
                   ns<=s3;
                end
               s3:begin
                   count1<=add_wire;  ////////count1 is incremented
                   term1<=multi_wire; //////// term1 is also modifited
                   ns<=s4;
                end
              s4:begin
                   if(i<j) begin
                      ns<=s0;
                   end   
                   else begin
                      a1<=multi_wire;
                      b1<=sum1;
                      ns<=s5;
                   end
                end     
             s5:begin
                    sum1<=add_wire;
                    count1<=32'b00111111100000000000000000000000;
                    term1<=32'b00111111100000000000000000000000;
                    i<=0;
                    ns<=s6;
                end    
              s6:begin
                  if(j<n)begin
                    j<=j+1;
                    ns<=s0;
                  end
                  else begin
                    ns<=s7;
                  end
                 end
              s7:begin
                   result1<=sum1;
                   ns<=s8;
                 end   
                 
              s8:begin
                 d1<=32'b00111111100000000000000000000000;
                 d2<=sum1;
                 ns<=s9;
              end   
              s9:begin
                 a1<=32'b00111111100000000000000000000000;
                 b1<=d_wire;
                 ns<=s10;
              end  
              s10: begin
                  d1<=32'b00111111100000000000000000000000;
                  d2<=add_wire;
                  ns<=s11;
              end
              s11:begin
                done<=1;
                sigmaiod<=d_wire;
                ns<=s12;
              end
              s12:begin
                done<=0;
                ns<=s14;
              end
              s14:begin
                ns<=s15;
              end
              s15:begin
                   i<=0;
                   j<=1;
                   ns<=s00;
              end
              
            endcase
        end
    end  
    
    
endmodule
