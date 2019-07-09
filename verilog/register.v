
module register (
            // Output
            q,
            // Inputs
            d, clk, rst, enable
            );

    output [15:0]         q;
    input [15:0]          d;
    input          clk;
    input          rst;
    input          enable;


    dff_stall dff0(.q(q[0]), .d(d[0]), .clk(clk), .rst(rst), .enable(enable)); 
    dff_stall dff_stall1(.q(q[1]), .d(d[1]), .clk(clk), .rst(rst), .enable(enable)); 
    dff_stall dff_stall2(.q(q[2]), .d(d[2]), .clk(clk), .rst(rst), .enable(enable)); 
    dff_stall dff3(.q(q[3]), .d(d[3]), .clk(clk), .rst(rst), .enable(enable)); 
    dff_stall dff4(.q(q[4]), .d(d[4]), .clk(clk), .rst(rst), .enable(enable)); 
    dff_stall dff5(.q(q[5]), .d(d[5]), .clk(clk), .rst(rst), .enable(enable)); 
    dff_stall dff6(.q(q[6]), .d(d[6]), .clk(clk), .rst(rst), .enable(enable)); 
    dff_stall dff7(.q(q[7]), .d(d[7]), .clk(clk), .rst(rst), .enable(enable)); 
    dff_stall dff8(.q(q[8]), .d(d[8]), .clk(clk), .rst(rst), .enable(enable)); 
    dff_stall dff9(.q(q[9]), .d(d[9]), .clk(clk), .rst(rst), .enable(enable)); 
    dff_stall dff10(.q(q[10]), .d(d[10]), .clk(clk), .rst(rst), .enable(enable)); 
    dff_stall dff11(.q(q[11]), .d(d[11]), .clk(clk), .rst(rst), .enable(enable)); 
    dff_stall dff12(.q(q[12]), .d(d[12]), .clk(clk), .rst(rst), .enable(enable)); 
    dff_stall dff13(.q(q[13]), .d(d[13]), .clk(clk), .rst(rst), .enable(enable)); 
    dff_stall dff14(.q(q[14]), .d(d[14]), .clk(clk), .rst(rst), .enable(enable)); 
    dff_stall dff15(.q(q[15]), .d(d[15]), .clk(clk), .rst(rst), .enable(enable)); 

endmodule