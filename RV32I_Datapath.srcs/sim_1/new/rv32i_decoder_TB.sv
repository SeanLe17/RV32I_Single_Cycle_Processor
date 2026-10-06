`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2026 06:47:34 PM
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


`timescale 1ns / 1ps

module rv32i_decoder_TB;

    logic [31:0] instruction_TB;
    logic [4:0] rs1_addr_TB, rs2_addr_TB, rd_addr_TB;
    logic [3:0] alu_op_TB;
    logic [2:0] branch_op_TB;
    logic reg_write_TB, valid_instruction_TB, alu_src_imm_TB, branch_enable_TB;

    int tests_run;

    localparam logic [3:0]
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

    localparam logic [2:0]
        BEQ  = 3'd0,
        BNE  = 3'd1,
        BLT  = 3'd2,
        BGE  = 3'd3,
        BLTU = 3'd4,
        BGEU = 3'd5;

    rv32i_decoder uut (
        .instruction(instruction_TB),
        .rs1_addr(rs1_addr_TB),
        .rs2_addr(rs2_addr_TB),
        .rd_addr(rd_addr_TB),
        .alu_op(alu_op_TB),
        .branch_op(branch_op_TB),
        .reg_write(reg_write_TB),
        .valid_instruction(valid_instruction_TB),
        .alu_src_imm(alu_src_imm_TB),
        .branch_enable(branch_enable_TB)
    );

    function automatic logic [31:0] make_r (
        input logic [6:0] funct7,
        input logic [2:0] funct3
    );
        make_r = {funct7, 5'd6, 5'd5, funct3, 5'd7, 7'b0110011};
    endfunction

    function automatic logic [31:0] make_i (
        input logic [11:0] imm,
        input logic [2:0] funct3
    );
        make_i = {imm, 5'd5, funct3, 5'd7, 7'b0010011};
    endfunction

    function automatic logic [31:0] make_b (
        input logic [2:0] funct3
    );
        make_b = {7'd0, 5'd6, 5'd5, funct3, 5'd0, 7'b1100011};
    endfunction

    task automatic check_decoder (
        input logic [31:0] test_instruction,
        input logic expected_valid,
        input logic expected_reg_write,
        input logic expected_alu_src_imm,
        input logic [3:0] expected_alu_op,
        input logic expected_branch_enable,
        input logic [2:0] expected_branch_op,
        input logic [4:0] expected_rs1,
        input logic [4:0] expected_rs2,
        input logic [4:0] expected_rd
    );
    begin
        instruction_TB = test_instruction;
        #1;

        assert (valid_instruction_TB === expected_valid)
            else $fatal("valid_instruction failed");

        assert (reg_write_TB === expected_reg_write)
            else $fatal("reg_write failed");

        assert (alu_src_imm_TB === expected_alu_src_imm)
            else $fatal("alu_src_imm failed");

        assert (alu_op_TB === expected_alu_op)
            else $fatal("alu_op failed");

        assert (branch_enable_TB === expected_branch_enable)
            else $fatal("branch_enable failed");

        assert (branch_op_TB === expected_branch_op)
            else $fatal("branch_op failed");

        assert (rs1_addr_TB === expected_rs1)
            else $fatal("rs1 address failed");

        assert (rs2_addr_TB === expected_rs2)
            else $fatal("rs2 address failed");

        assert (rd_addr_TB === expected_rd)
            else $fatal("rd address failed");

        tests_run++;
    end
    endtask

    initial begin
        tests_run = 0;

        // R-type
        check_decoder(make_r(7'b0000000, 3'b000), 1, 1, 0, ALU_ADD,  0, BEQ, 5, 6, 7);
        check_decoder(make_r(7'b0100000, 3'b000), 1, 1, 0, ALU_SUB,  0, BEQ, 5, 6, 7);
        check_decoder(make_r(7'b0000000, 3'b001), 1, 1, 0, ALU_SLL,  0, BEQ, 5, 6, 7);
        check_decoder(make_r(7'b0000000, 3'b010), 1, 1, 0, ALU_SLT,  0, BEQ, 5, 6, 7);
        check_decoder(make_r(7'b0000000, 3'b011), 1, 1, 0, ALU_SLTU, 0, BEQ, 5, 6, 7);
        check_decoder(make_r(7'b0000000, 3'b100), 1, 1, 0, ALU_XOR,  0, BEQ, 5, 6, 7);
        check_decoder(make_r(7'b0000000, 3'b101), 1, 1, 0, ALU_SRL,  0, BEQ, 5, 6, 7);
        check_decoder(make_r(7'b0100000, 3'b101), 1, 1, 0, ALU_SRA,  0, BEQ, 5, 6, 7);
        check_decoder(make_r(7'b0000000, 3'b110), 1, 1, 0, ALU_OR,   0, BEQ, 5, 6, 7);
        check_decoder(make_r(7'b0000000, 3'b111), 1, 1, 0, ALU_AND,  0, BEQ, 5, 6, 7);

        // I-type
        check_decoder(make_i(12'h123, 3'b000), 1, 1, 1, ALU_ADD,  0, BEQ, 5, 3, 7);
        check_decoder(make_i(12'h003, 3'b001), 1, 1, 1, ALU_SLL,  0, BEQ, 5, 3, 7);
        check_decoder(make_i(12'h123, 3'b010), 1, 1, 1, ALU_SLT,  0, BEQ, 5, 3, 7);
        check_decoder(make_i(12'h123, 3'b011), 1, 1, 1, ALU_SLTU, 0, BEQ, 5, 3, 7);
        check_decoder(make_i(12'h123, 3'b100), 1, 1, 1, ALU_XOR,  0, BEQ, 5, 3, 7);
        check_decoder(make_i(12'h003, 3'b101), 1, 1, 1, ALU_SRL,  0, BEQ, 5, 3, 7);
        check_decoder(make_i(12'h403, 3'b101), 1, 1, 1, ALU_SRA,  0, BEQ, 5, 3, 7);
        check_decoder(make_i(12'h123, 3'b110), 1, 1, 1, ALU_OR,   0, BEQ, 5, 3, 7);
        check_decoder(make_i(12'h123, 3'b111), 1, 1, 1, ALU_AND,  0, BEQ, 5, 3, 7);

        // Branches
        check_decoder(make_b(3'b000), 1, 0, 0, ALU_ADD, 1, BEQ,  5, 6, 0);
        check_decoder(make_b(3'b001), 1, 0, 0, ALU_ADD, 1, BNE,  5, 6, 0);
        check_decoder(make_b(3'b100), 1, 0, 0, ALU_ADD, 1, BLT,  5, 6, 0);
        check_decoder(make_b(3'b101), 1, 0, 0, ALU_ADD, 1, BGE,  5, 6, 0);
        check_decoder(make_b(3'b110), 1, 0, 0, ALU_ADD, 1, BLTU, 5, 6, 0);
        check_decoder(make_b(3'b111), 1, 0, 0, ALU_ADD, 1, BGEU, 5, 6, 0);

        // Invalid encodings
        check_decoder(make_r(7'b0000001, 3'b000), 0, 0, 0, ALU_ADD, 0, BEQ, 5, 6, 7);
        check_decoder(make_i(12'h023, 3'b001),    0, 0, 0, ALU_ADD, 0, BEQ, 5, 3, 7);
        check_decoder(make_b(3'b010),             0, 0, 0, ALU_ADD, 0, BEQ, 5, 6, 0);
        check_decoder(32'h0000_0000,              0, 0, 0, ALU_ADD, 0, BEQ, 0, 0, 0);

        $display("");
        $display("========================================");
        $display("   PASS: Decoder verification completed");
        $display("   Instruction encodings passed: %0d", tests_run);
        $display("========================================");
        $display("");

        $finish;
    end

endmodule
