`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/04/2026 04:13:26 PM
// Design Name: 
// Module Name: Register_TB
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


module Register_TB(
    );
    logic [4:0] rs1_addr_TB, rs2_addr_TB, rd_addr_TB;
    logic clk_TB, reset_TB, reg_write_TB;
    logic [31:0] rd_data_TB, rs1_data_TB, rs2_data_TB;
    
    Register uut(
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
    // Initialize and reset
    reset_TB = 1'b1;
    reg_write_TB = 1'b0;
    rs1_addr_TB = 5'd0;
    rs2_addr_TB = 5'd0;
    rd_addr_TB = 5'd0;
    rd_data_TB = 32'd0;

    // Let reset occur on a rising edge
    @(posedge clk_TB);
    #1;

    rs1_addr_TB = 5'd5;
    #1;
    assert (rs1_data_TB == 32'd0)
        else $fatal("Reset failed: x5 was not zero");

    reset_TB = 1'b0;

    // Test 1: write 10 to x5
    rd_addr_TB = 5'd5;
    rd_data_TB = 32'd10;
    reg_write_TB = 1'b1;

    @(posedge clk_TB);
    #1;
    reg_write_TB = 1'b0;
    rs1_addr_TB = 5'd5;

    #1;
    assert (rs1_data_TB == 32'd10)
        else $fatal("Write/read failed: x5 should equal 10");

    // Test 2: write 99 to x12; read x5 and x12 simultaneously
    rd_addr_TB = 5'd12;
    rd_data_TB = 32'd99;
    reg_write_TB = 1'b1;

    @(posedge clk_TB);
    #1;
    reg_write_TB = 1'b0;

    rs1_addr_TB = 5'd5;
    rs2_addr_TB = 5'd12;

    #1;
    assert (rs1_data_TB == 32'd10)
        else $fatal("Read port 1 failed: x5 should equal 10");

    assert (rs2_data_TB == 32'd99)
        else $fatal("Read port 2 failed: x12 should equal 99");

    // Test 3: writes to x0 must be ignored
    rd_addr_TB = 5'd0;
    rd_data_TB = 32'd123;
    reg_write_TB = 1'b1;

    @(posedge clk_TB);
    #1;
    reg_write_TB = 1'b0;
    rs1_addr_TB = 5'd0;

    #1;
    assert (rs1_data_TB == 32'd0)
        else $fatal("x0 failed: it must always read as zero");

    // Test 4: no write when reg_write is low
    rd_addr_TB = 5'd5;
    rd_data_TB = 32'd777;
    reg_write_TB = 1'b0;

    @(posedge clk_TB);
    #1;
    rs1_addr_TB = 5'd5;

    #1;
    assert (rs1_data_TB == 32'd10)
        else $fatal("Write-enable failed: x5 changed while reg_write was low");

    $display("All register-file tests passed.");
    $finish;
    $finish;
    end    

endmodule
