`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2026 10:53:24 AM
// Design Name: 
// Module Name: rv32i_branch_condition
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


module rv32i_branch_condition(
    input logic [31:0] a,b,
    input logic [2:0] branch_op,
    output logic branch_taken
    );
    localparam logic [2:0]
    BEQ = 3'd0,
    BNE = 3'd1,
    BLT = 3'd2,
    BGE = 3'd3,
    BLTU = 3'd4,
    BGEU = 3'd5;
    
    always_comb begin
        branch_taken  = 1'b0;
        case(branch_op)
        BEQ: branch_taken = (a==b);
        BNE: branch_taken = (a!=b);
        BLT: branch_taken = ($signed(a)<$signed(b));
        BGE: branch_taken = ($signed(a)>=$signed(b));
        BLTU: branch_taken = (a < b);
        BGEU: branch_taken = (a>=b);
        endcase
    end
    
endmodule
