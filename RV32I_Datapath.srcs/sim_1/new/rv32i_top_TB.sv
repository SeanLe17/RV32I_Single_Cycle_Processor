`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/04/2026 09:47:16 PM
// Design Name: 
// Module Name: rv32i_top_TB
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


module rv32i_top_TB(
    );
    logic clk_TB, reset_TB;
    logic [31:0] pc_TB, instruction_TB, alu_result_TB;
    
    rv32i_top uut(
        .clk(clk_TB),
        .reset(reset_TB),
        .pc(pc_TB),
        .instruction(instruction_TB),
        .alu_result(alu_result_TB)
        );
        

    initial begin
        clk_TB = 1'b0;
        forever #5 clk_TB = ~clk_TB;
    end
    
    initial begin
    reset_TB = 1'b1;

    @(posedge clk_TB);
    #1;
    reset_TB = 1'b0;
    repeat (4) begin // test bench needs to let the 4 instructions execute
        @(posedge clk_TB);
        end       
        $finish;
    end        
    
endmodule
