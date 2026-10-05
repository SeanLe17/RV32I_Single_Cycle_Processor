`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/04/2026 03:25:51 PM
// Design Name: 
// Module Name: ALU
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


module ALU(
    input logic [31:0] a, b,
    input logic [3:0] ALU_OP,
    output logic [31:0] result,
    output logic zero
    );
    localparam logic[3:0]
    ALU_ADD  = 4'd0,
    ALU_SUB  = 4'd1,
    ALU_SLL  = 4'd2,
    ALU_SLT  = 4'd3,
    ALU_SLTU = 4'd4,
    ALU_XOR  = 4'd5,
    ALU_SRL  = 4'd6,
    ALU_SRA  = 4'd7,
    ALU_OR   = 4'd8,
    ALU_AND  = 4'd9;
    
    always_comb begin
    result = 32'd0;
    case(ALU_OP)
        ALU_ADD: result = a+b;
        ALU_SUB: result = a-b;
        ALU_SLL: result = a << b[4:0];
        ALU_SLT: result = ($signed(a) < $signed(b));
        ALU_SLTU: result = a < b;
        ALU_XOR: result = a ^ b;
        ALU_SRL: result = a >> b[4:0];
        ALU_SRA: result = $signed(a) >>> b [4:0];
        ALU_OR: result = a | b;
        ALU_AND: result = a & b;
        endcase
    assign zero = (result == 32'd0);
        end
        
endmodule
