//

// This is the template for Part 2 of Lab 7.

//

// Paul Chow

// November 2021

//

 
// Part 2 skeleton


module vga(iResetn,keyboard, keyhold, iClock,oX,oY,oColour,oPlot,oDone);

   parameter X_SCREEN_PIXELS = 8'd160;

   parameter Y_SCREEN_PIXELS = 7'd120;

 

   input wire iResetn;
	
	input wire [7:0] keyboard;

   input wire iClock;
	
	input keyhold;

   output wire [7:0] oX;         // VGA pixel coordinates

   output wire [6:0] oY;

   output wire [2:0] oColour;     // VGA pixel colour (0-7)

   output wire oPlot;       // Pixel draw enable

   output wire oDone;       // goes high when finished drawing frame
/*
wire enablex, enabley, enablep, enableb;

wire [7:0]counterx;
wire [6:0]countery;
wire [5:0]counterdraw;

assign oPlot = enablep;
*/


piano p(.SW(keyboard), .keyhold(keyhold), .iResetn(iResetn),.clock(iClock), .oX(oX) , .oY(oY), .oColour(oColour), .oPlot(oPlot), .oDone(oDone));
/*
fsm inst1(.iClock(iClock), .iResetn(iResetn), .iLoadX(iLoadX), .iPlotBox(iPlotBox), .iBlack(iBlack), .CDraw(counterdraw), .xC(counterx), 
	.yC(countery), .controlA(enablex), .controlB(enabley), .controlC(enableb), .oPlot(enablep), .oDone(oDone));

datapath inst2(.iClock(iClock), .iBlack(enableb), .iResetn(iResetn), .ld_x(enablex), .ld_y(enabley), .iPlotBox(enablep), .ctr_x(counterx), .ctr_y(countery), .ctr_D(counterdraw), .iXY_Coord(iXY_Coord), .iColour(iColour), .x_reg(oX), .colour_reg(oColour), .y_reg(oY));
*/ 				


endmodule

 

