`timescale 1ns / 1ps
module Parallel_Convolution_with_Single_Filter #(parameter DATA_WIDTH=16, parameter IMAGE_COLs=32, parameter FILTER_COLs=5, parameter OUTPUT_COLs=28) 
(
    input Clk,Rst,
    input [0:(DATA_WIDTH*IMAGE_COLs*IMAGE_COLs)-1]image,
    input [0:(DATA_WIDTH*FILTER_COLs*FILTER_COLs)-1]filter,
    output [0:(DATA_WIDTH*OUTPUT_COLs*OUTPUT_COLs)-1]filtered_image
);

genvar i,j;
generate 
    for (i=0; i < OUTPUT_COLs ; i=i+1) //row
    begin
        for (j=0; j < OUTPUT_COLs ; j=j+1) //column
        begin
            Convolutional_Basic_Processing_Unit  #(.DATA_WIDTH(DATA_WIDTH),.FILTER_COLs(FILTER_COLs)) CBPUs (
                .Clk(Clk),
                .Rst(Rst),
                .image_part({image[(i*DATA_WIDTH*IMAGE_COLs + j*DATA_WIDTH) +: FILTER_COLs*DATA_WIDTH] , image[((i+1)*DATA_WIDTH*IMAGE_COLs + j*DATA_WIDTH) +: FILTER_COLs*DATA_WIDTH] , image[((i+2)*DATA_WIDTH*IMAGE_COLs + j*DATA_WIDTH) +: FILTER_COLs*DATA_WIDTH] , image[((i+3)*DATA_WIDTH*IMAGE_COLs + j*DATA_WIDTH) +: FILTER_COLs*DATA_WIDTH] , image[((i+4)*DATA_WIDTH*IMAGE_COLs + j*DATA_WIDTH) +: FILTER_COLs*DATA_WIDTH]}),
                .filter(filter),
                .filtered_pixel(filtered_image[((i*DATA_WIDTH*OUTPUT_COLs) + j*DATA_WIDTH) +:DATA_WIDTH])
            );
        end
    end
endgenerate 

endmodule

