
module register2b(
            // Output
            q,
            // Inputs
            d, clk, rst, enable
            );

    output [1:0]         q;
    input [1:0]          d;
    input          clk;
    input          rst;
    input          enable;

    dff_stall dff0(.q(q[0]), .d(d[0]), .clk(clk), .rst(rst), .enable(enable)); 
    dff_stall dff1(.q(q[1]), .d(d[1]), .clk(clk), .rst(rst), .enable(enable)); 
    

endmodule