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
        // ADD: 10 + 20 = 30
        a_TB = 32'd10; b_TB = 32'd20; ALU_OP_TB = ALU_ADD;
        #1;
        assert (result_TB == 32'd30 && zero == 1'b0)
            else $fatal("ADD failed");

        // SUB: 10 - 20 = -10
        a_TB = 32'd10; b_TB = 32'd20; ALU_OP_TB = ALU_SUB;
        #1;
        assert (result_TB == 32'hFFFF_FFF6 && zero == 1'b0)
            else $fatal("SUB failed");

        // SLL: 1 << 31 = 0x80000000
        a_TB = 32'd1; b_TB = 32'd31; ALU_OP_TB = ALU_SLL;
        #1;
        assert (result_TB == 32'h8000_0000)
            else $fatal("SLL failed");

        // SLT: signed -1 < 1 is true
        a_TB = 32'hFFFF_FFFF; b_TB = 32'd1; ALU_OP_TB = ALU_SLT;
        #1;
        assert (result_TB == 32'd1)
            else $fatal("SLT failed");

        // SLTU: unsigned 0xFFFFFFFF < 1 is false
        a_TB = 32'hFFFF_FFFF; b_TB = 32'd1; ALU_OP_TB = ALU_SLTU;
        #1;
        assert (result_TB == 32'd0)
            else $fatal("SLTU failed");

        // XOR: 1100 XOR 1010 = 0110
        a_TB = 32'hC; b_TB = 32'hA; ALU_OP_TB = ALU_XOR;
        #1;
        assert (result_TB == 32'h6)
            else $fatal("XOR failed");

        // SRL: logical shift fills with zero
        a_TB = 32'h8000_0000; b_TB = 32'd1; ALU_OP_TB = ALU_SRL;
        #1;
        assert (result_TB == 32'h4000_0000)
            else $fatal("SRL failed");

        // SRA: arithmetic shift preserves negative sign
        a_TB = 32'hFFFF_FFF8; b_TB = 32'd2; ALU_OP_TB = ALU_SRA;
        #1;
        assert (result_TB == 32'hFFFF_FFFE)
            else $fatal("SRA failed");

        // OR: 1100 OR 1010 = 1110
        a_TB = 32'hC; b_TB = 32'hA; ALU_OP_TB = ALU_OR;
        #1;
        assert (result_TB == 32'hE)
            else $fatal("OR failed");

        // AND: 1100 AND 1010 = 1000
        a_TB = 32'hC; b_TB = 32'hA; ALU_OP_TB = ALU_AND;
        #1;
        assert (result_TB == 32'h8)
            else $fatal("AND failed");

        // Zero flag
        a_TB = 32'd42; b_TB = 32'd42; ALU_OP_TB = ALU_SUB;
        #1;
        assert (result_TB == 32'd0 && zero == 1'b1)
            else $fatal("Zero flag failed");

        $display("All expanded ALU tests passed.");
        $finish;
    end

endmodule
