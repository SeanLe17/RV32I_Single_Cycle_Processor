`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2026 08:14:22 PM
// Design Name: 
// Module Name: basys_top_TB
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module basys_top_TB(
    );
    logic clk_TB, reset_TB;
    logic [15:0] led_TB;
    
    basys_top uut(
        .clk(clk_TB),
        .reset(reset_TB),
        .led(led_TB)
        );
        
    initial begin
        clk_TB = 1'b0;
        forever #5 clk_TB = ~clk_TB;
    end
    
    initial begin
        reset_TB = 1'b1;

        @(posedge clk_TB);
        #1;
        assert (led_TB == 16'd0)
            else $fatal("Reset failed: LEDs should be zero");

        reset_TB = 1'b0;

        repeat (4) @(posedge clk_TB);
        #1;

        // Change 42 to whatever value x3 should hold
        // after your instruction-memory program executes.
        assert (led_TB == 16'd42)
            else $fatal("LED output failed: expected x3 = 42");

        $display("basys_top test passed.");
        $finish;
    end
endmodule
