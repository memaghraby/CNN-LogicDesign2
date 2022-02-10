`timescale 1ns / 1ps
//test bench for CNN
module CNN_Main_tb;

parameter DATA_WIDTH=16;
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
parameter WEIGHTS_FILE1="C:/Users/Z50/Desktop/CUFE/Logic2/final/CNN/CNN.srcs/Weight Files/weights1.txt";
parameter WEIGHTS_FILE2="C:/Users/Z50/Desktop/CUFE/Logic2/final/CNN/CNN.srcs/Weight Files/weights2.txt";


reg clk, rst, start;
reg [0:(DATA_WIDTH*IMAGE_COLs*IMAGE_COLs)-1]image;
reg [0:(DATA_WIDTH*FILTER_COLs*FILTER_COLs*NO_OF_FILTERs_ONE)-1]filters1;
reg [0:(DATA_WIDTH*FILTER_COLs*FILTER_COLs*NO_OF_FILTERs_TWO)-1]filters2;
reg [0:(DATA_WIDTH*FILTER_COLs*FILTER_COLs*NO_OF_FILTERs_THREE)-1]filters3;
wire [0:(DATA_WIDTH*OUTPUT_COLs_SEVEN)-1]CNN_output;


//display variables
initial
$monitor ("clk = %b, rst = %b, start = %b, image = %h, filters1 = %h, filters2 = %h, filters3 = %h, CNN_output = %h", clk, rst, start, image, filters1, filters2, filters3, CNN_output);

//apply input vectors
initial
begin
   
    clk = 1'b0;	
    rst = 1'b1;

    #10 rst = 1'b0;
    start = 1'b1;
    image = 16384'h0200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200;
    filters1 = 1200'h10000000F0000000100010000000F0000000100010000000F0000000100010000000F0000000100010000000F0000000100010000000F0000000100010000000F0000000100010000000F0000000100010000000F0000000100010000000F0000000100010000000F0000000100010000000F0000000100010000000F0000000100010000000F0000000100010000000F00000001000;
    filters2 = 1200'h10000000F0000000100010000000F0000000100010000000F0000000100010000000F0000000100010000000F0000000100010000000F0000000100010000000F0000000100010000000F0000000100010000000F0000000100010000000F0000000100010000000F0000000100010000000F0000000100010000000F0000000100010000000F0000000100010000000F00000001000;
    filters3 = 1200'h10000000F0000000100010000000F0000000100010000000F0000000100010000000F0000000100010000000F0000000100010000000F0000000100010000000F0000000100010000000F0000000100010000000F0000000100010000000F0000000100010000000F0000000100010000000F0000000100010000000F0000000100010000000F0000000100010000000F00000001000;


    #10 start = 1'b0;

    #500 $stop;

end


always begin
  #5 clk = ~clk;
end

//instantiate the module into the test bench
CNN_Main #(.DATA_WIDTH(DATA_WIDTH), .IMAGE_COLs(IMAGE_COLs), .FILTER_COLs(FILTER_COLs), .NO_OF_FILTERs_ONE(NO_OF_FILTERs_ONE), .OUTPUT_COLs_ONE(OUTPUT_COLs_ONE), .OUTPUT_COLs_TWO(OUTPUT_COLs_TWO), .NO_OF_FILTERs_TWO(NO_OF_FILTERs_TWO), .OUTPUT_COLs_THREE(OUTPUT_COLs_THREE), .OUTPUT_COLs_FOUR(OUTPUT_COLs_FOUR), .NO_OF_FILTERs_THREE(NO_OF_FILTERs_THREE), .OUTPUT_COLs_FIVE(OUTPUT_COLs_FIVE), .OUTPUT_COLs_SIX(OUTPUT_COLs_SIX), .OUTPUT_COLs_SEVEN(OUTPUT_COLs_SEVEN), .WEIGHTS_FILE1(WEIGHTS_FILE1), .WEIGHTS_FILE2(WEIGHTS_FILE2)) inst1 (
.Clk(clk),
.Rst(rst),
.Start(start),
.image(image),
.filters1(filters1),
.filters2(filters2),
.filters3(filters3),
.CNN_output(CNN_output)
);
endmodule