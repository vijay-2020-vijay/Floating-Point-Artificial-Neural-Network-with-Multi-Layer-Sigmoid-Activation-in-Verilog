////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps
////// project is Artifitial nural Network/////////////////////////////////////////////////////////////////////////
///No of hidden layer=3 //
//No. of output node is=4 //
//input weight values are given as signed decimal formet//
//my sigmaiod module is operated on floating point number only.thats why we have used binary to floating converter.
//then that floating number has to be sent to sigmaid module//////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module Finalann#(
    n1 =4,m1=5,m2=5,m3=5,n4=5,
    /// the condition should have to follow this statistices like  m1=n2 and m2=n3 and should choise m3=m4
    ///strickly follow the above statements  now you can choose any integer value of n1,m1,m2,m3,and n4;
    /// n1=is the number of  inputs nurons
    /// m1=number of node point in ist hidden layer
    /// m2=number of node point in 2nd hidden layer
    ////m3=number of node points in 3rd hidden layer
    /// n4-1=number of output node points in the output layer
    s0 = 4'd0,s1 = 4'd1,s2 = 4'd2,    
    s3 = 4'd3,s4 = 4'd4,s5 = 4'd5,   
    s6 = 4'd6,s7 = 4'd7,s8 = 4'd8,
    s9 = 4'd9,s10 = 4'd10,s11=4'd11,s12=4'd12,s13=4'd13,s14=4'd14,s15=4'd15,s16=5'd16)
   (clk,reset,x,w1,w2,w3,w4,done);
input clk, reset; ///Basic inputs
input [31:0]w1,w2,w3,w4,x;    /// we will provide 32 bits inputs weight value for building 4 matrixs accroding to their number of nurons and node points           /// this is the input starting nuron value
output reg  done;  
reg [4:0]ns; 
reg signed[31:0]x_load[0:n1-1];  
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
reg signed [31:0]xin_load[0:n1-1][0:n1-1];                /// input 1*n1=1*10 order nuron matrix where should assign 10 features value 
reg signed [31:0] w1_load[0:m1-1][0:n1-1];    ///ist layer weight m1*n1 matrix//lets take m1=15 and n1=10 .this is 15*10 weight matrix//ist section is rows and 2nd section is collum
reg signed [31:0] w2_load[0:m2-1][0:m1-1];   ///2nd layer weight m2*n2 matrix// lets take m2=15 and n2=15 this is 15*15 weight matrix
reg signed [31:0] w3_load[0:m3-1][0:m2-1];   ///3rd layer weight m3*n3 matrix// lets take m3=15 and n3=15 this is 15*15 weight matrix
reg signed [31:0] w4_load[0:n4-1][0:m3-1];   ///4th layer weight m4*n4 matrix// lets take m3=5 and n3=15 this is 5*15 weight matrix
reg signed [31:0] y_load[0:n4-1];   ///4th layer weight m4*n4 matrix// lets take n4=5  /// we are generating 5 outputs that's why we are takeing 1*5 matrix as a output load
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
reg signed [31:0]h1[0:m1-1];/////here total number of element should be 15 thats why it is 0 t0 m-1 these are temp resister
reg signed [31:0]h11[0:m1-1];
 
reg signed [31:0]h2[0:m2-1]; ////here total number of element should be 15 thats why it is 0 t0 m-1   these are temp register
reg signed [31:0]h22[0:m2-1];

reg signed [31:0]h3[0:m3-1];
reg signed [31:0]h33[0:m3-1]; ////here total number of element should be 15 thats why it is 0 t0 m-1   these are temp register

