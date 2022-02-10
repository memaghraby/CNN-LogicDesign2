`timescale 1ns / 1ps
//This module makes average pooling for multiple images
module Average_pool_layer #(parameter DATA_WIDTH=16, parameter IMAGE_COLs=10, parameter NO_OF_IMAGES=2, parameter OUTPUT_COLs=5)
(
    input Clk,
    input enable,
    input [0:(DATA_WIDTH*IMAGE_COLs*IMAGE_COLs*NO_OF_IMAGES)-1]images,
    output [0:(DATA_WIDTH*OUTPUT_COLs*OUTPUT_COLs*NO_OF_IMAGES)-1]reduced_images
);


reg [0:(DATA_WIDTH*IMAGE_COLs*IMAGE_COLs*NO_OF_IMAGES)-1]image_signal;

genvar i;
generate 
    for (i=0; i < NO_OF_IMAGES ; i=i+1)
    begin
        Average_pool_layer_Single_image  #(.DATA_WIDTH(DATA_WIDTH),.IMAGE_COLs(IMAGE_COLs),.OUTPUT_COLs(OUTPUT_COLs)) PCWSFs (
            .image(image_signal[(i*DATA_WIDTH*IMAGE_COLs*IMAGE_COLs) +: (DATA_WIDTH*IMAGE_COLs*IMAGE_COLs)]),
            .reduced_image(reduced_images[(i*DATA_WIDTH*OUTPUT_COLs*OUTPUT_COLs) +: (DATA_WIDTH*OUTPUT_COLs*OUTPUT_COLs)])
        );
    end
endgenerate 

always @(posedge Clk) begin
    if(enable == 1'b1) begin
        image_signal = images;
    end
end

endmodule