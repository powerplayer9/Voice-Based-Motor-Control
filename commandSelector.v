module commandSelector(
		input FPGA_CLK1_50,
		input KEY,
		input write,
		input uart_data,
		
		output reg LED,
		output reg [7:0] command

);


always@(posedge FPGA_CLK1_50 or negedge KEY)
begin
  if(!KEY)
    LED <= 0;
  else if(KEY & write)
  begin
    case(uart_data)
	 10'h30:command <= 8'd0;
	 10'h31:command <= 8'd1;
	 10'h32:command <= 8'd2;
	 10'h33:command <= 8'd3;
	 10'h34:command <= 8'd4;
	 10'h35:command <= 8'd5;
	 10'h36:command <= 8'd6;
	 10'h37:command <= 8'd7;
	 10'h38:command <= 8'd8;
	 10'h39:command <= 8'd9;
	 default : command <= command;
	 endcase
	 	 
  end
  else
    LED <= LED;
end

endmodule