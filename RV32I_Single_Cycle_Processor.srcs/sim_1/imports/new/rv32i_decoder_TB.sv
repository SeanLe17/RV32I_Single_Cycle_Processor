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

module Register_TB;

    logic [4:0] rs1_addr_TB, rs2_addr_TB, rd_addr_TB;
    logic clk_TB, reset_TB, reg_write_TB;
    logic [31:0] rd_data_TB, rs1_data_TB, rs2_data_TB;

    logic [31:0] expected_registers [0:31];
    int tests_run;

    Register uut (
        .rs1_addr(rs1_addr_TB),
        .rs2_addr(rs2_addr_TB),
        .rd_addr(rd_addr_TB),
        .clk(clk_TB),
        .reset(reset_TB),
        .reg_write(reg_write_TB),
        .rd_data(rd_data_TB),
        .rs1_data(rs1_data_TB),
        .rs2_data(rs2_data_TB)
    );

    initial begin
        clk_TB = 1'b0;
        forever #5 clk_TB = ~clk_TB;
    end

    initial begin
        tests_run = 0;

        reset_TB = 1'b1;
        reg_write_TB = 1'b0;
        rs1_addr_TB = 5'd0;
        rs2_addr_TB = 5'd0;
        rd_addr_TB = 5'd0;
        rd_data_TB = 32'd0;

        @(posedge clk_TB);
        #1;

        for (int i = 0; i < 32; i++) begin
            expected_registers[i] = 32'd0;
            rs1_addr_TB = i;
            #1;

            assert (rs1_data_TB === 32'd0)
                else $fatal("Reset failed: register was not zero");
            tests_run++;
        end

        reset_TB = 1'b0;

        // Verify synchronous write: x5 must not change before a clock edge
        rs1_addr_TB = 5'd5;
        rd_addr_TB = 5'd5;
        rd_data_TB = 32'd10;
        reg_write_TB = 1'b1;
        #1;

        assert (rs1_data_TB === 32'd0)
            else $fatal("Synchronous-write failed: x5 changed before clock edge");
        tests_run++;

        @(posedge clk_TB);
        #1;

        expected_registers[5] = 32'd10;
        reg_write_TB = 1'b0;
        rs1_addr_TB = 5'd5;
        #1;

        assert (rs1_data_TB === 32'd10)
            else $fatal("Write/read failed: x5 should equal 10");
        tests_run++;

        // Verify dual asynchronous reads
        rd_addr_TB = 5'd12;
        rd_data_TB = 32'd99;
        reg_write_TB = 1'b1;

        @(posedge clk_TB);
        #1;

        expected_registers[12] = 32'd99;
        reg_write_TB = 1'b0;
        rs1_addr_TB = 5'd5;
        rs2_addr_TB = 5'd12;
        #1;

        assert (rs1_data_TB === 32'd10)
            else $fatal("Read port 1 failed");
        tests_run++;

        assert (rs2_data_TB === 32'd99)
            else $fatal("Read port 2 failed");
        tests_run++;

        // Verify x0 cannot be overwritten
        rd_addr_TB = 5'd0;
        rd_data_TB = 32'd123;
        reg_write_TB = 1'b1;

        @(posedge clk_TB);
        #1;

        reg_write_TB = 1'b0;
        rs1_addr_TB = 5'd0;
        #1;

        assert (rs1_data_TB === 32'd0)
            else $fatal("x0 failed: it must always read as zero");
        tests_run++;

        // Verify reg_write = 0 prevents a write
        rd_addr_TB = 5'd5;
        rd_data_TB = 32'd777;
        reg_write_TB = 1'b0;

        @(posedge clk_TB);
        #1;

        rs1_addr_TB = 5'd5;
        #1;

        assert (rs1_data_TB === 32'd10)
            else $fatal("Write-enable failed: x5 changed while reg_write was low");
        tests_run++;

        // Randomized writes and dual asynchronous reads
        for (int i = 0; i < 5000; i++) begin
            rd_addr_TB = $urandom_range(1, 31);
            rd_data_TB = $urandom;
            reg_write_TB = 1'b1;

            @(posedge clk_TB);
            #1;

            expected_registers[rd_addr_TB] = rd_data_TB;

            rs1_addr_TB = $urandom_range(0, 31);
            rs2_addr_TB = $urandom_range(0, 31);
            #1;

            assert (rs1_data_TB === expected_registers[rs1_addr_TB])
                else $fatal("Random read-port-1 test failed");
            tests_run++;

            assert (rs2_data_TB === expected_registers[rs2_addr_TB])
                else $fatal("Random read-port-2 test failed");
            tests_run++;
        end

        reg_write_TB = 1'b0;

        $display("");
        $display("========================================");
        $display("   PASS: Register-file verification completed");
        $display("   Self-checking cases passed: %0d", tests_run);
        $display("========================================");
        $display("");

        $finish;
    end

endmodule
