`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2026 11:40:10 AM
// Design Name: 
// Module Name: rv32i_branch_immediate_generator
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


module rv32i_branch_immediate_generator(
    input logic [31:0] instruction,
    output logic [31:0] imm_b
    );
    assign imm_b = {
    {19{instruction[31]}},
    instruction[31],
    instruction[7],
    instruction[30:25],
    instruction[11:8],
    1'b0
    };
    
endmodule
