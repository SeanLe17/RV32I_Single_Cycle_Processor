`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/04/2026 05:13:28 PM
// Design Name: 
// Module Name: rv32i_core
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


module rv32i_core(
    input logic [31:0] instruction,
    input logic clk, reset,
    output logic [31:0] alu_result, branch_imm,
    output logic branch_taken,
    output logic [31:0] debug_x3
    );
    logic [4:0]rs1_addr, rs2_addr, rd_addr;
    logic [3:0] alu_op;
    logic reg_write, valid_instruction, zero, alu_src_imm, branch_condition_taken, branch_enable;
    logic [2:0] branch_op;
    logic [31:0] rs1_data, rs2_data, alu_b, imm_i;
    
    rv32i_decoder decoder(.instruction(instruction),
                          .rs1_addr(rs1_addr),
                          .rs2_addr(rs2_addr),
                          .rd_addr(rd_addr),
                          .reg_write(reg_write),
                          .alu_op(alu_op),
                          .alu_src_imm(alu_src_imm),
                          .branch_enable(branch_enable),
                          .branch_op(branch_op),
                          .valid_instruction(valid_instruction)
                          );
    rv32i_immediate_gen immediate_gen (
        .instruction(instruction),
        .imm_i(imm_i)
    );
    
    rv32i_branch_condition branch (
        .a(rs1_data),
        .b(rs2_data),
        .branch_op(branch_op),
        .branch_taken(branch_condition_taken)
    );
    
    rv32i_branch_immediate_generator branch_immediate(
        .instruction(instruction),
        .imm_b(branch_imm)
        );        

    assign branch_taken = (branch_condition_taken && branch_enable);
    assign alu_b = alu_src_imm ? imm_i : rs2_data;
    
    Register registers(.rs1_addr(rs1_addr),
                       .rs2_addr(rs2_addr),
                       .rd_addr(rd_addr),
                       .clk(clk),
                       .reset(reset),
                       .reg_write(reg_write),
                       .rd_data(alu_result),
                       .rs1_data(rs1_data),
                       .rs2_data(rs2_data),
                       .debug_x3(debug_x3)
                       );
    ALU ALU1(.a(rs1_data),
             .b(alu_b),
             .ALU_OP(alu_op),
             .result(alu_result),
             .zero(zero)
             );         
                      
endmodule
