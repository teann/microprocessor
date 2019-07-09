
module register3b(
            // Output
            q,
            // Inputs
            d, clk, rst, enable
            );

    output [2:0]         q;
    input [2:0]          d;
    input          clk;
    input          rst;
    input          enable;


    dff_stall dff0(.q(q[0]), .d(d[0]), .clk(clk), .rst(rst), .enable(enable)); 
    dff_stall dff1(.q(q[1]), .d(d[1]), .clk(clk), .rst(rst), .enable(enable)); 
    dff_stall dff2(.q(q[2]), .d(d[2]), .clk(clk), .rst(rst), .enable(enable)); 
 
    
endmodule