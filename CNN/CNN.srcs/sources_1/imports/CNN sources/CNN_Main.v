`timescale 1ns / 1ps
module CNN_Main #(parameter DATA_WIDTH=16, parameter IMAGE_COLs=32, parameter FILTER_COLs=5, parameter NO_OF_FILTERs_ONE=3, parameter OUTPUT_COLs_ONE=28, parameter OUTPUT_COLs_TWO=14, parameter NO_OF_FILTERs_TWO=3, parameter OUTPUT_COLs_THREE=10, parameter OUTPUT_COLs_FOUR=5, parameter NO_OF_FILTERs_THREE=3, parameter OUTPUT_COLs_FIVE=1, parameter OUTPUT_COLs_SIX=3, parameter OUTPUT_COLs_SEVEN=1, 
parameter WEIGHTS_FILE1="C:/Users/Z50/Desktop/CUFE/Logic2/final/CNN/CNN.srcs/Weight Files/weights1.txt",
parameter WEIGHTS_FILE2="C:/Users/Z50/Desktop/CUFE/Logic2/final/CNN/CNN.srcs/Weight Files/weights2.txt")
(
    input Clk,Rst,Start,
    input [0:(DATA_WIDTH*IMAGE_COLs*IMAGE_COLs)-1]image,
    input [0:(DATA_WIDTH*FILTER_COLs*FILTER_COLs*NO_OF_FILTERs_ONE)-1]filters1,
    input [0:(DATA_WIDTH*FILTER_COLs*FILTER_COLs*NO_OF_FILTERs_TWO)-1]filters2,
    input [0:(DATA_WIDTH*FILTER_COLs*FILTER_COLs*NO_OF_FILTERs_THREE)-1]filters3,
    output reg[0:(DATA_WIDTH*OUTPUT_COLs_SEVEN)-1]CNN_output
);

/*
parameter IMAGE_COLs=32;//32
parameter FILTER_COLs=5;
parameter NO_OF_FILTERs_ONE=3;//6
parameter OUTPUT_COLs_ONE=28;//28
parameter OUTPUT_COLs_TWO=14; // One/2
parameter NO_OF_FILTERs_TWO=3;//16
parameter OUTPUT_COLs_THREE=10;//10
parameter OUTPUT_COLs_FOUR=5;// Three/2
parameter NO_OF_FILTERs_THREE=3;//120
parameter OUTPUT_COLs_FIVE=1;//1
parameter OUTPUT_COLs_SIX=3;//84 FC1 Weights 
parameter OUTPUT_COLs_SEVEN=1;//10 FC2 Weights
*/

wire [0:(DATA_WIDTH*OUTPUT_COLs_ONE*OUTPUT_COLs_ONE*NO_OF_FILTERs_ONE)-1]filtered_images_one,tanh_activation_one;
wire [0:(DATA_WIDTH*OUTPUT_COLs_TWO*OUTPUT_COLs_TWO*NO_OF_FILTERs_ONE)-1]reduced_images_one,tanh_activation_two;
wire [0:(DATA_WIDTH*OUTPUT_COLs_THREE*OUTPUT_COLs_THREE*NO_OF_FILTERs_TWO)-1]filtered_images_two,tanh_activation_three;
wire [0:(DATA_WIDTH*OUTPUT_COLs_FOUR*OUTPUT_COLs_FOUR*NO_OF_FILTERs_TWO)-1]reduced_images_two,tanh_activation_four;
wire [0:(DATA_WIDTH*OUTPUT_COLs_FIVE*OUTPUT_COLs_FIVE*NO_OF_FILTERs_THREE)-1]filtered_images_three,tanh_activation_five;
wire [0:(DATA_WIDTH*OUTPUT_COLs_SIX)-1]fc_output1,tanh_activation_six;
wire [0:(DATA_WIDTH*OUTPUT_COLs_SEVEN)-1]fc_output2,softmax_activation;
wire Finish1,Finish2,Finish3,Finish4,Finish5;


reg [0:(DATA_WIDTH*OUTPUT_COLs_ONE*OUTPUT_COLs_ONE*NO_OF_FILTERs_ONE)-1]buffer_tanh_activation_one;
reg [0:(DATA_WIDTH*OUTPUT_COLs_TWO*OUTPUT_COLs_TWO*NO_OF_FILTERs_ONE)-1]buffer_tanh_activation_two;
reg [0:(DATA_WIDTH*OUTPUT_COLs_THREE*OUTPUT_COLs_THREE*NO_OF_FILTERs_TWO)-1]buffer_tanh_activation_three;
reg [0:(DATA_WIDTH*OUTPUT_COLs_FOUR*OUTPUT_COLs_FOUR*NO_OF_FILTERs_TWO)-1]buffer_tanh_activation_four;
reg [0:(DATA_WIDTH*OUTPUT_COLs_FIVE*OUTPUT_COLs_FIVE*NO_OF_FILTERs_THREE)-1]buffer_tanh_activation_five;
reg [0:(DATA_WIDTH*OUTPUT_COLs_SIX)-1]buffer_tanh_activation_six;
reg Start_buffer1,Start_buffer2,Start_buffer3,Start_buffer4,Start_buffer5,Start_buffer6;
///////////////////////////////////////////////////////
Parallel_Convolution_with_Many_Filters #(.DATA_WIDTH(DATA_WIDTH), .IMAGE_COLs(IMAGE_COLs), .FILTER_COLs(FILTER_COLs), .NO_OF_FILTERs(NO_OF_FILTERs_ONE), .OUTPUT_COLs(OUTPUT_COLs_ONE), .NO_OF_IMAGES(1)) ConvOne 
(
    .Clk(Clk),
    .Rst(Rst),
    .Start(Start),
    .image(image),
    .filters(filters1),
    .filtered_images(filtered_images_one),
    .Finish(Finish1)
);
Tanh_activation_Function #(.DATA_WIDTH(DATA_WIDTH), .NO_OF_FILTERs(NO_OF_FILTERs_ONE), .OUTPUT_COLs(OUTPUT_COLs_ONE)) TanhOne
(
    .matrix_in(filtered_images_one),
    .matrix_out(tanh_activation_one)
);
///////////////////////////////////////////////////////
Average_pool_layer #(.DATA_WIDTH(DATA_WIDTH), .IMAGE_COLs(OUTPUT_COLs_ONE), .NO_OF_IMAGES(NO_OF_FILTERs_ONE), .OUTPUT_COLs(OUTPUT_COLs_TWO)) AvgOne
(
    .Clk(Clk),
    .enable(Start_buffer1),
    .images(buffer_tanh_activation_one),
    .reduced_images(reduced_images_one)
);
Tanh_activation_Function #(.DATA_WIDTH(DATA_WIDTH), .NO_OF_FILTERs(NO_OF_FILTERs_ONE), .OUTPUT_COLs(OUTPUT_COLs_TWO)) TanhTwo
(
    .matrix_in(reduced_images_one),
    .matrix_out(tanh_activation_two)
);
///////////////////////////////////////////////////////
Parallel_Convolution_with_Many_Filters #(.DATA_WIDTH(DATA_WIDTH), .IMAGE_COLs(OUTPUT_COLs_TWO), .FILTER_COLs(FILTER_COLs), .NO_OF_FILTERs(NO_OF_FILTERs_TWO), .OUTPUT_COLs(OUTPUT_COLs_THREE), .NO_OF_IMAGES(NO_OF_FILTERs_ONE)) ConvTwo 
(
    .Clk(Clk),
    .Rst(Rst),
    .Start(Start_buffer2),
    .image(buffer_tanh_activation_two),
    .filters(filters2),
    .filtered_images(filtered_images_two),
    .Finish(Finish2)
);
Tanh_activation_Function #(.DATA_WIDTH(DATA_WIDTH), .NO_OF_FILTERs(NO_OF_FILTERs_TWO), .OUTPUT_COLs(OUTPUT_COLs_THREE)) TanhThree
(
    .matrix_in(filtered_images_two),
    .matrix_out(tanh_activation_three)
);
///////////////////////////////////////////////////////
Average_pool_layer #(.DATA_WIDTH(DATA_WIDTH), .IMAGE_COLs(OUTPUT_COLs_THREE), .NO_OF_IMAGES(NO_OF_FILTERs_TWO), .OUTPUT_COLs(OUTPUT_COLs_FOUR)) AvgTwo
(
    .Clk(Clk),
    .enable(Start_buffer3),
    .images(buffer_tanh_activation_three),
    .reduced_images(reduced_images_two)
);
Tanh_activation_Function #(.DATA_WIDTH(DATA_WIDTH), .NO_OF_FILTERs(NO_OF_FILTERs_TWO), .OUTPUT_COLs(OUTPUT_COLs_FOUR)) TanhFour
(
    .matrix_in(reduced_images_two),
    .matrix_out(tanh_activation_four)
);
//////////////////////////////////////////////////////
Parallel_Convolution_with_Many_Filters #(.DATA_WIDTH(DATA_WIDTH), .IMAGE_COLs(OUTPUT_COLs_FOUR), .FILTER_COLs(FILTER_COLs), .NO_OF_FILTERs(NO_OF_FILTERs_THREE), .OUTPUT_COLs(OUTPUT_COLs_FIVE), .NO_OF_IMAGES(NO_OF_FILTERs_TWO)) ConvThree 
(
    .Clk(Clk),
    .Rst(Rst),
    .Start(Start_buffer4),
    .image(buffer_tanh_activation_four),
    .filters(filters3),
    .filtered_images(filtered_images_three),
    .Finish(Finish3)
);
Tanh_activation_Function #(.DATA_WIDTH(DATA_WIDTH), .NO_OF_FILTERs(NO_OF_FILTERs_THREE), .OUTPUT_COLs(OUTPUT_COLs_FIVE)) TanhFive
(
    .matrix_in(filtered_images_three),
    .matrix_out(tanh_activation_five)
);
///////////////////////////////////////////////////////
Parallel_2D_multiplier #(.file(WEIGHTS_FILE1),.DATA_WIDTH(DATA_WIDTH),.Parallel_PEs_ROW(NO_OF_FILTERs_THREE),.Parallel_PEs_COL(OUTPUT_COLs_SIX)) P1 (
    .input_fc (buffer_tanh_activation_five),
    .clk (Clk),
    .start_FC (Start_buffer5),
    .output_fc (fc_output1),
    .enable(Finish4),
    .mem_enable (1'b1)
);
Tanh_activation_Function #(.DATA_WIDTH(DATA_WIDTH), .NO_OF_FILTERs(OUTPUT_COLs_SIX), .OUTPUT_COLs(1)) TanhSix
(
    .matrix_in(fc_output1),
    .matrix_out(tanh_activation_six)
);
///////////////////////////////////////////////////////
Parallel_2D_multiplier #(.file(WEIGHTS_FILE2),.DATA_WIDTH(DATA_WIDTH),.Parallel_PEs_ROW(OUTPUT_COLs_SIX),.Parallel_PEs_COL(OUTPUT_COLs_SEVEN)) P2 (
    .input_fc (buffer_tanh_activation_six),
    .clk (Clk),
    .start_FC (Start_buffer6),
    .output_fc (fc_output2),
    .enable(Finish5),
    .mem_enable (1'b1)
);
softmax_activation_Function#(.DATA_WIDTH(DATA_WIDTH), .OUTPUT_COLs(OUTPUT_COLs_SEVEN)) SoftMax
(
    .matrix_in(fc_output2),
    .matrix_out(softmax_activation)
);
///////////////////////////////////////////////////////

always @(negedge Clk) begin //buffers for pipelining
    if(Rst == 1'b1) begin
        buffer_tanh_activation_one = 0;
        Start_buffer1 = 1'b0;
        buffer_tanh_activation_two = 0;
        Start_buffer2 = 1'b0;
        buffer_tanh_activation_three = 0;
        Start_buffer3 = 1'b0;
        buffer_tanh_activation_four = 0;
        Start_buffer4 = 1'b0;
        buffer_tanh_activation_five = 0;
        Start_buffer5 = 1'b0;
        buffer_tanh_activation_six = 0;
        Start_buffer6 = 1'b0;  
        CNN_output = 0;      
    end
    else begin
        /////////////
        if(Finish5 == 1'b1) begin
            CNN_output = softmax_activation;
        end
        /////////////
        if(Finish4 == 1'b1) begin
            buffer_tanh_activation_six = tanh_activation_six;
        end
        Start_buffer6 = Finish4;
        /////////////
        if(Finish3 == 1'b1) begin
            buffer_tanh_activation_five = tanh_activation_five;
        end
        Start_buffer5 = Finish3; 
        /////////////
        if(Start_buffer3 == 1'b1) begin
            buffer_tanh_activation_four = tanh_activation_four;
        end
        Start_buffer4 = Start_buffer3;    
        /////////////
        if(Finish2 == 1'b1) begin
            buffer_tanh_activation_three = tanh_activation_three;
        end
        Start_buffer3 = Finish2;
        /////////////
        if(Start_buffer1 == 1'b1) begin
            buffer_tanh_activation_two = tanh_activation_two;
        end
        Start_buffer2 = Start_buffer1;
        /////////////
        if(Finish1 == 1'b1) begin
            buffer_tanh_activation_one = tanh_activation_one;
        end
        Start_buffer1 = Finish1;
        /////////////
    end
end
endmodule
