`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/04/2026 06:26:33 PM
// Design Name: 
// Module Name: rv32i_instruction_memory
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


module rv32i_instruction_memory(
    input logic [31:0] pc,
    output logic [31:0] instruction
    );
    always_comb begin
        case (pc)
            32'd0:  instruction = 32'h0140_0193; // addi x3, x0, 20
            32'd4:  instruction = 32'h0160_0113; // addi x2, x0, 22
            32'd8:  instruction = 32'h0021_81B3; // add  x3, x3, x2
            32'd12: instruction = 32'h0000_0063; // beq  x0, x0, 0
            default: instruction = 32'h0000_0013; // nop
        endcase 
    end

endmodule