reg signed [31:0]h4[0:n4-1]; ////here total number of element should be 15 thats why it is 0 t0 m-1   these are temp register
reg signed [31:0]h44[0:n4-1];
reg signed [31:0]Final[0:n1-1][0:n4-1];
reg[6:0] i,j,m,i1,j1,i2,j2,j3,i3;  
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////binary to floating converter////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
reg[31:0]floating_out[0:n4-2];///input of the activetion function////////////////////////
reg[31:0]final_output[0:n4-2];///output of the activetion function(sigmaiod function)////
reg [31:0]binery0;
wire [31:0] out_node0;
(* keep_hierarchy = "yes" *)sign_floating sf0(
          .binery1(binery0),
          .floating(out_node0)
);
//////////////////////////////////////
reg [31:0]binery1;
wire [31:0] out_node1;
(* keep_hierarchy = "yes" *)sign_floating sf1(
          .binery1(binery1),
          .floating(out_node1)
);
/////////////////////////////////////
reg [31:0]binery2;
wire [31:0] out_node2;
(* keep_hierarchy = "yes" *)sign_floating sf2(
          .binery1(binery2),
          .floating(out_node2)
);
///////////////////////////////////
reg [31:0]binery3;
wire [31:0] out_node3;
(* keep_hierarchy = "yes" *)sign_floating sf3(
          .binery1(binery3),
          .floating(out_node3)
);
////////////////////////sigmaoid activetion function  module///////////////////////////////////////////
///////////////////////floating point operate only////////////////////////////////////////////////////
reg start_sig;
reg[31:0]x_sig;
wire [31:0]out_sig;
wire sig_done;
(* keep_hierarchy = "yes" *)sigmaiodf #(40) sfg (clk, reset, start_sig, x_sig, out_sig, sig_done);

//////////////////////////////////////////////////////////////////////////////////////////////////////
always @(posedge clk) begin
    if (reset) begin              
        i <= 0;j <= 0;j3<=0;i3<=0;
        i1<=0;j1<=0;m<=0;i2<=0;j2<=0;
        done <= 0;ns <= s1;
    end else begin
        case (ns)
            s0: begin                  
                y_load[m]<=0;  ////////////////////simple initializetion of thre output////////////////////////
                m<=m + 1;
                if (m>=n4) begin 
                   i<=0;
                   j<=0;
                   ns<=s11;end
                end
            s1: begin  
                w1_load[i][j] <= w1; /////////////////// m1*n1 weight matrix//////////5*4 matrix_Ist hiddden layer
                j<= j + 1;
                if (j>=n1 && i < m1) begin
                    j <= 0;
                    i <= i + 1;
                    h1[i]<=0;
                    h11[i]<=0;  
                end else if (i >=m1) begin
                    m<=0;
                    ns <=s2;
                end
            end
            
            s2: begin  
                w2_load[i1][j1]<= w2;  ///////////m2*m1=5*5 weight matrix/////////////////////////2nd hidden layer
                j1 <= j1 + 1;
                if (j1 >= m1 && i1< m2) begin
                    j1 <= 0;
                    i1 <= i1 + 1;
                    h2[i1]<=0;
                    h22[i1]<=0;  
                end else if (i1 >= m2) begin
                    i <= 0;
                    j <= 0;
                    ns <= s3;
                end
            end
              s3: begin   //////////////////////////////m3*m2=5*5 weight matrix//////////////////////3rd hidden layer
                w3_load[i][j] <= w3;  
                j <= j + 1;
                if (j >= m2 && i< m3) begin
                    j <= 0;
                    i <= i + 1;
                    h3[i]<=0; 
                    h33[i]<=0;  
                end else if (i >= m3) begin
                    i1 <= 0;
                    j1 <= 0;
                    ns <= s4;
                end
            end
            
            s4: begin  
                w4_load[i1][j1] <= w4;  /////////////////n4*m3=5*5 weight matrix//////////////////////////////////4Th hidden layer
                j1 <= j1 + 1;
                if (j1 >= m3 && i1< n4) begin
                    j1 <= 0;
                    i1 <= i1 + 1;
                    h4[i1]<=0; 
                    h44[i1]<=0;  
                end else if (i1 >= n4) begin
                    i <= 0;
                    j <= 0;
                    ns <= s5;
                end
            end
            
           s5:  begin 
                xin_load[i][j]<=x;    ////////////////////input nuron matrix////////////////////////////////////////////
                j <= j + 1;
                if (j >= n1 && i< n1) begin
                    j <= 0;
                    i <= i + 1;
                end else if (i >= n1) begin
                    i1 <= 0;
                    j1 <= 0;
                    ns <= s0;
                end
            end
 ///////////////////////////////////////data loading of all the weighted and the input nuroon matrixes are completed//////
 ////This block is very important,row_wise elements are Extracted from the  most compressed matrix or Nuron Matrixe
           s11:  begin 
                x_load[j2]<=xin_load[i2][j2];    ////////////////////input nuron matrix/////////////////////////////n1=4
                j2 <= j2 + 1;                    //// 2nd time we can't use i2 and j2 variables/////////////////////////
                if (j2 >= n4 && i2< n1) begin
                    j2 <= 0;
                    i2 <= i2 + 1;
                    i<=0;
                    j<=0;
                    ns<=s6;
                end else if (i2>= n1) begin
                    ns <= s13;   /// we have to take the decission at last time.
                end
            end
 /////////////////////////////////////////////////////
            s6:begin
                 h1[i]<=w1_load[i][j]*x_load[j];   ////j will be going to 0 t0 9=n1-1  and i will be going to 0 to 14=m1-1
                 h11[i]<=h11[i]+h1[i];
                 j<=j+1;
                 if(j>=n1 && i<m1)begin
                 j<=0;
                 i<=i+1;end
                 else if(i>=m1)begin
                 ns<=s7;end
               end
       
             s7:begin
                 h2[i1]<=w2_load[i1][j1]*h11[j1];   ////j will be going to 0 t0 9=n1-1  and i will be going to 0 to 14=m1-1
                 h22[i1]<=h22[i1]+h2[i1];
                 j1<=j1+1;
                 if(j1>=m1 && i1<m2)begin
                 j1<=0;
                 i1<=i1+1;end
                 else if(i1>=m2)begin
                 i<=0;
                 j<=0;
                 ns<=s8;end
                
               end
       
             s8:begin
                 h3[i]<=w3_load[i][j]*h22[j];   ////j will be going to 0 t0 9=n1-1  and i will be going to 0 to 14=m1-1
                 h33[i]<=h33[i]+h3[i];
                 j<=j+1;
                 if(j>=m2 && i<m3)begin
                 j<=0;
                 i<=i+1;end
                 else if(i>=m3)begin
                 i1<=0;
                 j1<=0;
                 ns<=s9;end
                
               end
           s9:begin
                 h4[i1]<=w3_load[i1][j1]*h33[j1];   ////j will be going to 0 t0 9=n1-1  and i will be going to 0 to 14=m1-1
                 h44[i1]<=h44[i1]+h4[i1];
                 j1<=j1+1;
                 if(j1>=m3 && i1<n4)begin
                 j1<=0;
                 i1<=i1+1;end
                 else if(i1>=n4)begin
                 i<=0;
                 j<=0;
                 ns<=s10;end
               end
         
           s10:  begin 
                Final[i3][j3]<=h44[j3];   
                j3<= j3 + 1;                 
                if (j3 >= n4 && i3< n1) begin
                    j3 <= 0;
                    i3 <= i3+ 1;
                    i1<=0;
                    j1<=0;
                    ns<=s12;
                end else if (i3>= n1) begin
                    ns <= s13;  
                end
            end
