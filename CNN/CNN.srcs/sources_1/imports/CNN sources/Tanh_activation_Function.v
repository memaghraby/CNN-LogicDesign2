`timescale 1ns / 1ps
//this module gets tanh the input
module Tanh_activation_Function #(parameter DATA_WIDTH=16, parameter NO_OF_FILTERs=2, parameter OUTPUT_COLs=3)
(
    input [0:(DATA_WIDTH*OUTPUT_COLs*OUTPUT_COLs*NO_OF_FILTERs)-1]matrix_in,
    output [0:(DATA_WIDTH*OUTPUT_COLs*OUTPUT_COLs*NO_OF_FILTERs)-1]matrix_out
);

wire [0:(DATA_WIDTH*OUTPUT_COLs*OUTPUT_COLs*NO_OF_FILTERs*3)-1]X3;
wire [0:(DATA_WIDTH*OUTPUT_COLs*OUTPUT_COLs*NO_OF_FILTERs*2)-1]ConstX3;
wire [0:(DATA_WIDTH*OUTPUT_COLs*OUTPUT_COLs*NO_OF_FILTERs*3)-1]X5;
wire [0:(DATA_WIDTH*OUTPUT_COLs*OUTPUT_COLs*NO_OF_FILTERs*2)-1]ConstX5;
wire [0:(DATA_WIDTH*OUTPUT_COLs*OUTPUT_COLs*NO_OF_FILTERs*3)-1]X7;
wire [0:(DATA_WIDTH*OUTPUT_COLs*OUTPUT_COLs*NO_OF_FILTERs*2)-1]ConstX7;

genvar i;
generate 
    for (i=0; i < OUTPUT_COLs*OUTPUT_COLs*NO_OF_FILTERs ; i=i+1)
    begin
        assign X3[(i*3*DATA_WIDTH) +: 3*DATA_WIDTH] = ($signed(matrix_in[(i*DATA_WIDTH) +: DATA_WIDTH]) * $signed(matrix_in[(i*DATA_WIDTH) +: DATA_WIDTH]) * $signed(matrix_in[(i*DATA_WIDTH) +: DATA_WIDTH]));
        assign ConstX3[(i*2*DATA_WIDTH) +: 2*DATA_WIDTH] = $signed(X3[(i*3*DATA_WIDTH + 8) +: DATA_WIDTH]) * $signed(16'h0555);
        assign X5[(i*3*DATA_WIDTH) +: 3*DATA_WIDTH] = ($signed(X3[(i*3*DATA_WIDTH + 8) +: DATA_WIDTH]) * $signed(matrix_in[(i*DATA_WIDTH) +: DATA_WIDTH]) * $signed(matrix_in[(i*DATA_WIDTH) +: DATA_WIDTH]));
        assign ConstX5[(i*2*DATA_WIDTH) +: 2*DATA_WIDTH] = $signed(X5[(i*3*DATA_WIDTH + 8) +: DATA_WIDTH]) * $signed(16'h0222);        
        assign X7[(i*3*DATA_WIDTH) +: 3*DATA_WIDTH] = ($signed(X5[(i*3*DATA_WIDTH + 8) +: DATA_WIDTH]) * $signed(matrix_in[(i*DATA_WIDTH) +: DATA_WIDTH]) * $signed(matrix_in[(i*DATA_WIDTH) +: DATA_WIDTH]));       
        assign ConstX7[(i*2*DATA_WIDTH) +: 2*DATA_WIDTH] = $signed(X7[(i*3*DATA_WIDTH + 8) +: DATA_WIDTH]) * $signed(16'h00DD);        
        assign matrix_out[(i*DATA_WIDTH) +: DATA_WIDTH] = matrix_in[(i*DATA_WIDTH) +: DATA_WIDTH] - ConstX3[(i*2*DATA_WIDTH + 4) +: DATA_WIDTH] + ConstX5[(i*2*DATA_WIDTH + 4) +: DATA_WIDTH] - ConstX7[(i*2*DATA_WIDTH + 4) +: DATA_WIDTH];        
    end
endgenerate
endmodule
