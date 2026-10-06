`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2026 06:55:40 PM
// Design Name: 
// Module Name: immediate_generator_TB
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


module rv32i_immediate_gen_TB;

    logic [31:0] instruction_TB;
    logic [31:0] imm_i_TB;
    int tests_run;

    rv32i_immediate_gen uut (
        .instruction(instruction_TB),
        .imm_i(imm_i_TB)
    );

    function automatic logic [31:0] make_i_instruction (
        input logic signed [11:0] immediate
    );
        make_i_instruction = {
            immediate,
            5'd5,
            3'b000,
            5'd7,
            7'b0010011
        };
    endfunction

    task automatic check_immediate (
        input logic signed [11:0] immediate
    );
        logic [31:0] expected_imm;
    begin
        instruction_TB = make_i_instruction(immediate);
        expected_imm = {{20{immediate[11]}}, immediate};
        #1;

        assert (imm_i_TB === expected_imm)
            else $fatal(1,
                "I-immediate failed: immediate=%0d expected=%h actual=%h",
                immediate,
                expected_imm,
                imm_i_TB
            );

        tests_run++;
    end
    endtask

    initial begin
        tests_run = 0;

        check_immediate(12'sd0);
        check_immediate(12'sd1);
        check_immediate(-12'sd1);
        check_immediate(12'sd2047);
        check_immediate(-12'sd2048);

        for (int i = 0; i < 5000; i++) begin
            check_immediate($urandom);
        end

        $display("");
        $display("========================================");
        $display("   PASS: I-immediate verification completed");
        $display("   Self-checking cases passed: %0d", tests_run);
        $display("========================================");
        $display("");

        $finish;
    end

endmodule
