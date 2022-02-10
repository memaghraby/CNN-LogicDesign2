`timescale 1ns / 1ps
module Parallel_Convolution_with_Many_Filters #(parameter DATA_WIDTH=16, parameter IMAGE_COLs=32, parameter FILTER_COLs=5, parameter NO_OF_FILTERs=2, parameter OUTPUT_COLs=28, parameter NO_OF_IMAGES=1) 
(
    input Clk,Rst,Start,
    input [0:(DATA_WIDTH*IMAGE_COLs*IMAGE_COLs*NO_OF_IMAGES)-1]image,
    input [0:(DATA_WIDTH*FILTER_COLs*FILTER_COLs*NO_OF_FILTERs)-1]filters,
    output [0:(DATA_WIDTH*OUTPUT_COLs*OUTPUT_COLs*NO_OF_FILTERs)-1]filtered_images,
    output reg Finish
);
integer j=0;

genvar i;
generate 
    for (i=0; i < NO_OF_FILTERs ; i=i+1)
    begin
        Parallel_Convolution_with_Single_Filter  #(.DATA_WIDTH(DATA_WIDTH),.IMAGE_COLs(IMAGE_COLs),.FILTER_COLs(FILTER_COLs),.OUTPUT_COLs(OUTPUT_COLs)) PCWSFs (
            .Clk(Clk),
            .Rst(Rst),
            .image(image[j*DATA_WIDTH*IMAGE_COLs*IMAGE_COLs +: DATA_WIDTH*IMAGE_COLs*IMAGE_COLs]),
            .filter(filters[(i*DATA_WIDTH*FILTER_COLs*FILTER_COLs) +: (DATA_WIDTH*FILTER_COLs*FILTER_COLs)]),
            .filtered_image(filtered_images[(i*DATA_WIDTH*OUTPUT_COLs*OUTPUT_COLs) +: (DATA_WIDTH*OUTPUT_COLs*OUTPUT_COLs)])
        );
    end
endgenerate 

always @(posedge Clk) begin
    if(Start == 1'b1) begin
        j=1;
    end
    else if (j !== 0 && j < NO_OF_IMAGES) begin
        j=j+1;
    end 
    
    if (j == NO_OF_IMAGES) begin
        Finish = 1'b1;
        j=0;
    end 
    else begin
        Finish = 1'b0;
    end
end

endmodule
