`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/04/2026 06:13:07 PM
// Design Name: 
// Module Name: rv32i_pc_TB
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


module rv32i_pc_TB;

    logic clk_TB, reset_TB;
    logic [31:0] next_pc_TB;
    logic [31:0] pc_TB;

    rv32i_pc uut (
        .clk(clk_TB),
        .reset(reset_TB),
        .next_pc(next_pc_TB),
        .pc(pc_TB)
    );

    // 10 ns clock period
    initial begin
        clk_TB = 1'b0;
        forever #5 clk_TB = ~clk_TB;
    end

    initial begin
        // Reset test
        reset_TB = 1'b1;
        next_pc_TB = 32'd99;

        @(posedge clk_TB);
        #1;

        assert (pc_TB == 32'd0)
            else $fatal("Reset failed: PC should equal 0");

        // Normal update: PC becomes 4
        reset_TB = 1'b0;
        next_pc_TB = 32'd4;

        @(posedge clk_TB);
        #1;

        assert (pc_TB == 32'd4)
            else $fatal("PC update failed: PC should equal 4");

        // Normal update: PC becomes 8
        next_pc_TB = 32'd8;

        @(posedge clk_TB);
        #1;

        assert (pc_TB == 32'd8)
            else $fatal("PC update failed: PC should equal 8");

        // Normal update: PC becomes 12
        next_pc_TB = 32'd12;

        @(posedge clk_TB);
        #1;

        assert (pc_TB == 32'd12)
            else $fatal("PC update failed: PC should equal 12");

        $display("All program-counter tests passed.");
        $finish;
    end

endmodule