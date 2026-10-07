`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2026 08:01:13 PM
// Design Name: 
// Module Name: basys_top
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


module basys_top (
    input  logic       clk,
    input  logic       reset,
    output logic [15:0] led
);

    logic [31:0] pc;
    logic [31:0] instruction;
    logic [31:0] alu_result;
    logic [31:0] debug_x3;

    rv32i_top cpu (
        .clk(clk),
        .reset(reset),
        .pc(pc),
        .instruction(instruction),
        .alu_result(alu_result),
        .debug_x3(debug_x3)
    );

    assign led = debug_x3[15:0];

endmodule
