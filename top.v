module demux(
    input [3:0] CEO,
    input [3:0] Me,
    input [3:0] Fred,
    input [3:0] Jill,
    input Select1, Select0,
    input Enable,
    output reg [3:0] dout
);
    always@ (*)	// include all inputs in the senesitivity list
       begin
            dout = 4'b0000;
       if(Enable == 1)
            begin 
                case ({Select1, Select0})	  // concatinate sel1 with sel0 to make a 2 bit vector
                    2'b00:	dout=CEO;	
                    2'b01:	dout=Me;	
                    2'b10:	dout=Fred;	
                    2'b11:	dout=Jill;
                    default:
                        dout = 4'b0000;	
                endcase
            end
       else
            begin
                dout = 4'b0000;
            end
     end
endmodule

module mux(
    input [3:0] din,
    input select1, select0,
    input enable,
    output reg [3:0] bookhouse,
    output reg [3:0] firehouse,
    output reg [3:0] school,
    output reg [3:0] ribhouse
);
    always @(*) begin
        bookhouse = 4'b0000;
        firehouse = 4'b0000;
        school = 4'b0000;
        ribhouse = 4'b0000;
        if (enable == 1)
            begin
                case({select1, select0})
                    2'b00: bookhouse = din;
                    2'b01: firehouse = din;
                    2'b10: school = din;
                    2'b11: ribhouse = din;
                endcase
            end
        else
            begin
                bookhouse = 4'b0000;
                firehouse = 4'b0000;
                school = 4'b0000;
                ribhouse = 4'b0000; 
            end
     end
endmodule


module top( 	
    input	[15:0] sw,			
    input 	btnL, btnU, btnD, btnR, btnC,		
    output  [15:0] led
    );			
    
    wire[3:0] connection;
        
    demux demultiplexer(
        .CEO(sw[3:0]),
        .Me(sw[7:4]),
        .Fred(sw[11:8]),
        .Jill(sw[15:12]),
        .Select1(btnU),
        .Select0(btnL),
        .Enable(btnC),
        .dout(connection)
    );
    
    mux multiplexer(
        .din(connection),
        .select1(btnR),
        .select0(btnD),
        .enable(btnC),
        .bookhouse(led[3:0]),
        .firehouse(led[7:4]),
        .school(led[11:8]),
        .ribhouse(led[15:12])
    );
    
    
endmodule