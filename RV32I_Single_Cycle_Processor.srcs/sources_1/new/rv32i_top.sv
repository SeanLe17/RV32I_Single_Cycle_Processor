module rv32i_top (
    input  logic clk,
    input  logic reset,
    
    output logic [31:0] pc,
    output logic [31:0] instruction,
    output logic [31:0] alu_result, debug_x3
);
    logic [31:0] next_pc, branch_imm;
    logic branch_taken;
    assign next_pc = branch_taken ? pc + branch_imm : pc + 32'd4;
    rv32i_pc counter (
        .clk(clk),
        .reset(reset),
        .next_pc(next_pc),
        .pc(pc)
    );
    rv32i_instruction_memory memory (
        .pc(pc),
        .instruction(instruction)
    );

    rv32i_core core (
        .instruction(instruction),
        .clk(clk),
        .reset(reset),
        .alu_result(alu_result),
        .branch_imm(branch_imm),
        .branch_taken(branch_taken),
        .debug_x3(debug_x3)
    );

endmodule