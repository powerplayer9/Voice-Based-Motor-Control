
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module ServoControl(

	//////////// CLOCK //////////
	input 		          		FPGA_CLK1_50,
	input 		          		FPGA_CLK2_50,
	input 		          		FPGA_CLK3_50,

	//////////// KEY //////////
	input 		     [7:0]		KEY,

	//////////// LED //////////
	output		     [7:0]		LED,

	//////////// SW //////////
	input 		     [3:0]		SW,


	//////////// GPIO_1, GPIO connect to GPIO Default //////////
	inout 		    [5:0]		GPIO_1
);


//=======================================================
//  REG/WIRE declarations
//=======================================================
wire [7:0]  Angle;
wire        Pwm_0;
wire        RESET_N;

//=======================================================
//  Structural coding
//=======================================================
assign GPIO_1[0] = Pwm_0;
assign GPIO_1[2] = Pwm_0;
assign GPIO_1[4] = Pwm_0;


assign RESET_N = 1;// ~SW[2];

UI h0(

  .iClk  ( FPGA_CLK1_50 ),
  .iRst_n( RESET_N ),
  .iKey  ( KEY[7:0]),
  .iSW   ( SW[1:0] ),
  .oAngle( Angle   )

);




`define DUR_CLOCK_NUM ( 50000000/50)            // clock count in 20 ms
`define DEGREE_MAX    ( `DUR_CLOCK_NUM*25/200) // 2.5 ms 125000
`define DEGREE_MIN    ( `DUR_CLOCK_NUM*5/200)  // 0.5 ms 25000
wire [31:0] PwmAngle;
assign  PwmAngle = (((`DEGREE_MAX - `DEGREE_MIN)/180)*Angle)+`DEGREE_MIN;


PWM_Geneator p0(
	.clk      ( FPGA_CLK1_50 ),
	.reset_n  ( RESET_N      ),
	//
	.high_dur ( PwmAngle       ),
	.total_dur( `DUR_CLOCK_NUM ),
	//
	.PWM      ( Pwm_0 )
);



endmodule
