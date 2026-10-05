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
    output logic [31:0] alu_result
    );
    logic [4:0]rs1_addr, rs2_addr, rd_addr;
    logic reg_write, alu_sub, valid_instruction, zero, alu_src_imm;
    logic [31:0] rs1_data, rs2_data, alu_b, imm_i;
    
    rv32i_decoder decoder(.instruction(instruction),
                          .rs1_addr(rs1_addr),
                          .rs2_addr(rs2_addr),
                          .rd_addr(rd_addr),
                          .reg_write(reg_write),
                          .alu_sub(alu_sub),
                          .alu_src_imm(alu_src_imm),
                          .valid_instruction(valid_instruction)
                          );
    rv32i_immediate_gen immediate_gen (
        .instruction(instruction),
        .imm_i(imm_i)
    );
    
    assign alu_b = alu_src_imm ? imm_i : rs2_data;
    
    Register registers(.rs1_addr(rs1_addr),
                       .rs2_addr(rs2_addr),
                       .rd_addr(rd_addr),
                       .clk(clk),
                       .reset(reset),
                       .reg_write(reg_write),
                       .rd_data(alu_result),
                       .rs1_data(rs1_data),
                       .rs2_data(rs2_data)
                       );
    ALU ALU1(.a(rs1_data),
             .b(alu_b),
             .ALU_SUB(alu_sub),
             .result(alu_result),
             .zero(zero)
             );         
                      
endmodule
