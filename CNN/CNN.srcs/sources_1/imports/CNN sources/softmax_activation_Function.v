`timescale 1ns / 1ps
module softmax_activation_Function#(parameter DATA_WIDTH=16, parameter OUTPUT_COLs=10)
(
    input [0:(DATA_WIDTH*OUTPUT_COLs)-1]matrix_in,
    output [0:(DATA_WIDTH*OUTPUT_COLs)-1]matrix_out
);

wire [0:(DATA_WIDTH*OUTPUT_COLs*2)-1]X2;
wire [0:(DATA_WIDTH*OUTPUT_COLs*2)-1]ConstX2;
wire [0:(DATA_WIDTH*OUTPUT_COLs*2)-1]X3;
wire [0:(DATA_WIDTH*OUTPUT_COLs*2)-1]ConstX3;
wire [0:(DATA_WIDTH*OUTPUT_COLs*2)-1]X4;
wire [0:(DATA_WIDTH*OUTPUT_COLs*2)-1]ConstX4;
wire [0:(DATA_WIDTH*OUTPUT_COLs*2)-1]X5;
wire [0:(DATA_WIDTH*OUTPUT_COLs*2)-1]ConstX5;
wire [0:(DATA_WIDTH*OUTPUT_COLs*2)-1]X6;
wire [0:(DATA_WIDTH*OUTPUT_COLs*2)-1]ConstX6;

genvar i;
generate 
    for (i=0; i < OUTPUT_COLs ; i=i+1)
    begin
        assign X2[(i*2*DATA_WIDTH) +: 2*DATA_WIDTH] = ($signed(matrix_in[(i*DATA_WIDTH) +: DATA_WIDTH]) * $signed(matrix_in[(i*DATA_WIDTH) +: DATA_WIDTH]));
        assign ConstX2[(i*2*DATA_WIDTH) +: 2*DATA_WIDTH] = $signed(X2[(i*2*DATA_WIDTH + 4) +: DATA_WIDTH]) * $signed(16'h0800);
        
        assign X3[(i*2*DATA_WIDTH) +: 2*DATA_WIDTH] = ($signed(X2[(i*2*DATA_WIDTH + 4) +: DATA_WIDTH]) * $signed(matrix_in[(i*DATA_WIDTH) +: DATA_WIDTH]));
        assign ConstX3[(i*2*DATA_WIDTH) +: 2*DATA_WIDTH] = $signed(X3[(i*2*DATA_WIDTH + 4) +: DATA_WIDTH]) * $signed(16'h02AB);        
        
        assign X4[(i*2*DATA_WIDTH) +: 2*DATA_WIDTH] = ($signed(X3[(i*2*DATA_WIDTH + 4) +: DATA_WIDTH]) * $signed(matrix_in[(i*DATA_WIDTH) +: DATA_WIDTH]));
        assign ConstX4[(i*2*DATA_WIDTH) +: 2*DATA_WIDTH] = $signed(X4[(i*2*DATA_WIDTH + 4) +: DATA_WIDTH]) * $signed(16'h00AB);
        
        assign X5[(i*2*DATA_WIDTH) +: 2*DATA_WIDTH] = ($signed(X4[(i*2*DATA_WIDTH + 4) +: DATA_WIDTH]) * $signed(matrix_in[(i*DATA_WIDTH) +: DATA_WIDTH]));
        assign ConstX5[(i*2*DATA_WIDTH) +: 2*DATA_WIDTH] = $signed(X5[(i*2*DATA_WIDTH + 4) +: DATA_WIDTH]) * $signed(16'h0022);
        
        assign X6[(i*2*DATA_WIDTH) +: 2*DATA_WIDTH] = ($signed(X5[(i*2*DATA_WIDTH + 4) +: DATA_WIDTH]) * $signed(matrix_in[(i*DATA_WIDTH) +: DATA_WIDTH]));
        assign ConstX6[(i*2*DATA_WIDTH) +: 2*DATA_WIDTH] = $signed(X6[(i*2*DATA_WIDTH + 4) +: DATA_WIDTH]) * $signed(16'h0006);  
              
        assign matrix_out[(i*DATA_WIDTH) +: DATA_WIDTH] = 16'h1000 + matrix_in[(i*DATA_WIDTH) +: DATA_WIDTH] +
                                                          ConstX2[(i*2*DATA_WIDTH + 4) +: DATA_WIDTH] +
                                                          ConstX3[(i*2*DATA_WIDTH + 4) +: DATA_WIDTH] +
                                                          ConstX4[(i*2*DATA_WIDTH + 4) +: DATA_WIDTH] +
                                                          ConstX5[(i*2*DATA_WIDTH + 4) +: DATA_WIDTH] +
                                                          ConstX6[(i*2*DATA_WIDTH + 4) +: DATA_WIDTH];     
    end
endgenerate

endmodule