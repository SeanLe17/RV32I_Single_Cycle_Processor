`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/04/2026 03:29:54 PM
// Design Name: 
// Module Name: ALU_TB
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


module ALU_TB;

    logic [31:0] a_TB, b_TB, result_TB;
    logic [3:0]  ALU_OP_TB;
    logic        zero;
    int tests_run;
    logic [31:0] expected_TB;

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

    ALU dut (
        .a(a_TB),
        .b(b_TB),
        .ALU_OP(ALU_OP_TB),
        .result(result_TB),
        .zero(zero)
    );

    initial begin
        tests_run = 0;

        //ADD
        for(int i = 0; i < 5000; i++) begin
        a_TB = $urandom; 
        b_TB = $urandom; 
        ALU_OP_TB = ALU_ADD;
        #1; 
        assert (result_TB == a_TB + b_TB)
            else $fatal("random ADD case failed");
        tests_run++;
        end

        //SUB
        for(int i = 0; i < 5000; i++) begin
        a_TB = $urandom; 
        b_TB = $urandom; 
        ALU_OP_TB = ALU_SUB;
        #1; 
        assert (result_TB == a_TB - b_TB)
            else $fatal("random SUB case failed");
        tests_run++;
        end

        //SLL
        for(int i = 0; i < 5000; i++) begin
        a_TB = $urandom; 
        b_TB = $urandom; 
        ALU_OP_TB = ALU_SLL;
        #1; 
        assert (result_TB == (a_TB << b_TB[4:0]))
            else $fatal("random SLL case failed");
        tests_run++;
        end

        //SLT
        for(int i = 0; i < 5000; i++) begin
        a_TB = $urandom; 
        b_TB = $urandom; 
        ALU_OP_TB = ALU_SLT;
        #1; 
        assert (result_TB == ($signed(a_TB) < $signed(b_TB)))
            else $fatal("random SLT case failed");
        tests_run++;
        end

        //SLTU
        for(int i = 0; i < 5000; i++) begin
        a_TB = $urandom; 
        b_TB = $urandom; 
        ALU_OP_TB = ALU_SLTU;
        #1; 
        assert (result_TB == (a_TB < b_TB))
            else $fatal("random SLTU case failed");
        tests_run++;
        end

        //XOR
        for(int i = 0; i < 5000; i++) begin
            a_TB = $urandom;
            b_TB = $urandom;
            ALU_OP_TB = ALU_XOR;
            #1;
            assert (result_TB == (a_TB ^ b_TB))
                else $fatal("random XOR case failed");
            tests_run++;
        end

        //SRL
        for(int i = 0; i < 5000; i++) begin
            a_TB = $urandom;
            b_TB = $urandom;
            ALU_OP_TB = ALU_SRL;
            #1;
            assert (result_TB == (a_TB >> b_TB[4:0]))
                else $fatal("random SRL case failed");
            tests_run++;
        end

        //SRA
        for(int i = 0; i < 5000; i++) begin
            a_TB = $urandom;
            b_TB = $urandom;
            ALU_OP_TB = ALU_SRA;
            expected_TB = ($signed(a_TB) >>> b_TB[4:0]);
            #1;
            assert (result_TB == expected_TB)
            else $fatal("random SRL case failed");
            tests_run++;
        end

        //OR
        for(int i = 0; i < 5000; i++) begin
            a_TB = $urandom;
            b_TB = $urandom;
            ALU_OP_TB = ALU_OR;
            #1;
            assert (result_TB == (a_TB | b_TB))
                else $fatal("random OR case failed");
            tests_run++;
        end

        //AND
        for(int i = 0; i < 5000; i++) begin
            a_TB = $urandom;
            b_TB = $urandom;
            ALU_OP_TB = ALU_AND;
            #1;
            assert (result_TB == (a_TB & b_TB))
                else $fatal("random AND case failed");
            tests_run++;
        end

        $display("");
        $display("========================================");
        $display("   PASS: ALU verification completed");
        $display("   Randomized cases passed: %0d", tests_run);
        $display("========================================");
        $display("");

        $finish;
    end

endmodule