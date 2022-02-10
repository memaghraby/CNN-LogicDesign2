`timescale 1ns / 1ps
module Convolutional_Basic_Processing_Unit #(parameter DATA_WIDTH=16, parameter FILTER_COLs=5) 
(
    input Clk,Rst,
    input [0:(DATA_WIDTH*FILTER_COLs*FILTER_COLs)-1]image_part,
    input [0:(DATA_WIDTH*FILTER_COLs*FILTER_COLs)-1]filter,
    output reg[0:DATA_WIDTH-1]filtered_pixel
);

wire [0:(DATA_WIDTH*FILTER_COLs*FILTER_COLs*2)-1]signal;
wire [0:DATA_WIDTH-1]addition_result;

genvar i;
generate 
    for (i=0; i < FILTER_COLs*FILTER_COLs ; i=i+1)
    begin
        assign signal[(i*2*DATA_WIDTH) +: 2*DATA_WIDTH] = ($signed(image_part[(i*DATA_WIDTH) +: DATA_WIDTH]) * $signed(filter[(i*DATA_WIDTH) +: DATA_WIDTH]));
    end
endgenerate 

assign addition_result = signal[(0*2*DATA_WIDTH + 4) +: DATA_WIDTH] +
                        signal[(1*2*DATA_WIDTH + 4) +: DATA_WIDTH] +
                        signal[(2*2*DATA_WIDTH + 4) +: DATA_WIDTH] +
                        signal[(3*2*DATA_WIDTH + 4) +: DATA_WIDTH] +
                        signal[(4*2*DATA_WIDTH + 4) +: DATA_WIDTH] +
                        signal[(5*2*DATA_WIDTH + 4) +: DATA_WIDTH] +
                        signal[(6*2*DATA_WIDTH + 4) +: DATA_WIDTH] +
                        signal[(7*2*DATA_WIDTH + 4) +: DATA_WIDTH] +
                        signal[(8*2*DATA_WIDTH + 4) +: DATA_WIDTH] +
                        signal[(9*2*DATA_WIDTH + 4) +: DATA_WIDTH] +
                        signal[(10*2*DATA_WIDTH + 4) +: DATA_WIDTH] +
                        signal[(11*2*DATA_WIDTH + 4) +: DATA_WIDTH] +
                        signal[(12*2*DATA_WIDTH + 4) +: DATA_WIDTH] +
                        signal[(13*2*DATA_WIDTH + 4) +: DATA_WIDTH] +
                        signal[(14*2*DATA_WIDTH + 4) +: DATA_WIDTH] +
                        signal[(15*2*DATA_WIDTH + 4) +: DATA_WIDTH] +
                        signal[(16*2*DATA_WIDTH + 4) +: DATA_WIDTH] +
                        signal[(17*2*DATA_WIDTH + 4) +: DATA_WIDTH] +
                        signal[(18*2*DATA_WIDTH + 4) +: DATA_WIDTH] +
                        signal[(19*2*DATA_WIDTH + 4) +: DATA_WIDTH] +
                        signal[(20*2*DATA_WIDTH + 4) +: DATA_WIDTH] +
                        signal[(21*2*DATA_WIDTH + 4) +: DATA_WIDTH] +
                        signal[(22*2*DATA_WIDTH + 4) +: DATA_WIDTH] +
                        signal[(23*2*DATA_WIDTH + 4) +: DATA_WIDTH] +
                        signal[(24*2*DATA_WIDTH + 4) +: DATA_WIDTH];

always @(posedge Clk) begin
    if(Rst == 1'b1) begin
        filtered_pixel = 16'h0000;
    end
    else begin
        filtered_pixel = filtered_pixel + addition_result;
    end
end
                                                          
endmodule