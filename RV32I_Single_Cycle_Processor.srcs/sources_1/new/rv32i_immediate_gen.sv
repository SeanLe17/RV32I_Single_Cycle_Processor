`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/04/2026 05:34:37 PM
// Design Name: 
// Module Name: rv32i_immediate_gen
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


module rv32i_immediate_gen (
    input  logic [31:0] instruction,
    output logic [31:0] imm_i
);

    always_comb begin
        // I-type immediate: sign-extend instruction[31:20]
        imm_i = {{20{instruction[31]}}, instruction[31:20]};
    end

endmodule
