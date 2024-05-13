//Sw[7:0] data_in

//KEY[0] synchronous reset when pressed
//KEY[1] go signal

//LEDR displays result
//HEX0 & HEX1 also displays result
module FP(
    input Clock,
    input Reset,
    input Go,
    input [7:0] DataIn, // keys 
	 
    output [7:0] DataResult,
    output ResultValid
);
    // lots of wires to connect our datapath and control
    wire ld_a, ld_b, ld_c, ld_x, ld_r;
    wire ld_alu_out;
    wire [1:0]  alu_select_a, alu_select_b;
    wire alu_op;

    control C0(
        .clk(Clock),
        .Reset(Reset),

        .go(Go),

        .ld_alu_out(ld_alu_out),
        .ld_x(ld_x),
        .ld_a(ld_a),
        .ld_b(ld_b),
        .ld_c(ld_c),
        .ld_r(ld_r),

        .alu_select_a(alu_select_a),
        .alu_select_b(alu_select_b),
        .alu_op(alu_op),
        .result_valid(ResultValid)
    );

    datapath D0(
        .clk(Clock),
        .Reset(Reset),

        .ld_alu_out(ld_alu_out),
        .ld_x(ld_x),
        .ld_a(ld_a),
        .ld_b(ld_b),
        .ld_c(ld_c),
        .ld_r(ld_r),

        .alu_select_a(alu_select_a),
        .alu_select_b(alu_select_b),
        .alu_op(alu_op),

        .data_in(DataIn),
        .data_result(DataResult)
    );

 endmodule


module control(
    input clk,
    input Reset,
    input [6:0]key,
	 input VDone, ADone,
	 
    output reg  Audio,
    output reg  VGABegin, VGASong, VGATile, VGAWrong, VGAUser, VGAEnd
    );

    reg [5:0] current_state, next_state;

    localparam  Begin	        = 5'd0,
                StartS 			  = 5'd1,
                Wait_1        = 5'd2,
                N1			   = 5'd3,
					 End				= 5'd4, 
					 Wrong 			= 5'd5;
         

    // Next state logic aka our state table
    always@(*)
    begin: state_table
            case (current_state)
				    Begin: if(key == 0) next_state = Begin;
							  else next_state = Starts; 

                StartS: next_state = ADone ?  StartS : Wait_1;
					 
                Wait_1: if(key == 0) next_state = Wait_1;
							   else next_state = N1;
					 
                N1 : if(key[2] == 1) next_state =  End;
							else next_state = Wrong;
					 
					 End: next_state = VDone ? End : Begin;
					 
					 Wrong: if(key == 0) next_state = Wrong;
							  else next_state = Begin;

            default:     next_state = Begin;
        endcase
    end // state_table


    // Output logic aka all of our datapath control signals
    always @(*)
    begin: enable_signals
        // By default make all our signals 0
		  
		  Audio = 0;
		  VGABegin = 0, VGASong = 0, VGATile= 0, VGAWrong = 0, VGAUser = 0, VGAEnd= 0;

        case (current_state)
            Begin: begin
                VGABegin = 1; //display starting page
                end
            Starts: begin
                Audio = 1;
					 VGASong = 1;	// display song page
                end
            Wait_1: begin
                VGATile = 1; //display letter/tile
                end
            N1: begin
					 VGAUser
                end
            End: begin // Do A <- A * A
					VGAEnd = 1; //
            end
            Wrong: begin
					VGAVGAIncorrect = 1; // 
					//optional Audio
				end	
        // default:    // don't need default since we already made sure all of our outputs were assigned a value at the start of the always block
        endcase
    end // enable_signals

    // current_state registers
    always@(posedge clk)
    begin: state_FFs
        if(Reset)
            current_state <= Begin;
        else
            current_state <= next_state;
    end // state_FFS
endmodule

module datapath(
    input clk,
    input Reset,
    input [7:0]key,
    input VGA, 
    input Audio,
    );

    // input registers


    // output of the alu


    // Registers a, b, c, x with respective input logic
    always@(posedge clk) begin
        if(Reset) begin
            // set output to 0
        end
        else begin
            if(VGA) //note a lot of vga 
				
            if(Audio) //create a module for each individual tasks
				
				if(VGABegin)
				
				if(VGASong) 
				
				if(VGATile)
				
				if(VGAWrong) 
				
				if(VGAUser)
				
				if(VGAEnd)
               
        end
    end
    

endmodule

module audio();
endmodule

module VGABegin();
module VGASong();
module VGATile();
module VGAWrong();
module VGAUser;
module VGAEnd();

module VGA( output reg [7:0]ctr_x, output reg [6:0]ctr_y);
endmodule
