`timescale 1ns / 1ps
module Parallel_2D_multiplier(
input_fc,clk,start_FC,output_fc,enable,mem_enable
    );

parameter DATA_WIDTH = 16 ;
parameter Parallel_PEs_ROW = 6;
parameter Parallel_PEs_COL = 4;
parameter file = "C:/Users/Z50/Desktop/CUFE/Logic2/final/CNN/CNN.srcs/sources_1/Weight Files/weights1_IEEE.txt";
    
input [0:(DATA_WIDTH*Parallel_PEs_ROW)-1] input_fc;
input start_FC, clk, mem_enable;
output reg enable;
output reg [0:(DATA_WIDTH*Parallel_PEs_COL)-1] output_fc;


wire [0:(DATA_WIDTH*Parallel_PEs_COL)-1] mem_output; 
reg [0:8] address;
wire [0:(DATA_WIDTH*Parallel_PEs_COL)-1] output_fc_wire;

integer i,j;

	weights_Memory #(.file(file),.DATA_WIDTH(DATA_WIDTH),.parallel_fc_PE(Parallel_PEs_ROW),.fc_columns(Parallel_PEs_COL)) WMs (
	   .clk (clk),
	   .address_fc (address),
	   .read_en_MM_fc (1'b1),
	   .dataMainMemo_fc (mem_output),
	   .enable_MM_out_fc (mem_enable)
	);
	
	FC_Layer_ANN #(.DATA_WIDTH(DATA_WIDTH),.parallel_fc_PE(Parallel_PEs_COL)) FCs (
	 .input_fc   (input_fc[DATA_WIDTH*i+:DATA_WIDTH]),
	 .weightCaches_fc (mem_output),
	 .clk(clk),
	 .start_FC(start_FC),
	 .output_fc(output_fc_wire)
	);

always @(posedge clk) begin
	if(start_FC==1'b1) begin
		i=0;
		j=0;
		enable=1'b0;
		output_fc=output_fc_wire;
	end
	else begin
	    if(mem_output[0]!==1'bz) begin
	        if(j==1)begin
                 output_fc=output_fc;
                 enable=1'b0;
            end
            else if(i<Parallel_PEs_ROW) begin
                 i=i+1;
                 enable=1'b0;
                 output_fc=output_fc_wire;
            end
            else begin
                enable=1'b1;
                output_fc=output_fc_wire;
                j=1;
            end
        end
    end
    address=i;
end

endmodule
