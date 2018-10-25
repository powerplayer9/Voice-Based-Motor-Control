module uart_control(
	clk,
	reset_n,

	// rx
	read,
	readdata,
	rdempty,
	//
	uart_clk_25m,
	uart_rx
);

//==============================

input			clk;
input			reset_n;

input			read;
output 	[7:0]	readdata;
output			rdempty;


input			uart_clk_25m;
input			uart_rx;

	
//========= uart rx =====================

//
wire  		rx_fifo_read_ack;
wire [7:0]	rx_fifo_read_data;
wire 		rx_fifo_rdempty;

assign rdempty = rx_fifo_rdempty;	
assign readdata = rx_fifo_read_data;	
assign rx_fifo_read_ack = read;

//
wire [7:0]	rx_fifo_write_data;
wire		rx_fifo_write;
wire 		rx_fifo_wrfull;


//
uart_fifo uart_fifo_rx(
	.aclr(~reset_n),
	// write
	.data(rx_fifo_write_data),
	.wrclk(uart_clk_25m),
	.wrreq(rx_fifo_write),
	.wrfull(rx_fifo_wrfull),
	// read
	.rdclk(clk),
	.rdreq(rx_fifo_read_ack),
	.q(rx_fifo_read_data),
	.rdempty(rx_fifo_rdempty),
	);	  
	

//	
reg 		rx_read;
wire [7:0]	rx_data;
wire		rx_ready;	
always @ (posedge uart_clk_25m or negedge reset_n)
begin
	if (!reset_n)
		rx_read <= 1'b0;
	else if (rx_ready && !rx_fifo_wrfull) // && !rx_read)
		rx_read <= 1'b1;
	else
		rx_read <= 1'b0;
end	


assign rx_fifo_write = rx_read;
assign rx_fifo_write_data = rx_data;

//
	
async_receiver rx(
	.clk(uart_clk_25m), 
	.RxD(uart_rx), 
	.RxD_data_ready(rx_ready), 
	.RxD_data(rx_data), 
	.RxD_endofpacket(), 
	.RxD_idle()
	);


endmodule
