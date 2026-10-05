`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/04/2026 04:51:02 PM
// Design Name: 
// Module Name: rv32i_decoder_TB
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


module rv32i_decoder_TB(
    );
    logic [31:0] instruction_TB;
    logic [4:0] rs1_addr_TB, rs2_addr_TB,rd_addr_TB;
    logic reg_write_TB, alu_sub_TB, valid_instruction_TB;
    
    rv32i_decoder uut (
        .instruction(instruction_TB),
        .rs1_addr(rs1_addr_TB),
        .rs2_addr(rs2_addr_TB),
        .rd_addr(rd_addr_TB),
        .reg_write(reg_write_TB),
        .alu_sub(alu_sub_TB),
        .valid_instruction(valid_instruction_TB)
    );
    
initial begin
    // Test 1: add x5, x3, x2
    instruction_TB = 32'h0021_82B3;
    #1;

    assert (rd_addr_TB == 5'd5)
        else $fatal("ADD: wrong rd");

    assert (rs1_addr_TB == 5'd3)
        else $fatal("ADD: wrong rs1");

    assert (rs2_addr_TB == 5'd2)
        else $fatal("ADD: wrong rs2");

    assert (reg_write_TB == 1'b1)
        else $fatal("ADD: reg_write should be 1");

    assert (alu_sub_TB == 1'b0)
        else $fatal("ADD: alu_sub should be 0");

    assert (valid_instruction_TB == 1'b1)
        else $fatal("ADD: instruction should be valid");


    // Test 2: sub x5, x3, x2
    instruction_TB = 32'h4021_82B3;
    #1;

    assert (rd_addr_TB == 5'd5)
        else $fatal("SUB: wrong rd");

    assert (rs1_addr_TB == 5'd3)
        else $fatal("SUB: wrong rs1");

    assert (rs2_addr_TB == 5'd2)
        else $fatal("SUB: wrong rs2");

    assert (reg_write_TB == 1'b1)
        else $fatal("SUB: reg_write should be 1");

    assert (alu_sub_TB == 1'b1)
        else $fatal("SUB: alu_sub should be 1");

    assert (valid_instruction_TB == 1'b1)
        else $fatal("SUB: instruction should be valid");


    // Test 3: unsupported instruction
    instruction_TB = 32'h0000_0013;
    #1;

    assert (reg_write_TB == 1'b0)
        else $fatal("Invalid instruction: reg_write should be 0");

    assert (valid_instruction_TB == 1'b0)
        else $fatal("Invalid instruction should not be valid");

    $display("All decoder tests passed.");
    $finish;
end
endmodule
