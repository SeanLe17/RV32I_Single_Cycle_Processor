module rv32i_top (
    input  logic        clk,
    input  logic        reset,

    output logic [31:0] pc,
    output logic [31:0] instruction,
    output logic [31:0] alu_result
);
    logic [31:0] next_pc;
    assign next_pc = pc + 32'd4;
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
        .alu_result(alu_result)
    );

endmodule