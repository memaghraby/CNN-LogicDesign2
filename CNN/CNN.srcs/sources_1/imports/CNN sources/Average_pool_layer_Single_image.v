`timescale 1ns / 1ps
//This module makes average pooling for one image
module Average_pool_layer_Single_image #(parameter DATA_WIDTH=16, parameter IMAGE_COLs=6, parameter OUTPUT_COLs=3) 
(
    input [0:(DATA_WIDTH*IMAGE_COLs*IMAGE_COLs)-1]image,
    output [0:(DATA_WIDTH*OUTPUT_COLs*OUTPUT_COLs)-1]reduced_image
);

genvar i,j;
generate 
    for (i=0; i < OUTPUT_COLs ; i=i+1) //row
    begin
        for (j=0; j < OUTPUT_COLs ; j=j+1) //column
        begin
            fp_avg  #(.DATA_WIDTH(DATA_WIDTH)) FPAVGs (
                .vector_in({image[(i*2*DATA_WIDTH*IMAGE_COLs + j*2*DATA_WIDTH) +: 2*DATA_WIDTH] , image[((i*2+1)*DATA_WIDTH*IMAGE_COLs + j*2*DATA_WIDTH) +: 2*DATA_WIDTH]}),
                .single_out(reduced_image[((i*DATA_WIDTH*OUTPUT_COLs) + j*DATA_WIDTH) +:DATA_WIDTH])
            );
        end
    end
endgenerate 

endmodule
