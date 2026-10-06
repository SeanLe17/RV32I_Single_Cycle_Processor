`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/04/2026 03:42:21 PM
// Design Name: 
// Module Name: Register
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


module Register(
    input logic [4:0] rs1_addr, rs2_addr,
    input clk, reset, reg_write,
    input [4:0] rd_addr,
    input [31:0] rd_data,
    output logic [31:0] rs1_data, rs2_data,
    output logic [31:0] debug_x3
    );
    
    logic [31:0] registers[0:31]; // register bank
    assign debug_x3 = registers[3];
    always_comb begin
        rs1_data = (rs1_addr ==0) ? 5'd0 : registers[rs1_addr];
        rs2_data = (rs2_addr ==0) ? 5'd0 : registers[rs2_addr];
    end
    
    always_ff @(posedge clk) begin
        if(reset) begin
            for(int i = 0; i<32; i++)
                registers[i] <= 32'd0;
                end
        else if(reg_write && rd_addr != 5'd0)
            registers[rd_addr] <= rd_data; 
    end
endmodule
