`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2026 11:06:44 AM
// Design Name: 
// Module Name: rv32i_branch_condition_TB
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


module rv32i_branch_condition_TB(
    );
    logic [31:0] a_TB, b_TB;
    logic [2:0] branch_op_TB;
    logic branch_taken_TB;
    int tests_run;
    
    rv32i_branch_condition uut(
        .a(a_TB),
        .b(b_TB),
        .branch_op(branch_op_TB),
        .branch_taken(branch_taken_TB)
        );
    localparam logic [2:0]
    BEQ = 3'd0,
    BNE = 3'd1,
    BLT = 3'd2,
    BGE = 3'd3,
    BLTU = 3'd4,
    BGEU = 3'd5;
        
    initial begin
        //BEQ
        for(int i = 0; i< 5000; i++) begin
        a_TB = $urandom;
        b_TB = $urandom;
        branch_op_TB = BEQ;
        #1;
        assert(branch_taken_TB == (a_TB == b_TB))
            else $fatal("random BEQ failed");
        tests_run++;        
        end
        //BNE
        for(int i = 0; i< 5000; i++) begin
        a_TB = $urandom;
        b_TB = $urandom;
        branch_op_TB = BNE;
        #1;
        assert(branch_taken_TB == (a_TB != b_TB))
            else $fatal("random BNE failed");
        tests_run++;  
        end
        //BLT
        for(int i = 0; i< 5000; i++) begin
        a_TB = $urandom;
        b_TB = $urandom;
        branch_op_TB = BLT;
        #1;
        assert(branch_taken_TB == ($signed(a_TB) < $signed(b_TB)))
            else $fatal("random BLT failed");
        tests_run++;  
        end
        //BGE
        for(int i = 0; i< 5000; i++) begin
        a_TB = $urandom;
        b_TB = $urandom;
        branch_op_TB = BGE;
        #1;
        assert(branch_taken_TB == ($signed(a_TB) >= $signed(b_TB)))
            else $fatal("random BGE failed");
        tests_run++;  
        end
        //BLTU
        for(int i = 0; i< 5000; i++) begin
        a_TB = $urandom;
        b_TB = $urandom;
        branch_op_TB = BLTU;
        #1;
        assert(branch_taken_TB == (a_TB < b_TB))
            else $fatal("random BLTU failed");
        tests_run++;  
        end
        //BGEU
        for(int i = 0; i< 5000; i++) begin
        a_TB = $urandom;
        b_TB = $urandom;
        branch_op_TB = BGEU;
        #1;
        assert(branch_taken_TB == (a_TB >= b_TB))
            else $fatal("random BGEU failed");
        tests_run++;  
        end
        $display("");
        $display("==================================");
        $display("PASS! Branch Condition Verification Complete");
        $display("Randomized cases passed: %0d", tests_run);
        $display("==================================");
        $display("");
        $finish;
    end  
        
endmodule
