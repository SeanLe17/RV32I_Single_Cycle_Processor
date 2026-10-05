`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/04/2026 06:06:53 PM
// Design Name: 
// Module Name: rv32i_pc
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


module rv32i_pc(
    input logic clk, reset,
    input logic[31:0] next_pc,
    output logic [31:0] pc
    );
    always_ff @(posedge clk) begin
        if(reset)
            pc <= 32'd0;
        else
            pc <= next_pc;
    end
endmodule
