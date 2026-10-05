`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/04/2026 04:37:25 PM
// Design Name: 
// Module Name: rv32i_decoder
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


module rv32i_decoder(
    input logic [31:0] instruction,
    output logic [4:0] rs1_addr, rs2_addr, rd_addr,
    output logic reg_write, alu_sub, valid_instruction,alu_src_imm
    );
    assign rd_addr = instruction[11:7];
    assign rs1_addr = instruction[19:15];
    assign rs2_addr = instruction[24:20];
    
    always_comb begin 
        // Safe defaults for unsupported instructions
        reg_write = 1'b0;
        alu_sub = 1'b0;
        valid_instruction = 1'b0;
        alu_src_imm = 1'b0;
        if(instruction[6:0] == 7'b0110011 //valid add instruction
        && instruction[14:12] == 3'd0
        && instruction[31:25] == 7'd0) begin
            reg_write = 1'b1;
            alu_sub = 1'b0;
            valid_instruction = 1'b1;
            alu_src_imm = 1'b0;
            end
        else if(instruction[6:0] == 7'b0110011 //valid sub instruction
        && instruction[14:12] == 3'd0
        && instruction[31:25] == 7'b0100000) begin
            reg_write = 1'b1;
            alu_sub = 1'b1;
            valid_instruction = 1'b1;
            alu_src_imm = 1'b0;
            end
        else if (instruction[6:0]   == 7'b0010011 &&
            instruction[14:12] == 3'b000) begin
            reg_write         = 1'b1;
            alu_sub           = 1'b0;
            alu_src_imm       = 1'b1;
            valid_instruction = 1'b1;
        end    
    end
    
endmodule
