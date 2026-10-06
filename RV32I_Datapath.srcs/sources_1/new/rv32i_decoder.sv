`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/04/2026 04:37:25 PM
// Design Name: 
// Module Name: rv32i_decoder
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


module rv32i_decoder(
    input logic [31:0] instruction,
    output logic [4:0] rs1_addr, rs2_addr, rd_addr,
    output logic [3:0] alu_op,
    output logic [2:0] branch_op,
    output logic reg_write, valid_instruction,alu_src_imm, branch_enable
    );
    assign rd_addr = instruction[11:7];
    assign rs1_addr = instruction[19:15];
    assign rs2_addr = instruction[24:20];
    
    localparam logic[3:0] //arithmetic 
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
    
    localparam logic [2:0] // branches
    BEQ = 3'd0,
    BNE = 3'd1,
    BLT = 3'd2,
    BGE = 3'd3,
    BLTU = 3'd4,
    BGEU = 3'd5;
    
  
    always_comb begin 
        //Defaults
        reg_write = 1'b0;
        alu_op = ALU_ADD;
        valid_instruction = 1'b0;
        alu_src_imm = 1'b0;
        branch_enable = 1'b0;
        branch_op = BEQ;
        if(instruction[6:0] == 7'b0110011) begin // R type instructions
            case(instruction[14:12]) 
            3'b000: begin
                if(instruction[31:25] == 7'b0000000)begin 
                    alu_op = ALU_ADD;
                    reg_write = 1'b1;
                    valid_instruction = 1'b1;
                    end
                else if(instruction[31:25] == 7'b0100000) begin
                    alu_op = ALU_SUB;
                    reg_write = 1'b1;
                    valid_instruction = 1'b1;
                    end
                end           
            3'b001: begin
                if (instruction[31:25] == 7'b0000000) begin
                    alu_op = ALU_SLL;
                    reg_write = 1'b1;
                    valid_instruction = 1'b1;
                    end
                end
            3'b010: begin
                if (instruction[31:25] == 7'b0000000) begin
                    alu_op = ALU_SLT;
                    reg_write = 1'b1;
                    valid_instruction = 1'b1;
                    end
                end
             3'b011: begin
                if (instruction[31:25] == 7'b0000000) begin
                    alu_op = ALU_SLTU;
                    reg_write = 1'b1;
                    valid_instruction = 1'b1;
                end
            end

            3'b100: begin
                if (instruction[31:25] == 7'b0000000) begin
                    alu_op = ALU_XOR;
                    reg_write = 1'b1;
                    valid_instruction = 1'b1;
                end
            end

            3'b101: begin
                if (instruction[31:25] == 7'b0000000) begin
                    alu_op = ALU_SRL;
                    reg_write = 1'b1;
                    valid_instruction = 1'b1;
                end
                else if (instruction[31:25] == 7'b0100000) begin
                    alu_op = ALU_SRA;
                    reg_write = 1'b1;
                    valid_instruction = 1'b1;
                end
            end

            3'b110: begin
                if (instruction[31:25] == 7'b0000000) begin
                    alu_op = ALU_OR;
                    reg_write = 1'b1;
                    valid_instruction = 1'b1;
                end
            end

            3'b111: begin
                if (instruction[31:25] == 7'b0000000) begin
                    alu_op = ALU_AND;
                    reg_write = 1'b1;
                    valid_instruction = 1'b1;
                end
            end   
        endcase
        end   
        
        else if (instruction[6:0] == 7'b0010011) begin // I-type arithmetic
        case (instruction[14:12])
    
            3'b000: begin // ADDI
                alu_op = ALU_ADD;
                reg_write = 1'b1;
                valid_instruction = 1'b1;
                alu_src_imm = 1'b1;
            end
    
            3'b001: begin // SLLI
                if (instruction[31:25] == 7'b0000000) begin
                    alu_op = ALU_SLL;
                    reg_write = 1'b1;
                    valid_instruction = 1'b1;
                    alu_src_imm = 1'b1;
                end
            end
    
            3'b010: begin // SLTI
                alu_op = ALU_SLT;
                reg_write = 1'b1;
                valid_instruction = 1'b1;
                alu_src_imm = 1'b1;
            end
    
            3'b011: begin // SLTIU
                alu_op = ALU_SLTU;
                reg_write = 1'b1;
                valid_instruction = 1'b1;
                alu_src_imm = 1'b1;
            end
    
            3'b100: begin // XORI
                alu_op = ALU_XOR;
                reg_write = 1'b1;
                valid_instruction = 1'b1;
                alu_src_imm = 1'b1;
            end
    
            3'b101: begin
                if (instruction[31:25] == 7'b0000000) begin // SRLI
                    alu_op = ALU_SRL;
                    reg_write = 1'b1;
                    valid_instruction = 1'b1;
                    alu_src_imm = 1'b1;
                end
                else if (instruction[31:25] == 7'b0100000) begin // SRAI
                    alu_op = ALU_SRA;
                    reg_write = 1'b1;
                    valid_instruction = 1'b1;
                    alu_src_imm = 1'b1;
                end
            end
    
            3'b110: begin // ORI
                alu_op = ALU_OR;
                reg_write = 1'b1;
                valid_instruction = 1'b1;
                alu_src_imm = 1'b1;
            end
    
            3'b111: begin // ANDI
                alu_op = ALU_AND;
                reg_write = 1'b1;
                valid_instruction = 1'b1;
                alu_src_imm = 1'b1;
            end
        endcase
        end
        else if (instruction[6:0] == 7'b1100011) begin // Branches
            case(instruction[14:12])
                3'b000: begin
                branch_op = BEQ;
                branch_enable = 1'b1;
                valid_instruction = 1'b1;
                reg_write = 1'b0;
                end
                
                3'b001: begin
                branch_op = BNE;
                branch_enable = 1'b1;
                valid_instruction = 1'b1;
                reg_write = 1'b0;
                end
                
                3'b100: begin
                branch_op = BLT;
                branch_enable = 1'b1;
                valid_instruction = 1'b1;
                reg_write = 1'b0;
                end
                
                3'b101: begin
                branch_op = BGE;
                branch_enable = 1'b1;
                valid_instruction = 1'b1;
                reg_write = 1'b0;
                end
                
                3'b110: begin
                branch_op = BLTU;
                branch_enable = 1'b1;
                valid_instruction = 1'b1;
                reg_write = 1'b0;
                end
                
                3'b111: begin
                branch_op = BGEU;
                branch_enable = 1'b1;
                valid_instruction = 1'b1;
                reg_write = 1'b0;
                end          
                
            endcase        
        end           
    end
    
endmodule
