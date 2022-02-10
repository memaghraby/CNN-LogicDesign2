`timescale 1ns / 1ps
module fp_avg #(parameter DATA_WIDTH=16)
(
    input [0:4*DATA_WIDTH - 1]vector_in,
    output [0:DATA_WIDTH - 1]single_out
);

wire signed[0:2*DATA_WIDTH - 1]avg;

assign avg = $signed(16'h0400) * $signed(vector_in[(0 * DATA_WIDTH) +: DATA_WIDTH] + vector_in[(1 * DATA_WIDTH) +: DATA_WIDTH] + vector_in[(2 * DATA_WIDTH) +: DATA_WIDTH] + vector_in[(3 * DATA_WIDTH) +: DATA_WIDTH]);
assign single_out = avg[4 +: DATA_WIDTH];

endmodule