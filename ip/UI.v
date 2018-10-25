module UI(  iClk,iRst_n,iKey,iSW,
				 oAngle, oClock		
			  );

input 		 	  iClk;
input 		 	  iRst_n;
input      [7:0] iKey;		// input key for rith or left
input      [1:0] iSW;		// speed control
output reg [7:0]  oAngle;	// Orientation angle
output reg [7:0]  oClock;	// Orientation angle

`define AdjAngle 5			// base movement step
`define MAX_Angle 180		
`define MIN_Angle 0
reg [2:0] speed;				// ???
reg [7:0] tAngle; // Target Angle
reg [21:0] count;



always@(posedge iClk or negedge iRst_n)
begin
  if(!iRst_n)
	  begin
		 oAngle <= 8'd60; 
		 speed <= 3'b010;
		 count <= 0;
	  end	
  else
	  begin
		 case(iKey) 
	
	
		 // Position Control
		 8'd0:begin
						 tAngle <= 0;				  
				end
		 8'd1:begin
						 tAngle <= 30;				  
				end
		 8'd2:begin
						 tAngle <= 60;				  
				end
		 8'd3:begin
						 tAngle <= 90;				  
				end
		 8'd4:begin
						 tAngle <= 120;				  
				end
		 8'd5:begin
						 tAngle <= 150;				  
				end
		 8'd6:begin
						 tAngle <= 180;				  
				end
				
		 // Speed Control
		 8'd7:begin
						 speed <= 3'b000;				  
				end
		 8'd8:begin
						 speed <= 3'b001;				  
				end
		 8'd9:begin
						 speed <= 3'b111;				  
				end
		 
		 default:begin
						 speed <= 3'b010;
						 tAngle <= 8'd60;
					end
		 endcase
		 
		 
		 
		if (oAngle == tAngle)
		 begin
				oAngle <= tAngle;
		 end
		else if (oAngle < tAngle)
		 begin
			 if(count[21] & (oAngle != `MAX_Angle))
						begin
								count <= 0;
								oAngle <= oAngle + `AdjAngle;
						end
			 else
						count <= count + speed + 1;
		 end
		else if (oAngle > tAngle) 
		 begin
			 if(count[21] & (oAngle != `MIN_Angle))
						begin
								count <= 0;
								oAngle <= oAngle - `AdjAngle;
						end
			 else
						count <= count + speed + 1;
		 end
				
	  end
end

endmodule 