`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2026 06:54:07 PM
// Design Name: 
// Module Name: rv32i_branch_immediate_generator_TB
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

module rv32i_branch_immediate_generator_TB;

    logic [31:0] instruction_TB;
    logic [31:0] imm_b_TB;
    int tests_run;

    rv32i_branch_immediate_generator uut (
        .instruction(instruction_TB),
        .imm_b(imm_b_TB)
    );

    function automatic logic [31:0] make_branch_instruction (
        input logic signed [12:0] offset
    );
        make_branch_instruction = {
            offset[12],
            offset[10:5],
            5'd6,
            5'd5,
            3'b000,
            offset[4:1],
            offset[11],
            7'b1100011
        };
    endfunction

    task automatic check_immediate (
        input logic signed [12:0] offset
    );
        logic [31:0] expected_imm;
    begin
        instruction_TB = make_branch_instruction(offset);
        expected_imm = {{19{offset[12]}}, offset};
        #1;

        assert (imm_b_TB === expected_imm)
            else $fatal(1,
                "B-immediate failed: offset=%0d expected=%h actual=%h",
                offset,
                expected_imm,
                imm_b_TB
            );

        tests_run++;
    end
    endtask

    initial begin
        tests_run = 0;

        check_immediate(13'sd0);
        check_immediate(13'sd4);
        check_immediate(13'sd8);
        check_immediate(-13'sd4);
        check_immediate(-13'sd8);
        check_immediate(13'sd4094);
        check_immediate(-13'sd4096);

        for (int i = 0; i < 5000; i++) begin
            check_immediate(($urandom_range(0, 4095) * 2) - 4096);
        end

        $display("");
        $display("========================================");
        $display("   PASS: B-immediate verification completed");
        $display("   Self-checking cases passed: %0d", tests_run);
        $display("========================================");
        $display("");

        $finish;
    end

endmodule
