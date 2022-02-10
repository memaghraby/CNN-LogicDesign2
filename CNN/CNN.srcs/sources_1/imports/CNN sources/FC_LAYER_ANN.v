`timescale 1ns / 1ns
module FC_Layer_ANN(
input_fc,weightCaches_fc,clk,start_FC,output_fc
);

parameter DATA_WIDTH = 16;
parameter parallel_fc_PE= 3;

input [0:DATA_WIDTH-1] input_fc;
input start_FC, clk;
input  [0:(DATA_WIDTH*parallel_fc_PE)-1] weightCaches_fc;
output [0:(DATA_WIDTH*parallel_fc_PE)-1] output_fc;

genvar i;
generate 
	for (i=0; i < parallel_fc_PE; i=i+1) 
	begin :PE 
	PE_FC_ANN #(.DATA_WIDTH(DATA_WIDTH)) PEs (
	 .input_fc   (input_fc),
	 .iweight_FC (weightCaches_fc[DATA_WIDTH*i+:DATA_WIDTH]),
	 .clk(clk),.start_FC(start_FC),
	.output_fc(output_fc[DATA_WIDTH*i+:DATA_WIDTH])
	);
	end
endgenerate 

endmodule