`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/04/2026 09:47:16 PM
// Design Name: 
// Module Name: rv32i_top_TB
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


module rv32i_top_TB(
    );
    logic clk_TB, reset_TB;
    logic [31:0] pc_TB, instruction_TB, alu_result_TB;
    logic [31:0] x2_TB, x3_TB, x5_TB, x6_TB, x7_TB, x8_TB, x9_TB;
    logic [31:0] x10_TB, x11_TB, x12_TB, x13_TB, x14_TB, x15_TB;
    
        rv32i_top uut(
        .clk(clk_TB),
        .reset(reset_TB),
        .pc(pc_TB),
        .instruction(instruction_TB),
        .alu_result(alu_result_TB)
        );
        
    assign x2_TB  = uut.core.registers.registers[2];
    assign x3_TB  = uut.core.registers.registers[3];
    assign x5_TB  = uut.core.registers.registers[5];
    assign x6_TB  = uut.core.registers.registers[6];
    assign x7_TB  = uut.core.registers.registers[7];
    assign x8_TB  = uut.core.registers.registers[8];
    assign x9_TB  = uut.core.registers.registers[9];
    assign x10_TB = uut.core.registers.registers[10];
    assign x11_TB = uut.core.registers.registers[11];
    assign x12_TB = uut.core.registers.registers[12];
    assign x13_TB = uut.core.registers.registers[13];
    assign x14_TB = uut.core.registers.registers[14];
    assign x15_TB = uut.core.registers.registers[15];
    


    initial begin
        clk_TB = 1'b0;
        forever #5 clk_TB = ~clk_TB;
    end
    
    initial begin
    reset_TB = 1'b1;

    @(posedge clk_TB);
    #1;
    reset_TB = 1'b0;
    repeat (13) begin // test bench needs to let the 4 instructions execute
        @(posedge clk_TB);
        end       
        $finish;
    end        
    
endmodule
