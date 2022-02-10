module weights_Memory (clk,address_fc,read_en_MM_fc ,dataMainMemo_fc,enable_MM_out_fc) ;
parameter DATA_WIDTH = 16;
parameter ADDR_WIDTH = 9 ;
parameter parallel_fc_PE=32;
parameter fc_columns=10; //9216;
parameter tot_weight_size=parallel_fc_PE*fc_columns;//9216*4096;
input clk;
input [0:ADDR_WIDTH-1]          address_fc;
input       read_en_MM_fc,enable_MM_out_fc;
output  reg [0:(DATA_WIDTH*fc_columns-1)]    dataMainMemo_fc;

parameter file = "G:/abotaleb/teaching/logic2/lab7/ANN_Lab/ANN_Lab.srcs/sources_1/new/a.txt";
   
reg signed	[0:DATA_WIDTH-1] mem [0:tot_weight_size-1] ;
integer k;    

always @(negedge clk )
begin
    for(k=0;k < fc_columns;k=k+1)
    begin
        if (enable_MM_out_fc)
             dataMainMemo_fc[k*DATA_WIDTH+:DATA_WIDTH] <= read_en_MM_fc ? mem[(fc_columns*address_fc)+k] : 16'b0;
        else 
             dataMainMemo_fc[k*DATA_WIDTH+:DATA_WIDTH]<=16'bZ;
    end
end

initial begin
  $readmemh(file, mem); // memory_list is memory file


end

endmodule 
