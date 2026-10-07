module rv32i_core_TB;

    logic [31:0] instruction_TB;
    logic        clk_TB, reset_TB;
    logic [31:0] alu_result_TB;

    rv32i_core uut (
        .instruction(instruction_TB),
        .clk(clk_TB),
        .reset(reset_TB),
        .alu_result(alu_result_TB)
    );

    // 10 ns clock period
    initial begin
        clk_TB = 1'b0;
        forever #5 clk_TB = ~clk_TB;
    end

    initial begin
        // Reset all CPU registers
        reset_TB = 1'b1;
        instruction_TB = 32'd0;

        @(posedge clk_TB);
        #1;
        reset_TB = 1'b0;


        // Test 1: addi x3, x0, 10
        instruction_TB = 32'h00A0_0193;

        @(posedge clk_TB);
        #1;

        assert (alu_result_TB == 32'd10)
            else $fatal("ADDI 1: ALU result should equal 10");

        assert (uut.registers.registers[3] == 32'd10)
            else $fatal("ADDI 1: x3 should equal 10");


        // Test 2: addi x2, x0, 20
        instruction_TB = 32'h0140_0113;

        @(posedge clk_TB);
        #1;

        assert (alu_result_TB == 32'd20)
            else $fatal("ADDI 2: ALU result should equal 20");

        assert (uut.registers.registers[2] == 32'd20)
            else $fatal("ADDI 2: x2 should equal 20");


        // Test 3: add x5, x3, x2
        // Expected: x5 = 10 + 20 = 30
        instruction_TB = 32'h0021_82B3;

        @(posedge clk_TB);
        #1;

        assert (alu_result_TB == 32'd30)
            else $fatal("ADD: ALU result should equal 30");

        assert (uut.registers.registers[5] == 32'd30)
            else $fatal("ADD: x5 should equal 30");


        // Test 4: sub x6, x2, x3
        // Expected: x6 = 20 - 10 = 10
        instruction_TB = 32'h4031_0333;

        @(posedge clk_TB);
        #1;

        assert (alu_result_TB == 32'd10)
            else $fatal("SUB: ALU result should equal 10");

        assert (uut.registers.registers[6] == 32'd10)
            else $fatal("SUB: x6 should equal 10");


        // Test 5: addi x4, x3, -1
        // Expected: x4 = 10 + (-1) = 9
        instruction_TB = 32'hFFF1_8213;

        @(posedge clk_TB);
        #1;

        assert (alu_result_TB == 32'd9)
            else $fatal("Negative ADDI: ALU result should equal 9");

        assert (uut.registers.registers[4] == 32'd9)
            else $fatal("Negative ADDI: x4 should equal 9");


        // Test 6: unsupported instruction must not change x5
        instruction_TB = 32'h0000_0000;

        @(posedge clk_TB);
        #1;

        assert (uut.registers.registers[5] == 32'd30)
            else $fatal("Invalid instruction incorrectly changed x5");

        $display("All rv32i_core tests passed.");
        $finish;
    end

endmodule