//add reseta
module piano(SW, keyhold, iResetn, clock, oX,oY, oColour,oPlot,oDone);
	input [7:0]SW;
	input clock, iResetn, keyhold;
	output reg [7:0]oX;
	output reg [6:0]oY;
	output reg oPlot, oDone;
	output reg [2:0]oColour;
	
	reg [7:0]xc;
	reg [6:0]yc;
	
	always @(posedge clock) begin
	
		if(!iResetn) begin
		  xc <= 0;

        yc <= 0;

        oX <= 0;

        oY <= 0;

        oColour <= 0;
		  
		  oPlot <= 0;
		  
		  oDone <= 0;
		end
		else
		begin
			yc <= yc + 1;
			if(yc >= 79)begin
				if(yc == 120) yc <= 79;
				else begin 
					xc <= xc+1;
					if(xc == 180) xc <= 0;
					else begin
						oX <= xc;
						oY <= yc;
						
						oPlot <= 1;
						
						if(yc == 79) oColour <= 3'b111;
						else if(xc%16 == 0) begin
							if(xc == 0 || xc == 48 || xc == 112)oColour <= 3'b000;
							else if(yc > 100) oColour = 3'b000;
						end
						else if(xc >= 14 && xc <= 18 && yc <= 100)begin
							if(SW == 8'b00011110 ) oColour <= 3'b100;
							else oColour <= 3'b000;
						end
						else if(xc >= 30 && xc <= 34 && yc <= 100)begin
							if(SW == 8'b00100110 ) oColour <= 3'b100;
							else oColour <= 3'b000;
						end 
						
						else if(xc >= 62 && xc <= 66 && yc <= 100)begin
							if(SW == 8'b00101110 ) oColour <= 3'b100;
							else oColour <= 3'b000;
						end 
						else if(xc >= 78 && xc <= 82 && yc <= 100)begin
							if(SW == 8'b00110110 ) oColour <= 3'b100;
							else oColour <= 3'b000;
						end 
						else if(xc >= 94 && xc <= 98 && yc <= 100)begin
							if(SW == 8'b00111101) oColour <= 3'b100;
							else oColour <= 3'b000;
						end 
						
						else if(xc >= 126 && xc <= 130 && yc <= 100) begin
							if(SW == 8'b01000110 ) oColour <= 3'b100;
							else oColour <= 3'b000;
						end
						else if(xc >= 142 && xc <= 146 && yc <= 100) begin
							if(SW == 8'b01000101 ) oColour <= 3'b100;
							else oColour <= 3'b000;
						end
						
						else if(xc >= 0 && xc < 16 && SW == 8'b00010101 ) begin oColour <= 3'b100; end
						else if(xc >= 16 && xc < 32 && SW == 8'b00011101 ) begin oColour <= 3'b100; end
						
						else if(xc >= 32 && xc < 48 && SW == 8'b00100100 ) begin oColour <= 3'b100; end
						else if(xc >= 48 && xc < 64 && SW == 8'b00101101 ) begin oColour <= 3'b100; end
						else if(xc >= 64 && xc < 80 && SW == 8'b00101100 ) begin oColour <= 3'b100; end
						
						else if(xc >= 80 && xc < 96 && SW == 8'b00110101 ) begin oColour <= 3'b100; end
						else if(xc >= 96 && xc < 112 && SW == 8'b00111100 ) begin oColour <= 3'b100; end
						
						else if(xc >= 112 && xc < 128  && SW == 8'b01000011 ) begin oColour <= 3'b100; end
						else if(xc >= 128 && xc < 144 && SW == 8'b01000100 ) begin oColour <= 3'b100; end
						else if(xc >= 144 && xc <= 160 && SW == 8'b01001101) begin oColour <= 3'b100; end
						
						else oColour <= 3'b111;
					
					end
				end 
			end 
		end
	end
	

endmodule


 

/*

module fsm(input iClock, input iResetn, input iLoadX, input iPlotBox, input iBlack, input [5:0]CDraw, input [7:0]xC, input [6:0]yC, output reg controlA, 
				output reg controlB, output reg controlC, output reg oPlot, output  reg oDone);

parameter X_SCREEN_PIXELS = 8'd160;

parameter Y_SCREEN_PIXELS = 7'd120;



reg [5:0] current_state, next_state;

 

    localparam 

                S_LOAD_X        = 5'd0,

                S_LOAD_X_WAIT   = 5'd1,

                S_LOAD_Y        = 5'd2,

                S_LOAD_Y_WAIT   = 5'd3,

                S_LOAD_BLACK    = 5'd4,

                S_LOAD_DRAW     = 5'd5,

                KEY_WAIT        = 5'd6;

 

    always @(*)

    begin

        case(current_state)

            KEY_WAIT: begin

                if(iBlack)

                    next_state = S_LOAD_BLACK;

                else if(iLoadX)

                    next_state = S_LOAD_X;

                else

                    next_state = KEY_WAIT;

            end

            S_LOAD_X: begin

                if(iBlack)
					 
						next_state = S_LOAD_BLACK;

                else if(!iLoadX)
					 
						next_state = S_LOAD_X_WAIT;

                else

                    next_state=S_LOAD_X;

            end

            S_LOAD_X_WAIT: next_state = iLoadX ? S_LOAD_X_WAIT : S_LOAD_Y;

            S_LOAD_Y: begin

                if(iBlack) 
							
							next_state = S_LOAD_BLACK; 
						  
                else if(iPlotBox)

                    next_state = S_LOAD_Y_WAIT;

                else

                    next_state=S_LOAD_Y;

            end

            S_LOAD_Y_WAIT: next_state = iPlotBox ? S_LOAD_Y_WAIT : S_LOAD_DRAW;

            S_LOAD_DRAW: begin
					if(iBlack)

						next_state = S_LOAD_BLACK;
							
					else if(CDraw <= 5'b01111)
					
						next_state = S_LOAD_DRAW;

               else

                  next_state = KEY_WAIT;
				end

            S_LOAD_BLACK: begin
				
					if(xC < X_SCREEN_PIXELS && yC < Y_SCREEN_PIXELS) next_state = S_LOAD_BLACK;
					
					else next_state = KEY_WAIT;

				end
				
        default: next_state = KEY_WAIT;
		  

    endcase

end

 

always @(*)

begin

    controlA <= 0;

    controlB <= 0;

    controlC <= 0;

    oPlot <= 0;
	
	 oDone <= 0;
              

    case(current_state)

        S_LOAD_X: begin

            controlA <= 1; //enable x

        end

        S_LOAD_Y: begin

           controlB <= 1; //enable y and color

        end

        S_LOAD_DRAW: begin

				oPlot <= 1; //enable plotting for VGA
				
				if(CDraw == 5'b01111) oDone <= 1;

			end

	  S_LOAD_BLACK: begin

			controlC <= 1;//black screen signal

		end

		endcase

end

always @(posedge iClock)

    begin

    if(!iResetn)

        current_state<=KEY_WAIT;

    else

        current_state<=next_state;

    end

endmodule

 

 

 

module datapath(input iClock, input iBlack, input iResetn, input ld_x, input ld_y, input iPlotBox, input [6:0]iXY_Coord, input [2:0]iColour, 
						output reg [7:0]ctr_x, output reg [6:0]ctr_y, output reg [5:0]ctr_D, output reg [7:0]x_reg, output reg [2:0]colour_reg, output reg [6:0]y_reg);
					
   parameter X_SCREEN_PIXELS = 8'd160;

   parameter Y_SCREEN_PIXELS = 7'd120;
 

reg [7:0]x;

reg [6:0]y;

//reg [2:0]colour;

 

//if both the horizontal and vertical shifts are at the end start at (0,0) again


always @(posedge iClock)
	begin
	if(!iResetn) begin
		  x <= 0;

        y <= 0;

        ctr_x <= 0;

        ctr_y <= 0;
		  
		  ctr_D <= 0;

        x_reg <= 0;

        y_reg <= 0;

        colour_reg <= 0;
	end
	else begin
		if(ld_x) begin
		
			x <= iXY_Coord;
			x_reg <= iXY_Coord;
			
		end
		
		if(ld_y) begin
			y <= iXY_Coord;
			y_reg <= iXY_Coord;
			colour_reg <= iColour;
		end
		
		if(iBlack) begin
			//this is basically a forloop
				if (ctr_x == X_SCREEN_PIXELS && ctr_y != Y_SCREEN_PIXELS) begin
					ctr_x <= 8'b0;
					ctr_y <= ctr_y + 1;
				end
				else begin
					ctr_x <= ctr_x + 1;
				end

            x_reg <= x + ctr_x;
				y_reg <= y + ctr_y;
				colour_reg <= 3'b000;

      end
		
		if(iPlotBox) begin
			if (ctr_D == 6'b010000) ctr_D <= 6'b0;
			
			else ctr_D <= ctr_D + 1;
		
			x_reg <= x + ctr_D[1:0];
			
			y_reg <= y + ctr_D[3:2];
	
		end
	end
end

endmodule
*/
