
module PE_FC_ANN 
( input_fc,iweight_FC,clk,start_FC,output_fc
 );
parameter DATA_WIDTH = 16;
input signed[0:DATA_WIDTH-1] input_fc ;
input signed[0:DATA_WIDTH-1] iweight_FC; 
input clk ,start_FC;
output reg[0:DATA_WIDTH-1] output_fc ;

wire signed[0:DATA_WIDTH*2-1] mult;
wire [0:DATA_WIDTH-1] addition;

assign mult = input_fc * iweight_FC;
assign addition = mult[4 +: DATA_WIDTH] + output_fc;

always@(posedge clk)
begin

	if (start_FC==1) 
	begin
			output_fc=32'h00000000;
	end
	else if(iweight_FC==32'hzzzzzzzz) 
	begin
	   output_fc=32'hzzzzzzzz;
	end
	else 
	begin
		output_fc=addition;
	end

end
endmodule