//reg signed [31:0]h1[0:m1-1];
//reg signed [31:0]h11[0:m1-1]; 
//reg signed [31:0]h2[0:m2-1];
//reg signed [31:0]h22[0:m2-1]   
//reg signed [31:0]h3[0:m3-1];
//reg signed [31:0]h33[0:m3-1];
//reg signed [31:0]h3[0:m3-1];
//reg signed [31:0]h33[0:m3-1]        
            s12: begin
                 h1[i]<=0;h11[i]<=0;
                 h2[i]<=0;h22[i]<=0;
                 h3[i]<=0;h33[i]<=0;
                 h4[i]<=0;h44[i]<=0;
                 i<=i+1;
                 if(i>=m1)begin
                  ns<=s11;
                 end
            end
            s13:begin
                binery0<=Final[0][1]+433;
                binery1<=Final[1][0]-134;
                binery2<=Final[2][3]-264;
                binery3<=Final[3][1]-280;
                floating_out[0]<=out_node0;
                floating_out[1]<=out_node1;
                floating_out[2]<=out_node2;
                floating_out[3]<=out_node3;
                j1<=j1+1;
                if(j1==2)
                    ns<=s14;
                end
             s14:begin
                start_sig<=1;
                if(start_sig==1)begin
                  x_sig<=floating_out[i1];
                end
                if(sig_done==1)begin
                   ns<=s15;
                end
             end 
             s15:begin
                 start_sig<=0;
                 final_output[i1]<=out_sig;
                 ns<=s14;
                 i1=i1+1;
                 if(i1>3)begin
                   ns<=s16;
                 end
             end  
           s16:begin
               done<=1;
           end     
              
        endcase
    end
end

endmodule 