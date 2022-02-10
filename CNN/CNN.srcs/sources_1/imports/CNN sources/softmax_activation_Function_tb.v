`timescale 1ns / 1ps
//test bench for softmax activation function
module softmax_activation_Function_tb;

parameter DATA_WIDTH=16;
parameter OUTPUT_COLs=10;

reg [0:(DATA_WIDTH*OUTPUT_COLs)-1]inputs;
wire [0:(DATA_WIDTH*OUTPUT_COLs)-1]outputs;


//display variables
initial
$monitor ("inputs = %h, outputs = %h", inputs, outputs);

//apply input vectors
initial
begin

    inputs = 160'h00000100F80003000400F40006000700F2000900;
    #10 $stop;

end


//instantiate the module into the test bench
softmax_activation_Function inst1 (
.matrix_in(inputs),
.matrix_out(outputs)
);
endmodule
