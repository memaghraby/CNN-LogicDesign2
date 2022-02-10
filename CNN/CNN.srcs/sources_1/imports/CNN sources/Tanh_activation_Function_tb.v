`timescale 1ns / 1ps
//test bench for tanh activation function
module Tanh_activation_Function_tb;

parameter DATA_WIDTH=16;
parameter NO_OF_FILTERs=2;
parameter OUTPUT_COLs=3;

reg [0:(DATA_WIDTH*OUTPUT_COLs*OUTPUT_COLs*NO_OF_FILTERs)-1]inputs;
wire [0:(DATA_WIDTH*OUTPUT_COLs*OUTPUT_COLs*NO_OF_FILTERs)-1]outputs;


//display variables
initial
$monitor ("inputs = %h, outputs = %h", inputs, outputs);

//apply input vectors
initial
begin

    inputs = 288'h0100F8000300F4000500FC000700FE0009000100F8000300F4000500FC000700FE000900;
    #10 $stop;
    
end


//instantiate the module into the test bench
Tanh_activation_Function inst1 (
.matrix_in(inputs),
.matrix_out(outputs)
);
endmodule
