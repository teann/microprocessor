/* $Author: karu $ */
/* $LastChangedDate: 2009-03-04 23:09:45 -0600 (Wed, 04 Mar 2009) $ */
/* $Rev: 45 $ */
// D-flipflop

module dff_stall (q, d, clk, rst, enable);

    output         q;
    input          d;
    input          clk;
    input          rst;
    input          enable;
    
    reg            state;

    assign #(1) q = state;

    always @(posedge clk) begin
      state = rst ? 0 : (enable ? q : d);
    end

endmodule
// DUMMY LINE FOR REV CONTROL :0:
